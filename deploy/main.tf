# Saving the state in terraform cloud
terraform {
  cloud {
    organization   = "goddessdiana"
    
    workspaces {
      name         = "cloud_assignment"
    }
  }
}

# Authenticatin to AWS provider
provider "aws" {
  region           = var.aws_region
}



# Create vpc
module "vpc" {
  source  = "app.terraform.io/goddessdiana/vpc/aws"
  version = "1.0.0"
  # insert required variables here
  aws_region                   = var.aws_region
  vpc_cidr                     = var.vpc_cidr
  public_subnet_cidrs          = var.public_subnet_cidrs
  private_subnet_cidrs         = var.private_subnet_cidrs
  private_data_subnet_cidrs    = var.private_data_subnet_cidrs
  anyware_cidr_range           = var.anyware_cidr_range
  ssh_cidr_range               = var.ssh_cidr_range
}


#Create security groups
module "sg" {
  source                       = "git::https://github.com/DianaCohen/terraform_cloud.git//modules/sg"
  vpc_id                       = module.vpc.vpc_id
  anyware_cidr_range           = var.anyware_cidr_range
  ssh_cidr_range               = var.ssh_cidr_range
}

#Create nginx servers
module "nginx" {
  source                       = "git::https://github.com/DianaCohen/terraform_cloud.git//modules/nginx"
  nginx_instances_count        = var.nginx_instances_count
  ami                          = var.ami
  instance_type                = var.instance_type
  public_security_group_id     = module.sg.public_security_group_id
  ebs_type                     = var.ebs_type
  ebs_size                     = var.ebs_size
  private_subnet_id            = module.vpc.private_subnet_id
  s3_iam_profile_name          = module.iam.s3_iam_profile_name
}

#Create application load balancer
module "alb" {
  source                       = "git::https://github.com/DianaCohen/terraform_cloud.git//modules/alb"
  vpc_id                       = module.vpc.vpc_id
  nginx_instances_count        = var.nginx_instances_count
  public_subnet_id             = module.vpc.public_subnet_id
  alb_sg                       = module.sg.alb_security_group_id
  instance_nginx_id            = module.nginx.instance_nginx_id
}

# Create rds instances for DB
module "rds" {
  source                       = "git::https://github.com/DianaCohen/terraform_cloud.git//modules/rds"
  rds_instances_count          = var.rds_instances_count
  private_data_subnet_id       = module.vpc.private_data_subnet_id
  private_security_group_id    = module.sg.private_security_group_id
  availability_zones_names     = module.vpc.availability_zones_names
}

#Create s3 bucket
module "s3_bucket" {
  source                       = "git::https://github.com/DianaCohen/terraform_cloud.git//modules/s3_bucket"
}

# Create iam
module "iam" {
  source                       = "git::https://github.com/DianaCohen/terraform_cloud.git//modules/iam"
}