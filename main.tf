##############################################################
# AWS provider
##############################################################
provider "aws" {
  region = "ap-south-1"
}

##############################################################
# Data sources to get VPC, subnets and security group details
##############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

locals {
  master_password = random_password.master_password.result
}

##############################################################
# Resources VM ,LB and SQL cloud service
##############################################################

resource "aws_instance" "test" {
  count = var.instance_count

  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.all.ids), 0)
  associate_public_ip_address = false

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

resource "aws_elb" "test" {
  depends_on = [aws_instance.test]

  name            = var.elb_name
  subnets         = data.aws_subnet_ids.all.ids
  security_groups = [data.aws_security_group.default.id]
  internal        = var.internal

  dynamic "listener" {
    for_each = var.listener
    content {
      instance_port      = listener.value.instance_port
      instance_protocol  = listener.value.instance_protocol
      lb_port            = listener.value.lb_port
      lb_protocol        = listener.value.lb_protocol
      ssl_certificate_id = lookup(listener.value, "ssl_certificate_id", null)
    }
  }
}

resource "aws_elb_attachment" "test" {
  depends_on = [aws_elb.test]

  count = var.create_attachment ? var.instance_count : 0

  elb      = var.elb_name
  instance = element(aws_instance.test.*.id, count.index)
}

# Random string to use as master password
resource "random_password" "master_password" {
  length  = var.random_password_length
  special = true
}

resource "aws_db_instance" "mydb" {
  depends_on = [random_password.master_password]

  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  name                    = var.db_name
  username                = var.username
  password                = local.master_password
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  storage_encrypted       = true
}
