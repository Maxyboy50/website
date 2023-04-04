resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id                = "s3testorigin"
    origin_access_control_id = aws_cloudfront_origin_access_identity.this.id
  }
  enabled             = true
  price_class         = "PriceClass_100"
  default_root_object = "index.html"
  viewer_certificate {
    cloudfront_default_certificate = true
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

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "Some comment"
}
output "distribution_name" {
  value = aws_cloudfront_distribution.this.domain_name
}