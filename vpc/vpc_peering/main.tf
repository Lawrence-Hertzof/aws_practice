terraform {
  #############################################################
  ## AFTER RUNNING TERRAFORM APPLY (WITH LOCAL BACKEND),
  ## YOU SHOULD APPLY THIS CODE BACKEND CODE THAT IS COMMENTED,
  ## THEN RERUN TERRAFORM INIT TO SWITCH FROM LOCAL BACKEND TO REMOTE AWS BACKEND
  #############################################################
#   backend "s3" {
#     bucket         = "sales-automation-terraform-state"
#     key            = "terraform.tfstate"
#     region         = "us-west-2"
#     dynamodb_table = "sales-automation-terraform-state-locking"
#     encrypt        = true
#   }

    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
}

provider "aws" {
  region = var.aws_region
}

# VPC 1
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route" "route1" {
  route_table_id         = aws_route_table.rt1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw1.id
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_vpc1" {
  ami           = "ami-0aff18ec83b712f05"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet1.id
  security_groups = [aws_security_group.sg1.id]

  associate_public_ip_address = true
}

# VPC 2
resource "aws_vpc" "vpc2" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.vpc2.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_security_group" "sg2" {
  vpc_id = aws_vpc.vpc2.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]  # Allow all traffic from VPC1
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2_vpc2" {
  ami           = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet2.id
  security_groups = [aws_security_group.sg2.id]
}

# VPC Peering
resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id        = aws_vpc.vpc1.id
  peer_vpc_id   = aws_vpc.vpc2.id
  auto_accept   = true
}

resource "aws_route" "vpc1_to_vpc2" {
  route_table_id         = aws_route_table.rt1.id
  destination_cidr_block = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_route" "vpc2_to_vpc1" {
  route_table_id         = aws_route_table.rt2.id
  destination_cidr_block = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt2.id
}
