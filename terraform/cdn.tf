resource "aws_cloudfront_distribution" "cdn" {
  enabled = true
  origin {
    origin_id   = "${aws_s3_bucket.app_bucket.bucket}-origin"
    domain_name = "${aws_s3_bucket.app_bucket.bucket}.s3-website.${var.region}.amazonaws.com"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1"]
    }

  }

  default_cache_behavior {
    target_origin_id = "${aws_s3_bucket.app_bucket.bucket}-origin"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      query_string = true

      cookies {
        forward = "all"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  price_class = "PriceClass_200"

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}