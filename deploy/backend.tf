# Saving the state in a remote s3
terraform {
  backend "s3" {
    bucket   = "my-tf-test-bucket-logs"
    key      = "vpc_assignment/vpc_assignment/terraform.tfstate"
    region   = "us-east-1"
    profile  = "terraform"
  }
}
