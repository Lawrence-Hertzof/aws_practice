output "subnet_ids" {
    value = aws_subnet.this[*].id
}

# output "load_balancer_sg_id" {
#     value = aws_security_group.this_load_balancer_sg.id
# }

output "ecs_sg_id" {
    value = aws_security_group.this_ecs_sg.id
}

output "vpc_id" {
    value = aws_vpc.this.id
}