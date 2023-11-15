resource "aws_cloudfront_origin_access_identity" "app_oai" {
  comment = "${local.bucket_name}-oai"
}

resource "aws_cloudfront_distribution" "cdn" {
  depends_on          = [
    aws_cloudfront_origin_access_identity.app_oai,
    aws_s3_bucket.app_bucket
  ]
  enabled             = true
  default_root_object = "index.html"
  tags                = local.default_tags
  origin {
    origin_id   = aws_s3_bucket.app_bucket.id
    domain_name = aws_s3_bucket.app_bucket.bucket_domain_name

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.app_oai.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.app_bucket.id
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