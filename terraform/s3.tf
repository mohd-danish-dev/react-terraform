# s3 static website bucket 
resource "aws_s3_bucket" "app_bucket" {
  bucket = "react-tf-webapp"
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

#s3 bucket ACL access
resource "aws_s3_bucket_ownership_controls" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_acl" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id
  depends_on = [
    aws_s3_bucket_ownership_controls.app_bucket,
    aws_s3_bucket_public_access_block.app_bucket
  ]

  acl = "public-read"
}


# s3 bucket policy
resource "aws_s3_bucket_policy" "app_bucket" {
  bucket = aws_s3_bucket.app_bucket.id

  policy = <<POLICY
{
  "Id": "Policy",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.app_bucket.bucket}/*",
      "Principal": {
        "AWS": [
          "*"
        ]
      }
    }
  ]
}
POLICY
}