# resource "aws_instance" "example_ec2_private_instance" {
#   ami = "ami-0aff18ec83b712f05"
#   instance_type = "t2.micro"
#   key_name = aws_key_pair.new_bastion_key.key_name
#   subnet_id = aws_subnet.subnet_a_private.id
#   security_groups = [aws_security_group.ssh_access_bastion_security_group_terraform_practice.id]
#   tags = {
#     Name = "example-ec2-private-terraform-practice"
#   }
  
# }