resource "aws_route53_zone" "existing_zone" {
    name = "learning-aws-terraform.com"
    comment = "HostedZone created by Route53 Registrar"
    force_destroy = null

  # lifecycle {
  #   prevent_destroy = true
  # }
}



# resource "aws_route53_record" "ec2_public_ip" {
#   zone_id = aws_route53_zone.existing_zone.id  
#   name    = aws_route53_zone.existing_zone.name   
#   type    = "A"
#   # ttl     = 300 # TTL conflicts with the alias record

#   # records = [aws_instance.example_ec2_private_instance.public_ip] # This is the connection between the EC2 instance and the Route53 record
#   # depends_on = [aws_instance.example_ec2_private_instance]

#   alias { # This is the connection between the Route53 record and the Load Balancer
#     name                   = aws_lb.example_load_balancer.dns_name
#     zone_id                = aws_lb.example_load_balancer.zone_id
#     evaluate_target_health = true
#   }
# }



