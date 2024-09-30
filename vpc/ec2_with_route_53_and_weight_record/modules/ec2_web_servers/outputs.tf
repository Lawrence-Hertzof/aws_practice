# modules/ec2_module/outputs.tf

output "instance_ids" {
  description = "The IDs of all the EC2 instances"
  value       = aws_instance.this.*.id
}

# In the expression aws_instance.this.*.id:

# aws_instance.this refers to the resource type (aws_instance) and name (this) within the module.
# * is the splat operator that accesses all instances of the aws_instance.this resource.
# .id specifies that you want to retrieve the id attribute for each instance of the aws_instance.this resource.