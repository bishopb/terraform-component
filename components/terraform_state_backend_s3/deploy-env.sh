# If you would like to pass environment variables to the docker container
# performing the deploy, add them here.
#
# Values given here MUST NOT be secrets, because they are not protected from
# exposure. Values here should be used to drive terraform configuration and
# deploy hook behavior. For example, a configuration variable that sets the name
# of an S3 bucket, or a configuration variable that says whether the deploy hooks
# should output debug information.
#
# To set environment variables that Terraform can read, they must begin with
# TF_VAR_. The subsequent part will be available in terraform as ${var.foo}
#
# Example:
#   TF_VAR_foo="bar"     # available in terraform as ${var.foo}
#
# @seealso https://www.terraform.io/cli/config/environment-variables#tf_var_name
#
# Secrets should be pulled from the target environment using the environment's
# secret store, for example AWS SSM.
#
# @seealso https://stackoverflow.com/a/62329059/2908724
#
# If your deploy environment has secrets to pass through to the deployer, for
# example provider credentials, put the _names_ of those environment variables
# in the special PASSTHRU_ENV variable.
#
# Example:
#  PASSTHRU_ENV+="AWS_ACCESS_KEY_ID AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY"
#
# Finally, note that it's considered bad practice for this file to have
# side-effects other than setting environment variables.

# Solve the state bootstrapping problem.
# If this is the first time deploying this component to the target environment,
# set FIRST_DEPLOY to any non-empty value. The hooks for this component react to
# this variable, switching to local state if this is a first deploy, then
# migrating the local state to the newly-deployed state resources. Once deployed
# set to an empty value (or unset).
FIRST_DEPLOY=true
