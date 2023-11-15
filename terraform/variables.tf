variable "region" {
  description = "AWS region where infrastructure is going to be created."
  default     = "us-east-1"
  type        = string
}

variable "project" {
  description = "Project name"
  default     = "danish"
  type        = string
}

variable "env" {
  type        = string
  default     = "dev"
  description = "defines the running environment"
}