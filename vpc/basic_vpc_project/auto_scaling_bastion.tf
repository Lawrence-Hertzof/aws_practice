# resource "aws_launch_template" "bastion_launch_template" {
#   name_prefix   = "bastion-template-"
#   image_id      = "ami-0aff18ec83b712f05"
#   instance_type = "t2.micro"
#   key_name = aws_key_pair.new_bastion_key.key_name
#   vpc_security_group_ids = [
#     aws_security_group.ssh_access_bastion_security_group_terraform_practice.id
#     ]

#   tags = {
#     Name = "bastion-launch-template-terraform-practice"
#   }
  
# } 

# resource "aws_autoscaling_group" "bastion_asg" {
#   name               = "bastion-asg-terraform-practice"
#   vpc_zone_identifier = [
#     aws_subnet.subnet_a_public.id,
#     aws_subnet.subnet_b_public.id,
#   ]
#   desired_capacity   = 1
#   max_size           = 1
#   min_size           = 1

#   launch_template {
#     id      = aws_launch_template.bastion_launch_template.id
#     version = "$Latest"
#   }
# }