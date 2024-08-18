###############################################
# PUBLIC ROUTE TABLE
###############################################
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = {
    Name = "public_route_table_terraform_practice"
  }
}

resource "aws_route_table_association" "route_table_to_subnet_a_public_association" {
  subnet_id      = aws_subnet.subnet_a_public.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route_table_to_subnet_b_public_association" {
  subnet_id      = aws_subnet.subnet_b_public.id
  route_table_id = aws_route_table.public_route_table.id
}

###############################################
# PRIVATE ROUTE TABLE
###############################################
resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_a.id
  }

  tags = {
    Name = "private_route_table_a_terraform_practice"
  }
}

resource "aws_route_table_association" "private_route_table_a_to_subnet_a_private_association" {
  subnet_id      = aws_subnet.subnet_a_private.id
  route_table_id = aws_route_table.private_route_table_a.id
}


resource "aws_route_table" "private_route_table_b" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway_b.id
  }

  tags = {
    Name = "private_route_table_b_terraform_practice"
  }
}

resource "aws_route_table_association" "private_route_table_b_to_subnet_b_private_association" {
  subnet_id      = aws_subnet.subnet_b_private.id
  route_table_id = aws_route_table.private_route_table_b.id
}


###############################################
# DB ROUTE TABLE
###############################################
resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "db_route_table_terraform_practice"
  }
}

resource "aws_route_table_association" "db_route_table_to_subnet_a_db_association" {
  subnet_id      = aws_subnet.subnet_a_db.id
  route_table_id = aws_route_table.db_route_table.id
}

resource "aws_route_table_association" "db_route_table_to_subnet_b_db_association" {
  subnet_id      = aws_subnet.subnet_b_db.id
  route_table_id = aws_route_table.db_route_table.id
}