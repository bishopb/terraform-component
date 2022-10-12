# Common environment variables to make available at deploy time may be placed
# here. These will apply to all projects, unless the project overrides their
# values, so care should be taken to only define here what is absolutely
# common to all.
#
# For a discussion of the format and notes, see lib/component_skeleton/deploy-env.sh

# Change how verbose terraform commands are. Unset if you want the default
# terraform verbosity. Common values: debug, info, and warn.
# @see https://www.terraform.io/internals/debugging
# TF_LOG=debug

# Expose the component being deployed as a Terraform variable
TF_VAR_component="${default_TF_VAR_component:-${component_arg}}"

# Expose the project name as a Terraform variable
TF_VAR_project="${default_TF_VAR_project:-terraform-component}"

# Provide a rough idea of who's making this change
TF_VAR_user="${default_TF_VAR_user:-$(whoami)@$(hostname)}"

# Provide a means for all components to use a common backend. Because certain
# values in our backend configuration are dynamic and Terraform does not
# support variables in backend configuration, we set the entire configuration
# here using an environment variables hack, in tandem with the default
# before_terraform_hook in our deployer (see lib/entrypoint).
#
# To disable the use of a common backend in your component, unset TF_VAR_backend
# in your deploy-env.sh file.
#
# To use a common backend but change configuration values, override
# TF_VAR_backend_init_args in the same way as is done here.
#
# These are also made available as Terraform variables, in case your terraform
# files needs to reference them.
#
# If your backend requires authentication, ensure that you pass through (PASSTHRU_ENV)
# or mount (MOUNTPOINTS) credentials that the provider can read.
#
# @seealso https://github.com/hashicorp/terraform/issues/19300
# @seealso https://github.com/hashicorp/terraform/issues/13022#issuecomment-1160613849
# @seealso https://brendanthompson.com/posts/2021/10/dynamic-terraform-backend-configuration
TF_VAR_backend="${default_TF_VAR_backend:-}"
if [[ "${TF_VAR_backend}" = 's3' ]]; then
  TF_VAR_backend_s3_bucket_name="${default_TF_VAR_backend_s3_bucket_name:-${TF_VAR_project}-tfstate-files}"
  TF_VAR_backend_s3_lock_table_name="${default_TF_VAR_backend_s3_lock_table_name:-${TF_VAR_project}-tflock-table}"
  TF_VAR_backend_s3_region="${default_TF_VAR_backend_s3_region:-${AWS_REGION:-}}"
  TF_VAR_backend_tf_file='backend.common.tf'
  TF_VAR_backend_init_args=
  TF_VAR_backend_init_args+="-backend-config=bucket=${TF_VAR_backend_s3_bucket_name} "
  TF_VAR_backend_init_args+="-backend-config=key=${TF_VAR_component}.tfstate "
  TF_VAR_backend_init_args+="-backend-config=dynamodb_table=${TF_VAR_backend_s3_lock_table_name} "
  TF_VAR_backend_init_args+="-backend-config=region=${TF_VAR_backend_s3_region} "
  TF_VAR_backend_init_args+="-backend-config=encrypt=true"
fi

# Pass through the properties and configuration necessary for the providers in
# use. To use no providers, set the value to an empty string. To pass multiple,
# separate each with whitespace.
#
# Since we're using an S3 backend by default, we also want to use the AWS
# provider by default
#
TF_VAR_providers="${default_TF_VAR_providers:-}"
if [[ "${TF_VAR_providers}" = *aws* ]]; then
  [ -n "${AWS_PROFILE:-}" ]    && PASSTHRU_ENV+=" AWS_PROFILE"
  [ -n "${AWS_REGION:-}" ]     && PASSTHRU_ENV+=" AWS_REGION"
  [ -f "${HOME}"/.aws/config ] && MOUNTPOINTS+=" ${HOME}/.aws/config:/root/.aws/config"
fi

# Pass through the credentials for well-known providers. To pass none, set this
# value to the empty string. To pass multiple, separate each with whitespace.
#
# Since we're using an S3 backend by default, we also want to make AWS credentials
# available by default.
#
# Note: Only pass through the credentials you need to support the providers in
# Note: your terraform.
TF_VAR_credentials="${default_TF_VAR_credentials:-}"
if [[ "${TF_VAR_credentials}" = *aws* ]]; then
  [ -n "${AWS_ACCESS_KEY_ID:-}" ]     && PASSTHRU_ENV+=" AWS_ACCESS_KEY_ID"
  [ -n "${AWS_SECRET_ACCESS_KEY:-}" ] && PASSTHRU_ENV+=" AWS_SECRET_ACCESS_KEY"
  [ -n "${AWS_SESSION_TOKEN:-}" ]     && PASSTHRU_ENV+=" AWS_SESSION_TOKEN"
  [ -f "${HOME}"/.aws/credentials ] && MOUNTPOINTS+=" ${HOME}/.aws/credentials:/root/.aws/credentials"
fi

# Silence some of Terraform's interactive-oriented output. There's no value in
# changing this
# @see https://learn.hashicorp.com/tutorials/terraform/automate-terraform
TF_IN_AUTOMATION=true
