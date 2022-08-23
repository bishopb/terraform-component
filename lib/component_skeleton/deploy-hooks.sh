# Components may run custom actions during a deploy, using hooks documented
# within this file.
#
# Hooks are written as bash functions, using names as defined below. They are
# useful for inspecting or modifying the deploy time environment outside of
# the declarative way Terraform runs, but they should be used sparingly: almost
# always Terraform can do what needs to be done.
#
# If a hook exits with a non-zero status code, that is considered a run-time
# failure of the deployer, and the deployer fails.
#
# See lib/entrypoint for the default behavior of these hooks, as well as any
# other hooks and features that may be available. To run the default hook
# behavior within a custom hook, using has_default_hook and run_default_hook
# functions available in lib/entrypoint.

# Hook:
#   before_terraform
# Description:
#   Run before any terraform command runs, including terraform init
# Arguments:
#   1. The terraform action
#   2. The path to the terraform files
#
### before_terraform() {
###   :
### }

# Hook:
#   after_terraform
# Description:
#   Run after all terraform commands run, regardless of whether terraform
#   succeeded or not.
# Arguments:
#   1. The exit code of the last terraform command
#
### after_terraform() {
###   :
### }

# Hook:
#   before_terraform_init
# Description:
#   Run only before the terraform init.
# Arguments:
#   The arguments to pass to terraform init
#
### before_terraform_init() {
###   :
### }

# Hook:
#   after_terraform_init
# Description:
#   Run only after the terraform init.
# Arguments:
#   1. The exit code of the terraform init
#
### after_terraform_init() {
###   :
### }

# Hook:
#   before_terraform_plan
# Description:
#   Run only before a terraform plan.
# Arguments:
#   The arguments to pass to terraform plan
#
### before_terraform_plan() {
###   :
### }

# Hook:
#   after_terraform_plan
# Description:
#   Run only after a terraform plan.
# Arguments:
#   1. The exit code of the terraform plan
#
### after_terraform_plan() {
###   :
### }

# Hook:
#   before_terraform_apply
# Description:
#   Run only before a terraform apply.
# Arguments:
#   The arguments to pass to terraform apply
#
### before_terraform_apply() {
###   :
### }

# Hook:
#   after_terraform_apply
# Description:
#   Run only after a terraform apply.
# Arguments:
#   1. The exit code of the terraform apply
#
### after_terraform_apply() {
###   :
### }

# Hook:
#   before_terraform_destroy
# Description:
#   Run only before a terraform destroy.
# Arguments:
#   The arguments to pass to terraform destroy
#
### before_terraform_destroy() {
###   :
### }

# Hook:
#   after_terraform_destroy
# Description:
#   Run only after a terraform destroy.
# Arguments:
#   1. The exit code of the terraform destroy
#
### after_terraform_destroy() {
###   :
### }
