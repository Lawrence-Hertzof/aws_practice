resource "aws_ecs_task_definition" "test-http" {
    family = "test-http"
    container_definitions = "${file("task-definitions/test-http.json")}"
    network_mode = "awsvpc"
    # task_role_arn = "arn:aws:iam::432534498488:role/ecsTaskExecutionRole"
    task_role_arn = aws_iam_role.ecs_task_execution_role.arn
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "test-http" {
    name = "test-http"
    cluster = aws_ecs_cluster.this.id
    task_definition = aws_ecs_task_definition.test-http.arn
    # iam_role = aws_iam_role.ecs_service_role.arn
    desired_count = 2
    depends_on = [aws_iam_role_policy.ecs_service_role_policy]

    network_configuration {
        subnets = var.subnet_ids
        security_groups = var.security_group_ids
        # assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.lb_target_group_arn
        container_name = "test-http"
        container_port = 8080
    }
}
