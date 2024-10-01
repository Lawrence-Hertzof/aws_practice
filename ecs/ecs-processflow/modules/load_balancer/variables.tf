variable "vpc_id" {
    description = "VPC ID"
    type = string
}
variable "subnet_ids" {
    description = "Subnet IDs"
    type = list(string)
}

variable "load_balancer_name" {
    description = "Load Balancer Name"
    type = string
}

# variable "route53_zone_id" {
#     description = "Route53 Zone ID"
#     type = string
# }

# variable "acm_certificate_validation_arn" {
#     description = "ACM Certificate Validation ARN"
#     type = string
  
# }