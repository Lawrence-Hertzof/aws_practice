## DOC ##
#     PRIVATE SUBNETS
#     Private subnets – Must be tagged in the following format.
#     This is so that Kubernetes and the AWS Load Balancer Controller know that the subnets
#     can be used for internal load balancers. If you use eksctl or an Amazon EKS AWS AWS
#     CloudFormation template to create your VPC after March 26, 2020,
#     then the subnets are tagged appropriately when they’re created.
#     For more information about the Amazon EKS AWS AWS CloudFormation VPC templates,
#     see Create an Amazon VPC for your Amazon EKS cluster.
#     Key – kubernetes.io/role/internal-elb
#     Value – 1
#    PUBLIC SUBNETS
#     Public subnets – Must be tagged in the following format. This is so that Kubernetes knows
#     to use only those subnets for external load balancers instead of choosing a public subnet
#     in each Availability Zone (based on the lexicographical order of the subnet IDs).
#     If you use eksctl or an Amazon EKS AWS CloudFormation template to create your VPC after March 26, 2020,
#     then the subnets are tagged appropriately when they’re created. For more information
#     about the Amazon EKS AWS CloudFormation VPC templates, see Create an Amazon VPC for your Amazon EKS cluster.
#     Key – kubernetes.io/role/elb
#     Value – 1



resource "aws_subnet" "private_zone1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.0.0/19"
    availability_zone = local.zone1

    tags = {
        "Name" = "${local.env}-private-${local.zone1}"
        "kubernetes.io/role/internal-elb" = 1
        "kubernetes.io/cluster/${local.env}-${local.eks_cluster_name}" = "owned"
    }
}

resource "aws_subnet" "private_zone2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.32.0/19"
    availability_zone = local.zone1

    tags = {
        "Name" = "${local.env}-private-${local.zone2}"
        "kubernetes.io/role/internal-elb" = 1
        "kubernetes.io/cluster/${local.env}-${local.eks_cluster_name}" = "owned"
    }
}

resource "aws_subnet" "public_zone1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.64.0/19"
    availability_zone = local.zone1
    map_public_ip_on_launch = true

    tags = {
        "Name" = "${local.env}-public-${local.zone1}"
        "kubernetes.io/role/elb" = 1
        "kubernetes.io/cluster/${local.env}-${local.eks_cluster_name}" = "owned"
    }
}

resource "aws_subnet" "public_zone2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.96.0/19"
    availability_zone = local.zone2
    map_public_ip_on_launch = true

    tags = {
        "Name" = "${local.env}-public-${local.zone2}"
        "kubernetes.io/role/elb" = 1
        "kubernetes.io/cluster/${local.env}-${local.eks_cluster_name}" = "owned"
    }
}
