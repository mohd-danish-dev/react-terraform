variable "region" {
  description = "AWS region where infrastructure is going to be created."
  default     = "ap-south-1"
  type        = string
}

variable "project" {
  description = "Project name"
  default     = "react-terraform-sample"
  type        = string
}