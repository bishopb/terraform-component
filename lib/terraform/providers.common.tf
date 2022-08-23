# Explicitly declare the providers (and their versions) that you need. This
# avoids the problem of Terraform guessing what provider you mean and also
# allows us to incorporate these at build time (rather than deploy time),
# thereby speeding up iteration on deploy changes.
# @see https://stackoverflow.com/a/68277378/2908724

terraform {
  required_providers {
    aws = {
      source = "registry.terraform.io/hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
