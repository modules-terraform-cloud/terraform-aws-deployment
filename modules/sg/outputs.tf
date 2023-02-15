output "alb_security_group_id" {
   value = aws_security_group.alb_sg.id
}

output "ssh_security_group_id" {
   value = aws_security_group.ssh_sg.id
}

output "public_security_group_id" {
   value = aws_security_group.public_sg.id
}

output "private_security_group_id" {
   value = aws_security_group.private_sg.id
}


