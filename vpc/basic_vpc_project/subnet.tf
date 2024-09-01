###############################################
# PUBLIC SUBNETS
###############################################
resource "aws_subnet" "subnet_a_public" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.11.0/24"
  availability_zone =        "us-west-2a"
  map_public_ip_on_launch =  true

  tags = {
    Name = "subnet_a_public_terraform_practice"
  }
}

resource "aws_subnet" "subnet_b_public" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.21.0/24"
  availability_zone =        "us-west-2b"
  map_public_ip_on_launch =  true

  tags = {
    Name = "subnet_b_public_terraform_practice"
  }
}

###############################################
# PRIVATE SUBNETS
###############################################
resource "aws_subnet" "subnet_a_private" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.12.0/24"
  availability_zone =        "us-west-2a"

  tags = {
    Name = "subnet_a_private_terraform_practice"
  }
}

resource "aws_subnet" "subnet_b_private" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.22.0/24"
  availability_zone =        "us-west-2b"

  tags = {
    Name = "subnet_b_private_terraform_practice"
  }
}

###############################################
# DB SUBNETS
###############################################
resource "aws_subnet" "subnet_a_db" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.13.0/24"
  availability_zone =        "us-west-2a"

  tags = {
    Name = "subnet_a_db_terraform_practice"
  }
}

resource "aws_subnet" "subnet_b_db" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.23.0/24"
  availability_zone =        "us-west-2b"

  tags = {
    Name = "subnet_b_db_terraform_practice"
  }
}

