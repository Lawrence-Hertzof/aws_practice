resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true

  # This is the default tenancy, it means that instances launched
  # in this VPC will be launched on shared hardware
    instance_tenancy = "default" # Optional["default", "dedicated"] 
  
  # Ipam pool id is id of the ipam pool that will be used to allocate ip addresses
    #ipv4_ipam_pool_id = aws_ipam_pool.main_pool.id  # Optional
    tags = {
        Name = "main_vpc_terraform_practice"
    }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_internet_gw_terraform_practice"
  }
}

resource "aws_security_group" "ssh_access_bastion_security_group_terraform_practice" {
  name = "ssh_access_bastion_security_group_terraform_practice"
  description = "Allow SSH access to bastion host"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
  

  tags = {
    Name = "ssh_access_bastion_security_group_terraform_practice"
  }
}
