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