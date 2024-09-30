resource "aws_route53_zone" "this" {
    comment       = "HostedZone created by Route53 Registrar"
    force_destroy = "false"
    name          = "learning-aws-terraform.com"
    }


resource "aws_route53_record" "this_A_record" {
    zone_id = aws_route53_zone.this.zone_id
    name    = "learning-aws-terraform.com"
    type    = "A"

    alias {
        name                   = var.load_balancer_dns_name
        zone_id                = var.load_balancer_zone_id
        evaluate_target_health = "true"
    }
}


resource "aws_route53_record" "this_NS_record" {
    multivalue_answer_routing_policy = "false"
    set_identifier                   = ""
    name                             = "learning-aws-terraform.com"
    records                          = ["ns-131.awsdns-16.com.", "ns-1368.awsdns-43.org.", "ns-1900.awsdns-45.co.uk.", "ns-954.awsdns-55.net."]
    ttl                              = "172800"
    type                             = "NS"
    zone_id                          = aws_route53_zone.this.zone_id
}

resource "aws_route53_record" "this_SOA_record" {
    multivalue_answer_routing_policy = "false"
    set_identifier                   = ""
    name                             = "learning-aws-terraform.com"
    records                          = ["ns-1900.awsdns-45.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"]
    ttl                              = "900"
    type                             = "SOA"
    zone_id                          = aws_route53_zone.this.zone_id
}

