# the default provider, will use whatever region is available from AWS_REGION
# or the AWS_PROFILE
provider "aws" {
  # avoid the use of default_tags: they're odd to work with
  # @see https://github.com/hashicorp/terraform-provider-aws/issues/19204
  # @see https://support.hashicorp.com/hc/en-us/articles/4406026108435
}
