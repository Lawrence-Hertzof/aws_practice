variable "ec2_instance_count" {
  description = "Number of EC2 instances to create"
  type        = number  
}

variable "ec2_ami" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0aff18ec83b712f05"
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "ec2_key_name" {
  description = "Key pair name for the EC2 instances"
  type        = string
}

variable "ec2_subnets" {
  description = "Subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "ec2_security_groups" {
  description = "Security group IDs for the EC2 instances"
  type        = list(string)
}

variable "ec2_key_path" {
  description = "Path to the private key file for the EC2 instances"
  type        = string
}

variable "ec2_instance_name" {
  description = "Name for the EC2 instances"
  type        = string
}