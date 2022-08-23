# S3 Backend for Terraform State

Provisions an AWS S3 bucket for holding Terraform state files, as well as an
AWS DynamoDB table for managing locks between simultaneous terraform invocations.

Based on [How to manage Terraform state][howto], by [Yevgeniy Brikman][yb].

howto:https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
yb:https://medium.com/@brikis98
