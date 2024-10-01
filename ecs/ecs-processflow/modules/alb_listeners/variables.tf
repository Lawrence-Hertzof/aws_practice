variable "acm_certificate_validation_arn" {
    description = "ACM Certificate Validation ARN"
    type = string
}

variable "load_balancer_arn" {
    description = "Load Balancer ARN"
    type = string
}

variable "target_group_arn" {
    description = "Target Group ARN"
    type = string
}