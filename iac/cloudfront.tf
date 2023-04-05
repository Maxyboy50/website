resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = "s3testorigin"
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }
  aliases = ["quicklinks.max-weitz.com"]
  enabled             = true
  price_class         = "PriceClass_100"
  default_root_object = "index.html"
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.this.arn
    ssl_support_method = "vip"
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "s3testorigin"
    viewer_protocol_policy = "allow-all"
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"

  }
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "example"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
output "distribution_name" {
  value = aws_cloudfront_distribution.this.domain_name
}