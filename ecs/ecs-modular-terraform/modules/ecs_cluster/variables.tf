variable "ecs_cluster_name" {
    description = "The name of the Amazon ECS cluster."
    default = "main-cluster"
}

variable "autoscale_min" {
    type = number
    default = 1
    description = "Minimum autoscale (number of EC2)"
}

variable "autoscale_max" {
    type = number
    default = 3
    description = "Maximum autoscale (number of EC2)"
}

variable "autoscale_desired" {
    type = number
    default = 2
    description = "Desired autoscale (number of EC2)"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ssh_key_name" {
    description = "The name of the SSH key to use"
    type = string
}

variable "subnet_ids" {
    description = "The subnet IDs to use"
    type = list(string)
}

variable "security_group_ids" {
    description = "The security group IDs to use"
    type = list(string)
}

# variable "load_balancer_sg_ids"{
#     description = "The security group IDs to use"
#     type = list(string)
# }

variable "lb_target_group_arn" {
    description = "The ARN of the target group to use"
    type = string
}