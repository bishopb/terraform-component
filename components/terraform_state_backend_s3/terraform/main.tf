# Create resources necessary for Terraform to store state in S3
# @seealso https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa

# Create a bucket to hold the state files, set the bucket to private, and do
# not allow objects to be made public
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.backend_s3_bucket_name
  tags = merge(local.common_tags, {})
  lifecycle {
    ignore_changes = [
      tags["CreatedAt"],
      tags["CreatedBy"]
    ]
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  acl = "private"
}

resource "aws_s3_bucket_public_access_block" "terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state_bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# Create a Dynamo DB table for holding the terraform locks
resource "aws_dynamodb_table" "terraform_state_lock" {
  name = var.backend_s3_lock_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = merge(local.common_tags, {})
  lifecycle {
    ignore_changes = [
      tags["CreatedAt"],
      tags["CreatedBy"]
    ]
  }
}
