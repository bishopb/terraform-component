# Projects may customize the deployer image for their needs through these
# environment variables, which are passed to the docker build command that
# builds the deployer image.
#
# If you do not set these, the indicated defaults will be chosen.
#
# Note that it's considered bad practice for this file to have side-effects
# other than setting the environment variables indicated here.
#
# Variable:
#   TERRAFORM_VERSION
# Description:
#   The terraform version available in this project's deployer.
#   For list of options, refer to https://hub.docker.com/r/hashicorp/terraform/tags
# Default Value:
#   latest
# Examples:
#   TERRAFORM_VERSION="0.18.1"
#   TERRAFORM_VERSION="1.12.0"
#   TERRAFORM_VERSION="latest"
#
