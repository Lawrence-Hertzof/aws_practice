import {
  to = aws_route53_zone.existing_zone
  id = "Z0516356YJK273XBOBXI"
}


resource "aws_route53_zone" "existing_zone" {
    name = "learning-aws-terraform.com"
    comment = "HostedZone created by Route53 Registrar"
    force_destroy = null
}



# resource "aws_route53_record" "ec2_public_ip" {
#   zone_id = aws_route53_zone.existing_zone.id  
#   name    = aws_route53_zone.existing_zone.name   
#   type    = "A"

#   alias { # This is the connection between the Route53 record and the Load Balancer
#     name                   = module.load_balancer.alb_dns_name
#     zone_id                = module.load_balancer.alb_zone_id
#     evaluate_target_health = true
#   }
# }
