# define tags that should be common on all resources
#
# Apply these with:
#   tags = merge(local.common_tags, { OtherTag = Foo })
#
# Note: We choose to do it manually, rather than the providers' default_tags
# Note: so that we have flexibility across all providers and to avoid edge
# Note: cases with their use.
#
# @seealso https://support.hashicorp.com/hc/en-us/articles/4406026108435
locals {
  common_tags = {
    # Note: to avoid Created values being overwritten each deploy, add a lifecycle
    # Note: block to every resource, like so:
    # Note: lifecycle { ignore_changes = [ tags["CreatedAt"], tags["CreatedBy"] ] }
    CreatedAt  = timestamp()
    CreatedBy  = var.user
    ModifiedAt = timestamp()
    ModifiedBy = var.user
    Project    = var.project
    Component  = var.component
    ImageTag   = var.image_tag
    Repository = var.repository
    Product    = var.product
  }
}
