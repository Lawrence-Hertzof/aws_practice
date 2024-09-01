# Load Balancer Target Group
resource "aws_lb_target_group" "example_target_group" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  tags = {
    Name = "lb-tg-example-terraform"
  }
}


# Load Balancer
resource "aws_lb" "example_load_balancer" {
  name               = "tf-example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]
  subnets            = [aws_subnet.subnet_a_public.id, aws_subnet.subnet_b_public.id]

  enable_deletion_protection = false

  tags = {
    Name = "lb-example-terraform"
  }
}

# Target Group Association with EC2 Instance
resource "aws_lb_target_group_attachment" "example_ec2_attachment" {
  target_group_arn = aws_lb_target_group.example_target_group.arn
  target_id        = aws_instance.example_ec2_private_instance.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "example_ec2_attachment_b" {
  target_group_arn = aws_lb_target_group.example_target_group.arn
  target_id        = aws_instance.example_ec2_private_instance_b.id
  port             = 80
}

# Load Balancer Listener
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.example_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_target_group.arn
  }
}

