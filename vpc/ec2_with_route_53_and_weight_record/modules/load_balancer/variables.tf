### Load Balancer Variables ###
variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "lb_type" {
  description = "The type of the load balancer (application or network)"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "A list of security group IDs to associate with the load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "A list of subnet IDs to associate with the load balancer"
  type        = list(string)
}

variable "lb_tag_name" {
  description = "The name of the load balancer tag"
  type        = string
}

### Target Group Variables ###
variable "load_balancer_tg_name" {
  description = "The name of the target group"
  type        = string
}

variable "tg_port" {
  description = "The port on which targets receive traffic"
  type        = number
}

variable "tg_protocol" {
  description = "The protocol to use for routing traffic to the targets"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID in which to create the target group"
  type        = string
}

variable "ec2_instance_ids" {
  description = "A list of EC2 instance IDs to attach to the target group"
  type        = list(string)
}

variable "tg_tag_name" {
  description = "The name of the target group tag"
  type        = string
}
## Load Balancer Listener Variables ##

variable "lb_listener_tag_name" {
  description = "The name of the load balancer listener tag"
  type        = string
}

