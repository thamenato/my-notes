# Build System Basics

## Why a Build System?

Fundamentally, all build system have a straightforward purpose: they transform
the source code written by engineers into executable binaries that can be read
by machines. In an organization with thousands of engineers, it's common that
most builds are triggered automatically rather than directly by engineers.

### Can't I just use a compiler?

As soon as code expands, the complications begin. The compiler might not be
smart enough to look into subdirectories of the current directory to find code
to import. It also only knows how to compile for a specific language. Large
systems often involve different pieces written in different languages.

Once you're dealing with multiple languages or multiple compilation units,
building code is no longer a one-step process.

### What about shell scripts?

You can automate the tedious part using some simple shell scripts that take care
of building things in the correct order. This might help for a while but pretty
soon you start running into even more problems:

- It becomes tedious. As the system grows more complex you start spending almost
  as much time working on build scripts than real code.

- It's slow. You have to build every dependency in order every time you run it,
  then adding logic to detect which parts need to be rebuilt sounds awfully
  complex and error prone for a script.

- During release it might have lots of arguments and even manual steps to pass
  to these scripts which you might decide to automate with... another script.

- If something happens to the local/remote environment and you have to rebuilt
  the entire system how can you guarantee that the libraries and CLIs are the
  correct version?

- It's hard to onboard someone else to the team, it frequently works on one
  person's machine but doesn't work on another's.

More examples [here](https://bazel.build/basics/build-systems).

## Task-Based Build Systems

After shell scripts, task-based build systems are the next logical evolution of
building.

In a task-based build system, the fundamental unit of work is the task. Each
task is a script that can execute any sort of logic, and tasks specify other
tasks as dependencies that must run before them. Most major build systems in use
today, such as Ant, Maven, Gradle, Grunt and Rake are task based.

### The dark side of task-based build systems

They are extremely powerful, allowing you to do pretty much anything you can
imagine with them but that power comes with drawbacks, it can become difficult
to work with as their build scripts grow more complex. They give too much power
to engineers and not enough power to the system. Because the system has no idea
what the scripts are doing, performance suffers, as it must be very conservative
in how it schedules and executes build steps. There's no way for the system to
confirm that each script is doing what it should, so scripts tend to grow in
complexity and end up being another thing that needs debugging.

**Difficulty of parallelizing build steps.** Task-based systems are often unable
to parallelize task execution even when it seems like they should be able to.
Suppose that task A depends on task B and C. Because task B and C have no
dependency on each other, is it safe to run them at the same time so that the
system can more quickly get to task A? Maybe, if they don't touch any of the
same resources. But maybe not - perhaps both use the same file to track their
statuses and running them at the same time causes a conflict.

**Difficulty performing incremental builds**

**Difficulty maintaining and debugging scripts**

## Artifact-Based Build Systems

Bazel is an artifact-based build system. They have a small number of tasks
defined by the system that engineers can configure in a limited way. Engineers
still tell the system **what** to build, but the build system determines **how**
to build it.

Bazel still have buildfiles but rather than being an imperative set of commands
in a Turing-complete scripting language, buildfiles in Bazel are a declarative
manifest describing a set of artifacts to build, their dependencies, and a
limited set of options that affect how they're built. That way the build system
now has full control over what tools to run when, it can make much stronger
guarantees that allow it to be far more efficient while still guaranteeing
correctness.

## Resources

- [Build Systems and Build Philosophy](https://abseil.io/resources/swe-book/html/ch18.html)
