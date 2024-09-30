# module "ec2_web_servers" {
#   source = "./modules/ec2_web_servers"

#   ec2_instance_count = 2
#   ec2_key_name = aws_key_pair.new_bastion_key.key_name
#   ec2_subnets = [aws_subnet.subnet_a_public.id, aws_subnet.subnet_b_public.id]
#   ec2_security_groups = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]
#   ec2_key_path = "./ssh_keys/new_key.pem"
#   ec2_instance_name = "example-ec2-public-terraform-practice"
# }
