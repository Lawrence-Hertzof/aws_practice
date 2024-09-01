
## Resources

# VPC & Security Group
### Regular VPC
```terraform 
  resource "aws_vpc" "main_vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default" # Optional["default", "dedicated"] 
    tags = {
        Name = "main_vpc_terraform_practice"
    }
  }
```

### Regular Internet Gateway connected to main VPC
```terraform
resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "main_internet_gw_terraform_practice"
  }
}
```
### Security Groups that allow ingress for SSH and HTTP and EGRESS for everything. We ecspecially need port 80 since we are running our basic NGINX application(check EC2 component) on this port
```terraform
resource "aws_security_group" "ssh_and_http_security_group_terraform_practice" {
  name = "ssh_access_bastion_security_group_terraform_practice"
  description = "Allow SSH access to bastion host"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
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
    Name = "ssh_and_http_security_group_terraform_practice"
  }
}
```

# SUBNETS

## PUBLIC SUBNETS IN WHICH WE WILL RUN OUT EC2 INSTANCES. WE NEED BOTH SINCE Application Load Balanced need 2 availability zones

### Regular public subnet "A"
```terraform
resource "aws_subnet" "subnet_a_public" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.11.0/24"
  availability_zone =        "us-west-2a"
  map_public_ip_on_launch =  true


  tags = {
    Name = "subnet_a_public_terraform_practice"
  }
}
```


### Regular public subnet "B"
```terraform
resource "aws_subnet" "subnet_b_public" {
  vpc_id            =        aws_vpc.main_vpc.id
  cidr_block        =        "10.0.21.0/24"
  availability_zone =        "us-west-2b"
  map_public_ip_on_launch =  true


  tags = {
    Name = "subnet_b_public_terraform_practice"
  }
}
```

# Route Tables
## Routes tables that bound Internet Gateway with existing two public subnet A & b

### Route table "A" that takes requests from Internet Gateway
```terraform
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
```

### Route table "B" that takes requests from Internet Gateway
```terraform
resource "aws_route_table" "public_route_table_b" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }

  tags = {
    Name = "public_route_table_b_terraform_practice"
  }
}
```

### Route table association "A" that connects Route Table "A" with Public Subnet "A"
```terraform
resource "aws_route_table_association" "route_table_to_subnet_a_public_association" {
  subnet_id      = aws_subnet.subnet_a_public.id
  route_table_id = aws_route_table.public_route_table.id
}
```


### Route table association "B" that connects Route Table "B" with Public Subnet "B"
```terraform
resource "aws_route_table_association" "route_table_to_subnet_b_public_association" {
  subnet_id      = aws_subnet.subnet_b_public.id
  route_table_id = aws_route_table.public_route_table_b.id
}
```


# EC2 

## EC2 instances in SUBNETS A & B. The also have ssh key, that is covered in the next section. At the start, they download regular nginx app and run it on port 80. All the commands run via ssh by terraform provisioner

### EC2 Instance "A"

```terraform
resource "aws_instance" "example_ec2_private_instance" {
  ami = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"
  key_name = aws_key_pair.new_bastion_key.key_name
  subnet_id = aws_subnet.subnet_a_public.id
  security_groups = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]

  provisioner "remote-exec" {
    when = create
    inline = [
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = "${file("./ssh_keys/new_key.pem")}"
  }
  

  tags = {
    Name = "example-ec2-public-a-terraform-practice"
  }
}
```


### EC2 Instance "B"
```terraform
resource "aws_instance" "example_ec2_private_instance_b" {
  ami = "ami-0aff18ec83b712f05"
  instance_type = "t2.micro"
  key_name = aws_key_pair.new_bastion_key.key_name
  subnet_id = aws_subnet.subnet_b_public.id
  security_groups = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]

  provisioner "remote-exec" {
    when = create
    inline = [
      "sudo apt install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    password    = ""
    private_key = "${file("./ssh_keys/new_key.pem")}"
  }
  

  tags = {
    Name = "example-ec2-public-b-terraform-practice"
  }
}
```
# SSH-KEY
## Just generated ssh keys
```terraform
resource "aws_key_pair" "new_bastion_key" {
  key_name   = "new_bastion_key"
  public_key = file("./ssh_keys/new_key.pub")  # Path to your public key
}
```

# LOAD BALANCER
## [Target Group for Load Balancer], just target group that defines where Load Balancer routes requests, here we can see that HTTP requests are routing to port 80
resource "aws_lb_target_group" "example_target_group" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  tags = {
    Name = "lb-tg-example-terraform"
  }
}


## [Load Balancer], that has the same security group as ec2 instances and 2 subnets
resource "aws_lb" "example_load_balancer" {
  name               = "tf-example-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ssh_and_http_security_group_terraform_practice.id]
  subnets            = [aws_subnet.subnet_a_public.id, aws_subnet.subnet_b_public.id]

  enable_deletion_protection = false

  tags = {
    Name = "lb-example-terraform"
  }
}

## [Target Group Association] with EC2 Instance "A"
```terraform
resource "aws_lb_target_group_attachment" "example_ec2_attachment" {
  target_group_arn = aws_lb_target_group.example_target_group.arn
  target_id        = aws_instance.example_ec2_private_instance.id
  port             = 80
}
```

## [Target Group Association] with EC2 Instance "B"
```terraform
resource "aws_lb_target_group_attachment" "example_ec2_attachment_b" {
  target_group_arn = aws_lb_target_group.example_target_group.arn
  target_id        = aws_instance.example_ec2_private_instance_b.id
  port             = 80
}
```

## [Load Balancer Listener], listens traffic on defined port and forward it to target group
```terraform
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.example_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example_target_group.arn
  }
}
```

# Route53

## [Hosted Zone] was created by AWS after buying domain name and imported here by it's ID

```terraform
resource "aws_route53_zone" "existing_zone" {
    name = "learning-aws-terraform.com"
    comment = "HostedZone created by Route53 Registrar"
    force_destroy = null
}
```

## [Route53 Record] special "Type A Record" that bounds domain name to specific Load Balancer. Also could be bound with direct IP address of EC2 intances(code is commented here)

```terraform
resource "aws_route53_record" "ec2_public_ip" {
  zone_id = aws_route53_zone.existing_zone.id  
  name    = aws_route53_zone.existing_zone.name   
  type    = "A"
  # ttl     = 300 # TTL conflicts with the alias record

  # records = [aws_instance.example_ec2_private_instance.public_ip] # This is the connection between the EC2 instance and the Route53 record
  # depends_on = [aws_instance.example_ec2_private_instance]

  alias { # This is the connection between the Route53 record and the Load Balancer
    name                   = aws_lb.example_load_balancer.dns_name
    zone_id                = aws_lb.example_load_balancer.zone_id
    evaluate_target_health = true
  }
}
```