# terraform-component

A configurable workflow framework for deploying infrastructure resources using
[Terraform][tf-home] with immutable [Docker][docker-home] builds.


# Quickstart

1. Fork this repository
1. Create or edit an existing terraform component
1. Deploy one or more terraform components

Example, once you have forked and cloned this repository:

```sh
$ ./bin/terraform-component create my_tf_component
$ ${EDITOR:-vi} components/my_tf_component/terraform/main.tf
$ ./bin/terraform-component deploy my_tf_component plan
```

To deploy a component, you will need to either authenticate with a provider
(like AWS, GCP, or Azure) or use a local implementation (like LocalStack). Read
on for more on authentication. Or install a local implementation and get started.

For example, if you have already authenticated to AWS, then you can safely pass
through the AWS configuration and credentials, like so:

```sh
$ export default_TF_VAR_providers=aws
$ export default_TF_VAR_credentials=aws
$ ./bin/terraform-component deploy my_tf_component plan
```

# Overview

A component is an isolated unit of infrastructure, defined as Terraform HCL. This
mono-repo supports multiple components, a suite of tools to help deploy them, and
common functionality to enhance component collaboration.

## Motivation

In ["What is Terraform?"][tf-whatis], HashiCorp says (emphasis ours):

> HashiCorp Terraform is an infrastructure as code tool that lets you define
> both cloud and on-prem resources in human-readable configuration files that
> you can version, reuse, and share. _You can then use a consistent workflow to
> provision and manage all of your infrastructure throughout its lifecycle._

Terraform, as a tool ecosystem, neither provides a consistent deployment workflow
nor has an opinion on how such a workflow should be written. This gap leads to
workflow frameworks like [Terragrunt][terragrunt-home] and this framework.

## Guiding principles

Workflow frameworks are opinionated. They dictate configuration format and
organization, workflow initiation and intervention, error handling, and so on.
This framework adopts the following principles:

1. *Only `terraform`, `docker`, `bash`, and POSIX tools need to be installed.*
   Fewer dependencies means its easier to get started. Conventional dependencies
   means less has to be learned to use the framework.
1. *Configuration is written in `bash` and supports all programmatic features of
   `bash` 3+*. Terraform is declarative, but shell programming and tools provide
   lots more control over the generated Terraform.
1. *Each terraform action comes from a uniquely tagged immutable image.* Changes
   made to infrastructure must be from authoritative source that is traceable
   back to a single point of control.
1. *Common needs should be automatic. Uncommon needs should be easy.* Provider
   configuration and authentication, remote state management, universal resource
   tags, and many more common features should be built in. Where no built-in
   exists, it should be easy to make one.
1. *The overhead must be small and the runtime fast.* The framework must not
   get in the way of a developer by being slow, bulky, or hard to use.

## Operation

This workflow framework organizes resources into components, which as mentioned
are isolated units of infrastructure.

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

[docker-home]:https://www.docker.com
[terragrunt-home]:https://terragrunt.gruntwork.io/
[tf-home]:https://www.terraform.io
[tf-whatis]:https://www.terraform.io/intro
[ref-1]:https://support.hashicorp.com/hc/en-us/articles/4547786359571
