resource "aws_security_group" "this" {
    name = "ALLOW_ALL_LB_SG"
    description = "Allows all traffic"
    vpc_id = var.vpc_id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
# Application Load Balancer
resource "aws_lb" "this" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.this.id]
  subnets            = var.subnet_ids

  enable_cross_zone_load_balancing = true
}

# Target Group for ALB
resource "aws_lb_target_group" "this" {
  name        = "test-http-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 5
    path                = "/"
    matcher             = "404"
  }
}

# HTTP Listener for ALB
# resource "aws_lb_listener" "test-http" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this.arn
#   }
# }

# HTTPS Listener for ALB

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.this.arn
#   port              = 443
#   protocol          = "HTTPS"

#   ssl_policy        = "ELBSecurityPolicy-2016-08"  # Use a predefined SSL policy
#   # certificate_arn   = aws_acm_certificate_validation.this.certificate_arn
#   certificate_arn = var.acm_certificate_validation_arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.this.arn
#   }
# }
