terraform {
  backend "s3" {
    bucket = "react-terraform-state-data"
    key    = "terraform-state"
    region = "ap-south-1"
  }
}