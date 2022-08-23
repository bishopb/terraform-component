# Projects may customize the deployer image for their needs through these
# environment variables, which are passed to the docker build command that
# builds the deployer image.
#
# If you do not set these, the indicated defaults will be chosen.
#
# Note that it's considered bad practice for this file to have side-effects
# other than setting the environment variables indicated here.


# Variable:
#   TERRAFORM_VERSION
# Description:
#   The terraform version available in this project's deployer.
#   For list of options, refer to https://hub.docker.com/r/hashicorp/terraform/tags
# Examples:
#   TERRAFORM_VERSION="0.18.1"
#   TERRAFORM_VERSION="1.12.0"
#   TERRAFORM_VERSION="latest"  # avoid this
#

# Variable:
#   TF_PLUGIN_CACHE_DIR
# Description:
#   Where on the deploy container to cache Terraform provider plugins. Caching
#   these at build time saves a lot of time during iterative deployment of
#   resources.
# Examples:
#   TF_PLUGIN_CACHE_DIR="/tmp/terraform.d/plugin-cache"
#
