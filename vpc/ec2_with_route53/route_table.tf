# resource "aws_route_table" "public_route_table" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main_gw.id
#   }

#   tags = {
#     Name = "public_route_table_terraform_practice"
#   }
# }

# resource "aws_route_table" "public_route_table_b" {
#   vpc_id = aws_vpc.main_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.main_gw.id
#   }

#   tags = {
#     Name = "public_route_table_b_terraform_practice"
#   }
# }

# resource "aws_route_table_association" "route_table_to_subnet_a_public_association" {
#   subnet_id      = aws_subnet.subnet_a_public.id
#   route_table_id = aws_route_table.public_route_table.id
# }

# resource "aws_route_table_association" "route_table_to_subnet_b_public_association" {
#   subnet_id      = aws_subnet.subnet_b_public.id
#   route_table_id = aws_route_table.public_route_table_b.id
# }



