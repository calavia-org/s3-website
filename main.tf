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

module "s3_www_bucket" {
  source = "./modules/s3-bucket"

  bucket_acl  = "private"
  bucket_name = "www.${var.site_domain}"
  kms_key_id  = aws_kms_key.app_key.arn

  tags = {
    Terraform = "true"
    Site      = var.site_domain
  }
}

module "s3_root_website_config" {
  source    = "./modules/s3-website"
  bucket_id = module.s3_root_bucket.id

  redirect_all_request_to_target = {
    host_name = "www.${var.site_domain}"
    protocol  = "https"
  }
}

module "s3_www_website_config" {
  source    = "./modules/s3-website"
  bucket_id = module.s3_www_bucket.id

  config = {
    index_document  = "index.html"
    error_document  = "error.html"
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://www.${var.site_domain}"]
    expose_headers  = []
    max_age_seconds = 3000
  }
}
