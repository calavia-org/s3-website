variable "bucket_id" {
  description = "The bucket id to configure website."
  type        = string
}

variable "config" {
  description = "Site configuration paramters"
  type = object({
    index_document  = string
    error_document  = string
    allowed_headers = list(string)
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = list(string)
    max_age_seconds = number
  })
  default = null
}
variable "redirect_all_request_to_target" {
  description = "The bucket id to configure website."
  type = object({
    host_name = string
    protocol  = string
  })
  default = null
}
