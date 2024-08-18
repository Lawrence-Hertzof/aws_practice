resource "aws_eip" "elastic_ip_a" {
  domain                    = "vpc"

    tags = {
        Name = "elastic_ip_a_terraform_practice"
    }
}

resource "aws_eip" "elastic_ip_b" {
  domain                    = "vpc"

    tags = {
        Name = "elastic_ip_b_terraform_practice"
    }
}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.elastic_ip_a.id
  subnet_id     = aws_subnet.subnet_a_public.id

  tags = {
    Name = "nat_gateway_a_terraform_practice"
  }
}

resource "aws_nat_gateway" "nat_gateway_b" {
  allocation_id = aws_eip.elastic_ip_b.id
  subnet_id     = aws_subnet.subnet_b_public.id

  tags = {
    Name = "nat_gateway_b_terraform_practice"
  }
}
