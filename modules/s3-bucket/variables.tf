variable "bucket_acl" {
  type        = string
  description = "The ACL for the bucket"
}

variable "bucket_name" {
  type        = string
  description = "Name of the s3 bucket. Must be unique."
}

variable "kms_key_id" {
  type        = string
  description = "The KMS Key identifier."
}

variable "log_bucket_id" {
  type        = string
  description = "The bucket id to log into."
  default     = ""
}
variable "log_path" {
  type        = string
  description = "The path inside bucket to log."
  default     = "log/"
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
