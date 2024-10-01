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

module "app_parameters"{
    source = "./modules/parameter_store"
}


module "ecr_repo"{
    source = "./modules/ecr_repo"
    ecr_repo_name = "processflo_repo"
}


module "sqs_queue" {
    source = "./modules/sqs"
    environment = "dev"
    queue_name = "celery"
  
}

module "load_balancer" { # Before deleting the load_balancer module, make sure to delete listener and target group
    source = "./modules/load_balancer"
    vpc_id = module.network.vpc_id
    subnet_ids = module.network.subnet_ids
    load_balancer_name = "EcsLoadBalancer"
} 

module "route53" {
    source = "./modules/route53"
    load_balancer_dns_name = module.load_balancer.dns_name
    load_balancer_zone_id = module.load_balancer.zone_id
    depends_on = [ module.load_balancer ]
}


module "certificate_managment" {
    source = "./modules/certificate_manager"
    route53_zone_id = module.route53.route53_zone_id
}

module "alb_listeners" {
    source = "./modules/alb_listeners"
    load_balancer_arn = module.load_balancer.load_balancer_arn
    target_group_arn = module.load_balancer.target_group_arn
    acm_certificate_validation_arn = module.certificate_managment.certificate_arn
    depends_on = [ module.load_balancer, module.certificate_managment ]
}


module "ecs_cluster" { # Before deleting the ecs_cluster module, make sure to delete the ECS service and task definition
    source = "./modules/ecs_cluster"
    subnet_ids = module.network.subnet_ids
    ecs_cluster_name = "PROCESSFLO_CLUSTER"
    security_group_ids = [module.network.ecs_sg_id]
    autoscale_min = 1
    autoscale_max = 3
    autoscale_desired = 2
    instance_type = "t2.micro"
    ssh_key_name = aws_key_pair.this.key_name
    lb_target_group_arn = module.load_balancer.target_group_arn
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/processflo_backend"
  retention_in_days = 7
}



