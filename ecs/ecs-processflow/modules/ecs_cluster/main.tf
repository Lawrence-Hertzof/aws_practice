resource "aws_ecs_cluster" "this" {
    name = var.ecs_cluster_name
}

resource "aws_autoscaling_group" "ecs-cluster" {
    name = "ECS ${var.ecs_cluster_name}"
    min_size = var.autoscale_min
    max_size = var.autoscale_max
    desired_capacity = var.autoscale_desired
    health_check_type = "EC2"
    launch_configuration = aws_launch_configuration.ecs.name
    vpc_zone_identifier = var.subnet_ids
    depends_on = [aws_launch_configuration.ecs]
}

resource "aws_launch_configuration" "ecs" {
    name = "ECS ${var.ecs_cluster_name} launch configuration"
    image_id = "ami-0ca2af66da8e56876" # TODO add script to get the latest ECS optimized AMI
    instance_type = var.instance_type
    security_groups = var.security_group_ids
    iam_instance_profile = aws_iam_instance_profile.this.name
    key_name = var.ssh_key_name
    associate_public_ip_address = true
    user_data = "#!/bin/bash\necho ECS_CLUSTER='${var.ecs_cluster_name}' > /etc/ecs/ecs.config"
}

