# modules/load_balancer/main.tf

resource "aws_lb" "this_aws_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = var.security_groups
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name = var.lb_tag_name
  }
}

resource "aws_lb_target_group" "this_target_group" {
  name     = var.load_balancer_tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  tags = {
    Name = var.tg_tag_name
  }
}

resource "aws_lb_target_group_attachment" "this_target_group_attachment" {
    count = length(var.ec2_instance_ids)
    target_group_arn = aws_lb_target_group.this_target_group.arn
    target_id        = var.ec2_instance_ids[count.index]
    port             = var.tg_port
    
}

resource "aws_lb_listener" "this_lb_listener" {
  load_balancer_arn = aws_lb.this_aws_lb.arn
  port              = var.tg_port
  protocol          = var.tg_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this_target_group.arn
  }
  tags = {
    Name = var.lb_listener_tag_name
  }
}



