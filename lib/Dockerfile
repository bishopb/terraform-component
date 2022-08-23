ARG TERRAFORM_VERSION
FROM hashicorp/terraform:${TERRAFORM_VERSION}

WORKDIR /opt/terraform-component/deployer

USER root

# install the providers we'll want now, at build time, so deploy don't
# waste time doing the same over and over again (also avoiding transient
# network errors). We don't use the lock file, and there's no way to disable
# it, so we'll copy it to our cache directory and then copy it back at deploy
# time to avoid an annoying warning
# @see https://github.com/hashicorp/terraform/issues/27506#issuecomment-771166854
ARG TF_PLUGIN_CACHE_DIR=
COPY terraform/providers.common.tf terraform/providers.common.tf
RUN if [ -n "${TF_PLUGIN_CACHE_DIR}" ]; then \
    mkdir -p "${TF_PLUGIN_CACHE_DIR}" \
    && cd terraform \
    && terraform init \
    && cp .terraform.lock.hcl "${TF_PLUGIN_CACHE_DIR}";\
  fi

# copy in the terraform files
COPY . .

ENTRYPOINT [ "/opt/terraform-component/deployer/entrypoint" ]
