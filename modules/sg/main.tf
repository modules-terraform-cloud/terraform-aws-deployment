# create public security group for the application load balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb security group"
  description = "enable http/ssh access on port 80"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = [var.anyware_cidr_range]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anyware_cidr_range]
  }

  tags   = {
    Name = "ALB Security Group"
  }
}


# create public security group for the application load balancer
resource "aws_security_group" "ssh_sg" {
  name        = "ssh security group"
  description = "enable ssh access on port 22"
  vpc_id      = var.vpc_id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = [var.ssh_cidr_range]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anyware_cidr_range]
  }

  tags   = {
    Name = "SSH Security Group"
  }
}

# create public security group for the application load balancer
resource "aws_security_group" "public_sg" {
  name        = "Public security group"
  description = "enable http access on port 80"
  vpc_id      = var.vpc_id

  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    security_groups  = [aws_security_group.alb_sg.id]
  }

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    security_groups  = [aws_security_group.ssh_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anyware_cidr_range]
  }

  tags   = {
    Name = "Public Security Group"
  }
}

# create private security group
resource "aws_security_group" "private_sg" {
  name        = "Private security group"
  description = "Dont enable internet access"
  vpc_id      = var.vpc_id

  ingress {
    description      = "MYSQL/Aurora Access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "TCP"   
    security_groups  = [aws_security_group.public_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.anyware_cidr_range]
  }

  tags   = {
    Name = "Private Security Group"
  }
}
