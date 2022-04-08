resource "aws_s3_bucket_website_configuration" "redirect_bucket" {
  count  = (var.redirect_all_request_to_target != null) ? 1 : 0
  bucket = var.bucket_id
  redirect_all_requests_to {
    host_name = var.redirect_all_request_to_target.host_name
    protocol  = var.redirect_all_request_to_target.protocol
  }
}

resource "aws_s3_bucket_website_configuration" "bucket" {
  count  = (var.redirect_all_request_to_target != null) ? 0 : 1
  bucket = var.bucket_id

  index_document {
    suffix = var.config.index_document
  }

  error_document {
    key = var.config.error_document
  }
}


resource "aws_s3_bucket_cors_configuration" "bucket" {
  count  = (var.redirect_all_request_to_target != null) ? 0 : 1
  bucket = var.bucket_id

  cors_rule {
    allowed_headers = var.config.allowed_headers
    allowed_methods = var.config.allowed_methods
    allowed_origins = var.config.allowed_origins
    max_age_seconds = var.config.max_age_seconds
    expose_headers  = var.config.expose_headers
  }
}

# resource "aws_s3_bucket_policy" "bucket" {
#   bucket = var.bucket_id
#   policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })
#   tags   = var.tags
# }
