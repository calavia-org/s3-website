resource "aws_kms_key" "app_key" {
  description         = "This key is used to encrypt buckets"
  enable_key_rotation = true
  tags                = var.tags
}

module "s3_log_bucket" {
  source = "./modules/s3-bucket"

  bucket_acl  = "log-delivery-write"
  bucket_name = "log.${var.site_domain}"
  kms_key_id  = aws_kms_key.app_key.arn

  tags = {
    Terraform = "true"
    Site      = var.site_domain
  }
}

module "s3_root_bucket" {
  source = "./modules/s3-bucket"

  bucket_acl  = "private"
  bucket_name = var.site_domain
  kms_key_id  = aws_kms_key.app_key.arn

  tags = {
    Terraform = "true"
    Site      = var.site_domain
  }
}