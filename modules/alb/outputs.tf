output "alb_target_group_arn" {
   value = aws_lb_target_group.alb_target_group.arn
}

output "application_load_balancer_arn" {
   value = aws_lb.application_load_balancer.arn
}

