## Prerequisites 

- AWS CLI should be configured
- Need to specify SSLCertificateId for secure listeners port

## Resources Created 
Creates AWS instances based on number of instances specified by user
Deploys AWS RDS resource for mysql database
Created load balancer with exposed ports 80 and 443
Adds deployed instances to load balancer

## References
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#metadata-options
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#storage_encrypted
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb