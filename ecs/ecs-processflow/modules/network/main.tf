resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true

    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "this" {
    vpc_id = aws_vpc.this.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.this.id
    }
}

resource "aws_route_table_association" "this" {
    count = var.subnets_count
    # subnet_id = "${aws_subnet.this.id}"
    subnet_id = aws_subnet.this[count.index].id
    route_table_id = aws_route_table.this.id
}

locals {
    azs = lookup(
        {
            "us-west-2" = ["us-west-2a", "us-west-2b", "us-west-2c"]
        },
        var.region,
        ["us-west-2a"]  # Default fallback
    )
}

resource "aws_subnet" "this" {
    count = var.subnets_count
    vpc_id = aws_vpc.this.id
    cidr_block = "10.0.${count.index + 1}.0/24"
    availability_zone = local.azs[count.index]  # Assign AZ based on index
}


# resource "aws_security_group" "this_load_balancer_sg" {
#     name = "ALLOW_ALL_LB_SG"
#     description = "Allows all traffic"
#     vpc_id = aws_vpc.this.id

#     ingress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }

#     egress {
#         from_port = 0
#         to_port = 0
#         protocol = "-1"
#         cidr_blocks = ["0.0.0.0/0"]
#     }
# }

resource "aws_security_group" "this_ecs_sg" {
    name = "ALLOW_ALL_ECS_SG"
    description = "Allows all traffic"
    vpc_id = aws_vpc.this.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # ingress {
    #     from_port = 0
    #     to_port = 0
    #     protocol = "-1"
    #     security_groups = [aws_security_group.this_load_balancer_sg.id]
    # }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
