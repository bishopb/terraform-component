# lib/terraform/

Common terraform files live here. All of these will be copied in to the work
directory at build-time. Feel free to place terraform here that is useful across
a wide-variety of projects. Often, these are data resources.

To avoid file name collisions, consider adding a unique string to every file in
this directory, for example `common-dns.tf` or `dns.common.tf`. This file,
for example, is called `README.markdown` (rather than the usual seen elsewhere,
`README.md`) so as to limit collisions with project files.
