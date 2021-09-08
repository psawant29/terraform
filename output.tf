output "instance_id" {
  description = "List of IDs of instances"
  value       = aws_instance.test.*.id
}

output "private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value       = aws_instance.test.*.private_ip
}

output "instance_state" {
  description = "List of instance states of instances"
  value       = aws_instance.test.*.instance_state
}

output "elb_id" {
  description = "The name of the ELB"
  value       = aws_elb.test.id
}

output "elb_name" {
  description = "The name of the ELB"
  value       = aws_elb.test.name
}

output "elb_dns_name" {
  description = "The DNS name of the ELB"
  value       = aws_elb.test.dns_name
}

output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.mydb.address
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.mydb.endpoint
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.mydb.username
  sensitive   = true
}
