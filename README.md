Rix
===

*for lack of a better name, at the moment.*

Rix is a formulary using [Repeatr](https://github.com/polydawn/repeatr) and [Reppl](https://github.com/polydawn/reppl)
to build an auditable, immutable, and reproducible linux "distro" out of reusable components.

Goals
-----

Like any other distro, the first goal is of course to be usable.
But we have a couple of aims that are distinct and unusual:

- All build steps should be reproducible.
  - We're going to tolerate some magic artifacts in the beginning, but hope to have snake-eating-its-tail as soon as possible.
- All binary products should be relocatable.  None of this `/fixed/path` nonsense.

Non-goals (for now):

- Base system installs.  We're not chasing bootloaders, drivers, or anything else.  Yet.
- Configuration management.  Rix is a series of factory scripts, not an opinionated user environment.

Status
------

Oh-so-early PoC.
