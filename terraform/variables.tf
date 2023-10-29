variable "region" {
  description = "AWS region where infrastructure is going to be created."
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  type        = string
  description = "defines the running environment"
}
