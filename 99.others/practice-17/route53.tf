data "aws_route53_zone" "this" {
  name = var.domain
}

resource "aws_route53_record" "foo" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "foo.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.this.public_ip]
}

resource "aws_route53_record" "bar" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "bar.${var.domain}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.this.public_ip]
}
