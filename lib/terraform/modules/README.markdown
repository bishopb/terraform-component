# lib/terraform/modules

Useful terraform modules that have applicability to multiple projects. Each
module should be its own sub-directory under here, and each of those should have
a `variables.tf` for holding input variables plus an `outputs.tf` for holding the
outputs of that module.

Module names should include an unique string to distinguish them from modules
located in the project itself. For example, `static-s3-site-common/`. This file
is named `README.markdown` (instead of the more usual `README.md`) for this very
reason.
