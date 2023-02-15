output "instance_nginx_id" {
   value = aws_instance.nginx.*.id
}

