variable "aws_region" {
  type        = string
  description = "The AWS region to put the bucket into"
}
variable "kms_key" {
  type        = string
  description = "The KMS Key identifier"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "site_domain" {
  type        = string
  description = "The domain name to use for the static site"
}

variable "common_tags" {
  description = "Common tags you applied to all components."
}
