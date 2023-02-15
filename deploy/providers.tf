terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.52.0"
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_config_files      = ["C:/Users/Diana Cohen/.aws/config"]
  shared_credentials_files = ["C:/Users/Diana Cohen/.aws/credentials"]
  profile                  = "terraform"
}