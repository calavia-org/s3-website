variable "bucket_arn" {
  description = "S3 origin bucket arn"
  type        = string
}

variable "bucket_id" {
  description = "S3 origin bucket id"
  type        = string
}

variable "certificate_arn" {
  description = "ACM certificate arn"
  type        = string
}

variable "logging_bucket" {
  description = "S3 bucket to Cloudfront log into"
  type        = string
}

variable "origin_domain" {
  description = "The s3-bucket website domain."
  type        = string
}
variable "origin_id" {
  description = "A unique identifier for the origin."
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
