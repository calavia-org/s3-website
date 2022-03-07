provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "site" {
  bucket = var.site_domain
}

# resource "aws_s3_bucket_website_configuration" "site" {
#   bucket = aws_s3_bucket.site.id

#   # index_document {
#   #   suffix = "index.html"
#   # }

#   # error_document {
#   #   key = "error.html"
#   # }
# }

# resource "aws_s3_bucket_acl" "site" {
#   bucket = aws_s3_bucket.site.id
#   acl = "public-read"
# }

# resource "aws_s3_bucket_policy" "site" {
#   bucket = aws_s3_bucket.site.id

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource = [
#           aws_s3_bucket.site.arn,
#           "${aws_s3_bucket.site.arn}/*",
#         ]
#       },
#     ]
#   })
# }

# resource "aws_s3_bucket" "www" {
#   bucket = "www.${var.site_domain}"
# }

# resource "aws_s3_bucket_acl" "www" {
#   bucket = aws_s3_bucket.www.id
#   acl = "private"
# }

# resource "aws_s3_bucket_website_configuration" "www" {
#   bucket = aws_s3_bucket.site.id
#   redirect_all_requests_to {
#     host_name = var.site_domain
#   }
# }

# resource "aws_iam_openid_connect_provider" "github" {
#   url             = "https://token.actions.githubusercontent.com"
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = ["a031c46782e6e6c662c2c87c76da9aa62ccabd8e"]
# }
