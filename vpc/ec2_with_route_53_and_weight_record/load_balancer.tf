# module "load_balancer" {
#   source = "./modules/load_balancer"

#     # Load Balancer
#   lb_name = "terraform-example-alb"
#   lb_type = "application"
#   security_groups = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]
#   subnets = [aws_subnet.subnet_a_public.id, aws_subnet.subnet_b_public.id]
#   lb_tag_name = "alb-example-terraform"

#   # Target Group
#   load_balancer_tg_name = "terraform-example-alb-tg"
#   tg_port = 80
#   tg_protocol = "HTTP"
#   vpc_id = aws_vpc.main_vpc.id
#   tg_tag_name = "alb-tg-example-terraform"

#   # Target Group Attachment to EC2 Instances
#   ec2_instance_ids = module.ec2_web_servers.instance_ids 

#   # Load Balancer Listener
#   lb_listener_tag_name = "alb-listener-example-terraform"
# }