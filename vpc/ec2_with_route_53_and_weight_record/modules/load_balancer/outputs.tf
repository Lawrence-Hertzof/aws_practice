output "alb_dns_name" {
  value = aws_lb.this_aws_lb.dns_name
  description = "The DNS name of the Application Load Balancer"
}

output "alb_zone_id" {
  value = aws_lb.this_aws_lb.zone_id
  description = "The Zone ID of the Application Load Balancer"
}
