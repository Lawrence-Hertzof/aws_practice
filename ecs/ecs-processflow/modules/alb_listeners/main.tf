resource "aws_lb_listener" "https" {
  load_balancer_arn = var.load_balancer_arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy        = "ELBSecurityPolicy-2016-08"  # Use a predefined SSL policy
  certificate_arn = var.acm_certificate_validation_arn

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
