# 🪁 Kite Example Registry

**Because someone had to start forking first.**

> [!NOTE]
> This is the _official_ example registry for [Kite](https://github.com/Moq77111113/kite).
> Aka: a bunch of scripts pretending to be a product.

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Kite](https://img.shields.io/badge/works%20with-Kite-blueviolet.svg)](https://github.com/Moq77111113/kite)

---

## What is this?

A **public registry** of example _kits_ for [Kite](https://github.com/Moq77111113/kite) —
so you can test the tool without stealing Steve’s private repo.

It’s not a marketplace. It’s not an API.
It's literally a Git repo full of folders", the infrastructure knowledge generated over years of copy-pasting.

## Why this matters

Every developer spends hours searching for, copy-pasting, and debugging infrastructure code. Kite registries turn tribal knowledge into reusable, production-ready kits. If every developer saves just 2 hours a week, that’s over **100 hours/year** per person—time you can spend building, not yak-shaving.

Multiply that by your team size. That’s why this matters.

## Try it

If you already have Kite installed:

```bash
kite init --registry https://github.com/Moq77111113/kite-example-registry.git
kite serve
```

Or just grab something:

```bash
kite add docker-postgres hello-world-script
```

Boom — real files appear in your project. No magic. No lock-in. Just code.

---

## What’s inside?

A few **starter kits** to show how registries are structured:

```
kite-example-registry/
├── docker-postgres/
│   ├── kite.yaml
│   └── docker-compose.yml
├── hello-world-script/
│   ├── kite.yaml
│   └── hello.sh
└── steve-s-notes/
    ├── kite.yaml
    └── my-secret-notes.txt
    └── email-to-sarah.eml

```

Each folder = one **kit**.
Each kit = some files + one mandatory `kite.yaml`.

---

## Example: `docker-postgres`

```yaml
name: docker-postgres
version: 1.0.0
description: PostgreSQL with Docker Compose (because someone had to write it again)
tags: [docker, database, postgres]
```

You get a real, working `docker-compose.yml` you can actually edit, break, and ship.
Kite won’t stop you — that’s the point.

---

## Rules (sort of)

1. **No dependencies.** Just files.
2. **No build step.** Because nobody reads Makefiles anyway.
3. **No opinions (except this one).**
4. **No shame in copying.** Copying _is_ collaboration.

---

## How to use it with Kite

```bash
# Point Kite to this registry
kite init --registry https://github.com/Moq77111113/kite-registry.git

# Browse in the web UI
kite serve

# Or just list what's available
kite list

# Then fork something useful
kite add steve-s-notes
```

You’ll find your new files under the current directory.
They’re yours. Destroy them responsibly.

---

## Why this repo exists

Because every demo needs fake content.
And because you shouldn’t have to create your own registry just to test Kite.

Think of this repo as:

- **a sandbox** (safe to break),
- **a template** (safe to fork),
- and **a meme** (safe to ignore).

---

## Want to add your own kits?

PRs welcome.

If you think your setup deserves to live here, add a folder with:

- A `kite.yaml` (metadata)
- Whatever files make your kit useful
- A README if you feel guilty

Then run:

```bash
git add .
git commit -m "add(my-awesome-kit): because someone will need this again"
```

---

## License

MIT — copy it, fork it, or print it out and frame it.

---

## Credits

- **Kite** — for admitting that copy-paste is how infrastructure _actually_ spreads.
- **You** — for reading this far.
- **Steve** — for the original `docker-compose` that started it all.

---

> _It’s not a registry. It’s organized chaos pretending to be documentation._

```bash
kite init --registry https://github.com/Moq77111113/kite-registry.git
```
