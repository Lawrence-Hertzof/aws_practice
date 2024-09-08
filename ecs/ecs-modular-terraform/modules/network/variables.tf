variable "region" {
    description = "The AWS region to deploy to"
    type = string
}

variable "subnets_count" {
    description = "The number of subnets to create"
    type = number

    validation {
        condition     = var.subnets_count <= 3
        error_message = "The maximum number of subnets allowed is 3."
  }
}

variable vpc_cidr_block {
  description = "The CIDR block for the VPC"
  type = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
    description = "The name of the VPC"
    type = string
    default = "main"
}
