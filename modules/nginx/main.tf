#For windows files
locals {
  module_path = "${replace(path.module, "\\", "/")}"
}

resource "aws_instance" "nginx" {
  count                  = var.nginx_instances_count
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id[count.index]
  vpc_security_group_ids = [var.public_security_group_id]
 # iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  iam_instance_profile   = var.s3_iam_profile_name
 
  root_block_device {
    volume_type = var.ebs_type
    volume_size = var.ebs_size
    tags = {
      Name = "ebs-for-Web-Server-${count.index}"
    }    
  }

  user_data              = "${file("${local.module_path}/../nginx/nginx.sh")}"

  # For linux with file
  #policy = "${file("nginx.sh")}"

  tags = {
    Name = "whiskey-webserver-${count.index}"
    Owner = "Diana"
    Purpose = "Whiskey"
  }
}

  


