# # resource "aws_key_pair" "bastion_key" {
# #   key_name   = "bastion_key"
# #   public_key = file("./ssh_keys/bastion_key.pub")  # Path to your public key
# # }
# resource "aws_key_pair" "new_bastion_key" {
#   key_name   = "new_bastion_key"
#   public_key = file("./ssh_keys/new_key.pub")  # Path to your public key
# }