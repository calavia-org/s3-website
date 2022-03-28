variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
}

variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "tags" {
  description = "Default"
  type        = map(string)
  default = {
    Terraform = "true"
  }
}

