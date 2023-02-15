#vpc
aws_region                   = "us-east-1"
vpc_cidr                     = "10.0.0.0/16"
public_subnet_cidrs          = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs         = ["10.0.2.0/24", "10.0.3.0/24"]
private_data_subnet_cidrs    = ["10.0.4.0/24", "10.0.5.0/24"]

#security groups
anyware_cidr_range           = "0.0.0.0/0"
ssh_cidr_range               = "0.0.0.0/0"

#nginx
nginx_instances_count        = 2
ami                          = "ami-00f498a2a0d1b7cef"
instance_type                = "t3.micro"
ebs_type                     = "gp2"
ebs_size                     = "10"

#rds
rds_instances_count           = 2


