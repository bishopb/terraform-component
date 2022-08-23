# variables.tf
# If your project requires any variable input, define them here.

variable "backend_s3_bucket_name" {
  type = string
  description = "The AWS S3 bucket holding the state files for each component"
  sensitive = false
  nullable = false
}

variable "backend_s3_lock_table_name" {
  type = string
  description = "The AWS DynamoDB table name holding the Terraform lock state"
  sensitive = false
  nullable = false
}
