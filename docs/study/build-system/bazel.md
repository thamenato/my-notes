# Bazel

## Overview

### Benefits

- **High-level build language**: uses am abstract, human-readable language; uses
  concepts like libraries, binaries, scripts, and data sets.

- **Fast and reliable**: caches all previously done work and track changes to
  both file content and build commands. This is how bazel knows when something
  needs to be rebuilt and rebuilds only that.

- **Multi-platform**: can run in any platform and build binaries and deployable
  packages for it as well.

- **Scales**: can handle 100k+ source files. Works in multiple repositories and
  user bases in the tens of thousands.

- **Extensible**: many languages are supported and you can extend it as well.

### Using Bazel

- Set up a project _workspace_, which tells bazel the directory that it should
  look for build inputs and `BUILD` files, also where to store the build
  outputs.

- Write `BUILD` file, this tells Bazel what to build and how to build it.

- Startlak is a domain-specific language (subset of python).

- Run bazel from the terminal, you can run tests and query the build to trace
  dependencies.

### Build process

1. **Loads** the `BUILD` files relevant to the target.

2. **Analyzes** the inputs and their dependencies, applies the specified build
   rules, and produces an action graph.

3. **Executes** the build actions on the inputs until the final build outputs
   are produced.

> [!NOTE]
> Because of it's cache, Bazel can identify and reuse cached artifacts and only
> rebuild or retest what's changed. **To further enforce correctness, you can
> set up Bazel to run builds and tests hermetically through sandboxing,
> minimizing skew and maximizing reproducibility.**

#### Action Graph

Represents the build artifacts, the relationships between them, and the build
actions that Bazel will perform. This is how Bazel can track changes to file
content and well as changes to actions.

## Why Bazel ?

- Bazel is fast: knows exactly what input files each build command needs
  avoiding unnecessary work by re-running only when the set of input files have
  changed between each build.

- Bazel is correct: ensures that your binary are built _only_ from your own
  source code. Bazel actions run in individual sandboxes and Bazel tracks every
  input file of the build.

- Bazel is extensible: you can write your own rules and macros to customize
  Bazel for your specific needs across a wide range of projects. These rules are
  written in Starlak.

- Integrated testing: it knows and runs only those tests needing to be re-run,
  using remote execution (if available) to run them in parallel. It also provide
  facilities to upload test results to a central location.

- Multi-language support: supports many common programming languages including
  C++, Java, Kotlin, Python, Go and Rust. You can build multiple binaries in the
  same Bazel invocation.

- Multi-repository support: it can gather source code from multiple locations -
  you don't need to vendor your dependencies (but you can).

- Multi-platform support: it can simultaneously build projects for multiple
  platforms including Linux, MacOs, Windows and Android. It also provides
  powerful cross-compilation capabilities.

- Wide ecosystem: there's a large community of developers who use and contribute
  to Bazel. Including consulting and SaaS offerings.

## Bazel Vision

- **Engineers can take build fundamentals for granted.** SWE can focus on
  authoring code because the process of build and test is solved.

- **Engineers can easily contribute to any project.** Developer who wants to
  start working on a new project can simply clone the project and run the build.
  No need for local configuration.

- **Projects can sacle to any size codebase, any size team.** Fast, incremental
  testing allows teams to fully validate every change before it is committed.

## What should I not use Bazel for?

- Bazel tries to be smart about caching. This means that it is not good for
  running build operations whose outputs should not be cached. E.g:

  - A compilation step that fetches data from the internet.
  - A test step that connects to the QA instance of your site.
  - A deployment step that changes your site's cloud configuration.

- If your build consists of a few long, sequential steps, Bazel may not be able
  to help much. You'll get more spped by breaking long steps into smaller,
  discrete targets that Bazel can run in parallel.
