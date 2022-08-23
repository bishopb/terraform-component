# Common environment variables to make available at build time may be placed
# here. These will apply to all project's deployer builds, unless the project
# overrides their values, so care should be taken to only define here what is
# absolutely common to all.
#
# For a discussion of the format and notes, see lib/component_skeleton/build-env.sh

# What version of Terraform do you want to use? Avoid the use of "latest" to
# prevent unexpected incompatibilities from upgrades in Terraform. To test a
# component against a newer version, override that components's TERRAFORM_VERSION
# in its build-env.sh
# @seealso https://hub.docker.com/r/hashicorp/terraform/tags
TERRAFORM_VERSION=1.2.7

# Cache providers at build time, in the path given here. To always download
# providers at deploy time (which slows down deploys), set this value to
# empty string.
TF_PLUGIN_CACHE_DIR="/tmp/terraform.d/plugin-cache"
