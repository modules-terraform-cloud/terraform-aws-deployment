# create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "alb-target-group"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    protocol            = "HTTP"
    enabled             = true
    interval            = 65
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  stickiness {
    type              = "lb_cookie"
    cookie_duration   = 60
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "attach_instance" {
  count            = var.nginx_instances_count
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.instance_nginx_id[count.index]
  port             = 80
}

# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name                       = "alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sg]
#  subnets                    = var.public_subnet_id[count.index]
  subnets                    = [var.public_subnet_id[0], var.public_subnet_id[1]]
  enable_deletion_protection = false

  tags   = {
    Name = "alb"
  }
}


# create a listener on port 80 with forwarding action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn   = aws_lb.application_load_balancer.arn
  port                = 80
  protocol            = "HTTP"

  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.alb_target_group.arn
  }

  tags   = {
    Name = "alb-listener"
  }

}

