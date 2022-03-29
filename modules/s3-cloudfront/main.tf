resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Access identity for ${var.origin_domain}"
}
# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = var.bucket_id
#   policy = templatefile("templates/s3-policy.json", { bucket = var.bucket_arn })
# }

# resource "aws_cloudfront_response_headers_policy" "response_headers_policy" {
#   name = var.origin_domain
# }
# resource "aws_cloudfront_distribution" "s3_cloudfront_distribution" {
#   origin {
#     domain_name = var.origin_domain
#     origin_id   = var.origin_id

#     s3_origin_config {
#       origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
#     }
#     response_headers_policy_id = aws_cloudfront_response_headers_policy.response_headers_policy.id
#   }

#   enabled = true
#   #   is_ipv6_enabled     = true
#   #   default_root_object = "index.html"

#   #   aliases = ["www.${var.domain_name}"]

#   #   custom_error_response {
#   #     error_caching_min_ttl = 0
#   #     error_code            = 404
#   #     response_code         = 200
#   #     response_page_path    = "/404.html"
#   #   }

#   #   default_cache_behavior {
#   #     allowed_methods  = ["GET", "HEAD"]
#   #     cached_methods   = ["GET", "HEAD"]
#   #     target_origin_id = "S3-www.${var.bucket_name}"

#   #     forwarded_values {
#   #       query_string = false

#   #       cookies {
#   #         forward = "none"
#   #       }
#   #     }

#   #     viewer_protocol_policy = "redirect-to-https"
#   #     min_ttl                = 31536000
#   #     default_ttl            = 31536000
#   #     max_ttl                = 31536000
#   #     compress               = true
#   #   }


#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   logging_config {
#     include_cookies = false
#     bucket          = var.logging_bucket
#     prefix          = "access"
#   }

#   viewer_certificate {
#     acm_certificate_arn      = var.certificate_arn
#     ssl_support_method       = "sni-only"
#     minimum_protocol_version = "TLSv1.2_2018"
#   }

#   tags = var.tags
# }

# # # Cloudfront S3 for redirect to www.
# # resource "aws_cloudfront_distribution" "root_s3_distribution" {
# #   origin {
# #     domain_name = aws_s3_bucket.root_bucket.website_endpoint
# #     origin_id   = "S3-.${var.bucket_name}"
# #     custom_origin_config {
# #       http_port              = 80
# #       https_port             = 443
# #       origin_protocol_policy = "http-only"
# #       origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
# #     }
# #   }

# #   enabled         = true
# #   is_ipv6_enabled = true

# #   aliases = [var.domain_name]

# #   default_cache_behavior {
# #     allowed_methods  = ["GET", "HEAD"]
# #     cached_methods   = ["GET", "HEAD"]
# #     target_origin_id = "S3-.${var.bucket_name}"

# #     forwarded_values {
# #       query_string = true

# #       cookies {
# #         forward = "none"
# #       }

# #       headers = ["Origin"]
# #     }

# #     viewer_protocol_policy = "allow-all"
# #     min_ttl                = 0
# #     default_ttl            = 86400
# #     max_ttl                = 31536000
# #   }

# #   restrictions {
# #     geo_restriction {
# #       restriction_type = "none"
# #     }
# #   }

# #   viewer_certificate {
# #     acm_certificate_arn      = aws_acm_certificate_validation.cert_validation.certificate_arn
# #     ssl_support_method       = "sni-only"
# #     minimum_protocol_version = "TLSv1.1_2016"
# #   }

# #   tags = var.common_tags
# # }