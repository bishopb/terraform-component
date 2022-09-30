# Frequently Asked Questions



## How can I look for components from multiple directories?

Set the `COMPONENT_PATH` variable to a colon separate list of directories
containing your terraform components.



## How can I use this library without maintaining a fork?

Forking is, by far, the easiest way to have your own components live alongside
this tool and its components. Unfortunately, forking isn't always an option (for
technical or maintenance reasons), so there is an alternative use case:

1. In your code base, create an installation script that will download a version
of this tool. [The easiest way is to use `curl`/`tar` as documented in this
Stack Overflow answer.][so-how-to-dl-gh]
2. Arrange for the download directory to be ignored by your version control
system.
3. Create a deploy script that will invoke this tool from the download directory,
making sure to tell the tool to search your component directory.

Here's how that might look:

```sh
$ tree
.
├── components
│   └── my-private-component
├── deployer
└── package.json

$ cat .gitignore
/deployer/

$ cat package.json
{
  "name": "my-terraform-components",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "install": "curl -L https://api.github.com/repos/bishopb/terraform-component/tarball | tar xzC deployer --strip 1",
    "deploy": "cd deployer && COMPONENT_PATH=../components:./components ./bin/terraform-component"
  }
}
```

In this example, we're using `npm` and its script-running ability to add some
simple scripting to our repository. We could use composer, cargo, or any other
dependency management framework, or just write plain old shell scripts.

This scripting will download the latest version of this repository when
running `npm install` and store it in the `deployer` directory, which is ignored
by the version control system in this example (per the `.gitignore` file).

Then, running `npm deploy` dispatches to this tool, passing along any arguments.
The `COMPONENT_PATH=...` part tells this tool to look for components in two
locations: first, the `components` directory that is sibling to the `deployer`
directory and second, the `components` directory that is a child of `deployer`.
The former is where our private components are and the latter is the standard
components from this tool.

[so-how-to-dl-gh]:https://stackoverflow.com/a/25060822/2908724


## How can I add or remove providers?

Create a file named `providers_override.tf` (or similar, it's only important
it end in `_override.tf`) and in that file specify the providers you need. The
built deploy container will have a lock file that matches the resolution of
those providers with the default ones.
