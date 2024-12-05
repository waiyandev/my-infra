resource "aws_lb" "lb" {
  name               = "hello-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.lb.id
  ]
  subnets = data.aws_subnets.public.ids

  enable_deletion_protection = false

  tags = {
    "lab" = "example"
  }
}

resource "aws_security_group" "lb" {
  name        = "http and https only unique"
  description = "Allow http/https traffic from anywhere in the world"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    "lab" = "example"
  }
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_http_80" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "lb_allow_http_443" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}


resource "aws_vpc_security_group_egress_rule" "lb_allow_egress_all" {
  security_group_id = aws_security_group.lb.id
  cidr_ipv4         = "0.0.0.0/0"

  ip_protocol = -1
}


resource "aws_lb_target_group" "backend" {
  name     = "backend"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 6
    timeout             = 5
    path                = "/api/v1/hello"
  }
  
  deregistration_delay = 10
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}