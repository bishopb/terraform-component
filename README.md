# terraform-component

A configurable wrapper for easily deploying [Terraform][tf-home] components.


# Getting started

1. Clone this repository
1. Create or edit an existing terraform component
1. Deploy one or more terraform components

Example, once you have cloned this repository:

```sh
$ ./bin/terraform-component create my_tf_component
$ ${EDITOR:-vi} components/my_tf_component/terraform/main.tf
$ ./bin/terraform-component deploy my_tf_component plan
```

To deploy a component, you will need to either authenticate with a provider
(like AWS, GCP, or Azure) or use a local implementation (like LocalStack). Read
on for more on authentication. Or install a local implementation and get started.


# Overview

A component is an isolated unit of cloud functionality. This mono-repo holds
multiple components, a suite of tools to help deploy them, and common
functionality to enhance component collaboration.

## Directory organization

* `bin` contains tools useful for generating and deploying multiple terraform
  components.
* `components` contains sub-directories, one for each separate terraform-based 
  component. You might want to use git sub-modules to separate your components
  from this wrapper.
* `lib` contains modules useful and common functionality that is to be used
  across multiple terraform components. By adjusting configuration files in this
  folder you can alter overall component behavior, activate common features, and
  more.

## Operation

When you select a component to deploy, this wrapper will combine the common files
from `lib` with the component specific files from `components/` into a build
directory, `work/build/`. A Terraform-based docker image will then be made around
these files, which will then be run to plan, apply, or destroy the resources as
given by the build files.

If the terraform action produces a state file, it will be stashed and made available
in the next build. However, the state file is stashed outside of the git repository,
so you cannot commit it (which is good, as it contains secrets). While local state
files are useful for local development, it's recommended to use a remote state
storage for any production use.

To debug the result of the terraform, inspect the contents of the `work/deploy`
directory after the deploy action completes. Note that these contents are made
available by copying the results after the docker container finishes, not by
mounting the docker container.

## State storage

By default, state storage is maintained locally. If you would like to store state
remotely, set the `TF_VAR_backend` variable as described in `lib/deploy-env.sh`.
Remember to also set corresponding configuration and credentials behavior.

## Authentication

To use an authenticated remote state storage, or indeed any resources requiring
authentication, you will need to pass the configuration and credentials for the
provider into the Docker container.

The best way to do this is by selecting your providers and credentials from the
list of supported ones in `lib/deploy-env.sh`. For example, to set AWS as your
provider and pass in credentials from your local environment to the container,
set `TF_VAR_providers="aws"` and `TF_VAR_credentials="aws"` in `lib/deploy-env.sh`.

## References

* [Reading environment variables in Terraform][ref-1]

[tf-home]:https://www.terraform.io
[ref-1]:https://support.hashicorp.com/hc/en-us/articles/4547786359571
