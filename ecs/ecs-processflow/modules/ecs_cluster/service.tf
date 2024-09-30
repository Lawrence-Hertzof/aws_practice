resource "aws_ecs_task_definition" "processflo_backend" {
    family = "processflo_backend"
    container_definitions = "${file("task-definitions/backend_td.json")}"
    network_mode = "awsvpc"
    task_role_arn = aws_iam_role.ecs_task_role.arn
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "backend_service" {
    name = "processflo_backend_service_1"
    cluster = aws_ecs_cluster.this.id
    task_definition = aws_ecs_task_definition.processflo_backend.arn
    # iam_role = aws_iam_role.ecs_service_role.arn
    desired_count = 1
    depends_on = [aws_iam_role_policy.ecs_service_role_policy]

    network_configuration {
        subnets = var.subnet_ids
        security_groups = var.security_group_ids
    }

    load_balancer {
        target_group_arn = var.lb_target_group_arn
        container_name = "processflo_backend"
        container_port = 8080
    }
}
