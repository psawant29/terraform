variable "instance_count" {
  description = "Number of instances to create and attach to ELB"
  type        = number
  default     = 2
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
  default     = "ami-003b12a9a1ee83922"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "internal" {
  description = "Set to make ELB as internal ELB"
  type        = bool
  default     = true
}

variable "elb_name" {
  description = "Name to be used on all resources as prefix"
  type        = string
  default     = "elb-test"
}

variable "listener" {
  description = "A list of listener blocks"
  type        = list(map(string))
  default = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    }
  ]
}

variable "create_attachment" {
  description = "Create the elb attachment or not"
  type        = bool
  default     = true
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 10
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "mysql"
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = "10"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "5.7"
}

variable "skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The DB name to create"
  type        = string
  default     = "mydb"
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
  default     = "test"
}

variable "random_password_length" {
  description = "Length of random password to create"
  type        = number
  default     = 16
}
