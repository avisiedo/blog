# AI Agents Guide

This repository is intended for generating a statis site by using Markdown
documents that will be rendered in html code by using pelican static site
generator.

## Commands

- **Install on Linux**: `python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt`
- **Install on Windows from git bash**: `python -m venv .venv && source .venv/Scripts/activate && pip install -r requirements.txt`
- **Install on macOS**: `python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt`

- **Serve contents**: `make devserver`

- **Linter**: `make lint`

## Code examples

### Naming articles

```raw
contents/2026-02-18--my-title.md
contents/2026-02-17--another-title.md
contents/2026-02-16--awesome-title.md
```

### hover in the article for a dract document

```raw
---
Title: Static site by using pelican
Date: 2025-03-28 15:39
Modified: 2025-03-28 15:39
Category: linux
Tags: blog, web
Slug: static-site-by-using-pelican
Authors: Alejandro Visiedo
Summary: Creating my blog by using pelican.
Header_Cover: static/header-cover.jpg
Status: draft
---
```

### hover in the article for a published docuemt

```raw
---
Title: Static site by using pelican
Date: 2025-03-28 15:39
Modified: 2025-03-28 15:39
Category: linux
Tags: blog, web
Slug: static-site-by-using-pelican
Authors: Alejandro Visiedo
Summary: Creating my blog by using pelican.
Header_Cover: static/header-cover.jpg
Status: published
---
```

## Structure for each article

```markdown
# Article title

Here we write some summary about the article and layout of the structure.

- Section 1
- Section 2
- Section 3
- Wrap up!


## Section 1

The content for the Section 1

## Section 2

The content for the Section 2

## Section 3

The content for the Section 3

## Wrap up!

Conclusions about this article, and what is the next (if any).

```

## 🏗 Project Architecture & Conventions

- **Folder Structure:**
  - `/contents`: The articles that feed the blog which are written in markdown.
  - `/templates`: git submodules for the themes used for the static site.
  - `/plugins`: List of plugins available.
  - `/pelicanconf.py`: Configuration for pelican static site generator.
  - `/output`: The directory where the resulting built is stored.

## Limits and scope

- Never commit secrets.
- Update only the folder contents/

## 🛡 Rules & Constraints (Critical)

1. **Security:** Never request nor write secrets, API keys or credentials in the code. Use `.env.example`.
2. **Dependencies:** Do not install new template without ask for it.

## Techincal Stack

- Python for running the static site generator, pelican.
- Markdown
- Any programming language embedded in the markdown documents, but mainly:
  - bash shell
  - python
  - golang
  - c
  - modern c++
  - swift
  - rust

## Project Structure

- `content/` - Blog article files (markdown)
- `templates/` - Jinja2 templates for site rendering
- `scripts/` - Helper scripts (e.g., new-article.sh)
- `static/` - Static assets
- `pelicanconf.py` - Development configuration
- `publishconf.py` - Production configuration
- `Makefile` - Build automation
- `tasks.py` - Invoke tasks for automation
- `custom.mk` - Custom make rules

## Code style and conventions

- The shell scripts will follow the code style at: https://google.github.io/styleguide/shellguide.html
- The example code embedded in python will use pep 8, that can be found
  at: https://peps.python.org/pep-0008
- The example code for golang will use the recomendations at:
  https://go.dev/doc/effective_go

## Git workflow

- Given the default 'main' branch:
  - A branch is created for the changes.
  - Atomic commits with a single purpose are committed.
- The changes are merge by creating a pull request (even in the same repository).
- Once the change is reviewed, the PR is merged.

## Git messages

- The git messages will use conventional commits at: https://www.conventionalcommits.org/en/v1.0.0
- Example for a new article:
  ```raw
  docs: my article title
  
  Summary about the article.

  Signed-Off: Username <email@exmaple.com>
  ```

