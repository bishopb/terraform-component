# outputs.tf
# If your project exposes any well-known resources, put them here.

output "terraform_state_bucket_name" {
  description = "The AWS S3 bucket holding the state files for each component"
  value = var.backend_s3_bucket_name
}

output "terraform_state_lock_table" {
  description = "The AWS DynamoDB table name holding the Terraform lock state"
  value = var.backend_s3_lock_table_name
}
