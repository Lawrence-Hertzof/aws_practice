# Create the ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "CustomEcsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}


# Create the ECS Task Role
resource "aws_iam_role" "ecs_task_role" {
  name = "CustomEcsTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

locals {
  task_role_policy_files = fileset("task-definitions/task_role_policies", "*.json")
  execution_role_policy_files = fileset("task-definitions/execution_role_policies", "*.json")
}

resource "aws_iam_role_policy" "execution_role_policy" {
  for_each = local.execution_role_policy_files
  
  name   = each.key
  policy = file("task-definitions/execution_role_policies/${each.value}")
  role   = aws_iam_role.ecs_task_execution_role.id
}


resource "aws_iam_role_policy" "task_role_policy" {
  for_each = local.task_role_policy_files
  
  name   = each.key
  policy = file("task-definitions/task_role_policies/${each.value}")
  role   = aws_iam_role.ecs_task_role.id
}
