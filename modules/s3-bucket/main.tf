resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_versioning" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_id
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_acl" "bucket" {
  bucket = aws_s3_bucket.bucket.id
  acl    = var.bucket_acl
}
resource "aws_s3_bucket_public_access_block" "bucket" {
  bucket = aws_s3_bucket.bucket.id

  ignore_public_acls  = true
  block_public_acls   = true
  block_public_policy = true

  restrict_public_buckets = true
}

resource "aws_s3_bucket_logging" "bucket" {
  count         = var.log_bucket_id != "" ? 1 : 0
  bucket        = aws_s3_bucket.bucket.id
  target_bucket = var.log_bucket_id
  target_prefix = var.log_path
}