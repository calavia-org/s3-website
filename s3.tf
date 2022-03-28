resource "aws_kms_key" "app_key" {
  description         = "This key is used to encrypt buckets"
  enable_key_rotation = true
  tags                = var.common_tags
}

resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.${var.bucket_name}"
  tags   = var.common_tags
}

resource "aws_s3_bucket_acl" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id
  acl    = "public-read"
  tags   = var.common_tags
}

resource "aws_s3_bucket_versioning" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
  tags = var.common_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.app_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
  tags = var.common_tags
}
resource "aws_s3_bucket_public_access_block" "www_bucket" {
  bucket = aws_s3_bucket.site.id

  ignore_public_acls  = true
  block_public_acls   = true
  block_public_policy = true

  restrict_public_buckets = true
  tags                    = var.common_tags
}

resource "aws_s3_bucket_logging" "www_bucket" {
  bucket        = aws_s3_bucket.www_bucket.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "log/"
  tags          = var.common_tags
}

resource "aws_s3_bucket_website_configuration" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  tags = var.common_tags
}


resource "aws_s3_bucket_policy" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })
  tags   = var.common_tags
}

resource "aws_s3_bucket_cors_configuration" "www_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket

  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://www.${var.domain_name}"]
    max_age_seconds = 3000
  }
  tags = var.common_tags
}

# S3 bucket for redirecting non-www to www.
resource "aws_s3_bucket" "root_bucket" {
  bucket = var.bucket_name
  policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_name })

    redirect_all_requests_to = "https://www.${var.domain_name}"
  tags = var.common_tags
}

resource "aws_s3_bucket_website_configuration" "root_bucket" {
  bucket = aws_s3_bucket.root_bucket.id

  tags = var.common_tags
}
resource "aws_s3_bucket_policy" "root_bucket" {
  bucket = aws_s3_bucket.root_bucket.id
  policy = templatefile("templates/s3-policy.json", { bucket = "www.${var.bucket_name}" })
  tags   = var.common_tags
}

