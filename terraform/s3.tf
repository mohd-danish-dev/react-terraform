# s3 static website bucket 
resource "aws_s3_bucket" "app_bucket" {
  bucket = local.bucket_name
  tags   = local.default_tags

}


# static bucket configuration
resource "aws_s3_bucket_website_configuration" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id
  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

}

# s3 bucket policy
resource "aws_s3_bucket_policy" "app_bucket" {
  depends_on = [aws_cloudfront_distribution.cdn]
  bucket     = aws_s3_bucket.app_bucket.id

  policy = <<POLICY
{
    "Id": "AccesPolicy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.app_bucket.bucket}/*"
    }
  ]
}
POLICY
}