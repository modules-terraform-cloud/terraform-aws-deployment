# vpc outputs

output "region" {
   value = var.aws_region
}

output "vpc_id" {
   value = module.vpc.vpc_id
}

output "igw" {
   value = module.vpc.igw
}

output "eip_nat" {
   value = module.vpc.eip_nat
}

output "nat_gw" {
   value = module.vpc.nat_gw
}

output "availability_zones_names" {
   value = module.vpc.availability_zones_names
}

output "public_subnet_id" {
   value = module.vpc.public_subnet_id
}

output "private_subnet_id" {
   value = module.vpc.private_subnet_id
}

output "private_data_subnet_id" {
   value = module.vpc.private_data_subnet_id
}


# Security groups outputs

output "alb_security_group_id" {
   value = module.sg.alb_security_group_id
}

output "ssh_security_group_id" {
   value = module.sg.ssh_security_group_id
}

output "public_security_group_id" {
   value = module.sg.public_security_group_id
}

output "private_security_group_id" {
   value = module.sg.private_security_group_id
}


# nginx ec2 outputs
output "instance_nginx_id" {
   value = module.nginx.instance_nginx_id
}


# alb outputs

output "alb_target_group_arn" {
   value = module.alb.alb_target_group_arn
}

output "application_load_balancer_arn" {
   value = module.alb.application_load_balancer_arn
}


# rds database outputs

output "rds_subnet_group_id" {
   value = module.rds.rds_subnet_group_id
}

output "rds_instance_id" {
   value = module.rds.rds_instance_id
}


# 3 bucket outputs

output "s3_alb_logs_id" {
   value = module.s3_bucket.s3_alb_logs_id
}

output "s3_access_logs_policy_id" {
   value = module.s3_bucket.s3_access_logs_policy_id
}

output "s3_acl" {
   value = module.s3_bucket.s3_acl
}

output "s3_versioning" {
   value = module.s3_bucket.s3_versioning
}

output "s3_logging" {
   value = module.s3_bucket.s3_logging
}


# iam outputs

output "ec2_iam_role_policy_name" {
   value = module.iam.ec2_iam_role_policy_name
}

output "ec2_iam_role_name" {
   value = module.iam.ec2_iam_role_name
}

output "ec2_iam_profile_name" {
   value = module.iam.ec2_iam_profile_name
}

output "s3_iam_role_policy_name" {
   value = module.iam.s3_iam_role_policy_name
}

output "s3_iam_role_name" {
   value = module.iam.s3_iam_role_name
}

output "s3_iam_profile_name" {
   value = module.iam.s3_iam_profile_name
}