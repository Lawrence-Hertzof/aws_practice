provider "aws" {
    region = var.region
}


module "network" {
    source = "./modules/network"
    region=var.region
    subnets_count=2
    vpc_name = "ECS_VPC"
}

resource "aws_key_pair" "this" {
    key_name = "ecs_node_key"
    public_key = "${file(var.ssh_pubkey_file)}"
}


module "load_balancer" {
    source = "./modules/load_balancer"
    vpc_id = module.network.vpc_id
    subnet_ids = module.network.subnet_ids
    load_balancer_name = "EcsLoadBalancer"
} 

module "ecr_repo"{
    source = "./modules/ecr_repo"
    ecr_repo_name = "ecs_repo"
}


module "ecs_cluster" { # Before deleting the ecs_cluster module, make sure to delete the ECS service and task definition
    source = "./modules/ecs_cluster"
    subnet_ids = module.network.subnet_ids
    ecs_cluster_name = "MAIN_CLUSTER"
    security_group_ids = [module.network.ecs_sg_id]
    autoscale_min = 1
    autoscale_max = 3
    autoscale_desired = 2
    instance_type = "t2.micro"
    ssh_key_name = aws_key_pair.this.key_name
    # load_balancer_sg_ids = [module.network.load_balancer_sg_id]
    lb_target_group_arn = module.load_balancer.target_group_arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/test-http"
  retention_in_days = 7
}



