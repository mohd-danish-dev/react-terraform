# s3 static website bucket 
resource "aws_s3_bucket" "app_bucket" {
  bucket        = local.bucket_name
  tags          = local.default_tags
  force_destroy = true
}

# s3 bucket policy
resource "aws_s3_bucket_policy" "app_bucket" {

  depends_on = [
    aws_cloudfront_origin_access_identity.app_oai
  ]

  bucket = aws_s3_bucket.app_bucket.bucket

  policy = <<POLICY
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "RestrictedGetAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_cloudfront_origin_access_identity.app_oai.iam_arn}"
      },
      "Action": "s3:GetObject",
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.app_bucket.bucket}",
        "arn:aws:s3:::${aws_s3_bucket.app_bucket.bucket}/*"
      ]
    }
  ]
}
POLICY
}
