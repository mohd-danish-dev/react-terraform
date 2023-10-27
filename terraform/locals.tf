locals {
  default_tags = {
    name = "${var.project}-${var.env}"
  }

  bucket_name = "${var.project}-${var.env}-website"
}