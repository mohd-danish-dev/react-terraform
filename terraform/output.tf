output "website_url" {
  value = "http://${aws_s3_bucket.app_bucket.bucket}.s3-website.${var.region}.amazonaws.com"
}

output "s3_domain" {
  value = "http://${aws_s3_bucket.app_bucket.bucket_domain_name }"
}