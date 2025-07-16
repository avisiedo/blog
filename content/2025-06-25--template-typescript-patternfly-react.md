---
Title: Template for Typescript, Patternfly and React frontend projects
Date: 2025-06-25 19:36
Modified: 2025-06-25 19:36
Category: Web Developing
Tags: web,typescript,patternfly,react,javascript,template,developing
Slug: template-typescript-patternfly-react
Authors: Alejandro Visiedo <alejandro.visiedo@gmail.com>
Summary: A new template to scafolding web frontend applications.
Status: draft
Header_Cover: 
---
# Template for Typescript, Patternfly and React frontend projects

## General intro

In the past I had a set of repositories as knowledge base based on the learnings
of the courses I had been doing. This help me to get started new ideas and play
around with some technology.

I try (but not always I achieve) to keep best practices that I know, and I have
observed that sometimes some repeatable steps, actions, automations happens.

To provide a solution to this, I started to create git repository templates that
help on the above. The idea is to let quickly start some idea, or play around
with some technology without distract with that repeatable tasks, and to provide
a ready to use repository with the best practices.

## typescript + react + patternfly template

In this case, I am creating a template to quick start with SPA applications
using:

- **typescript**: to help on remove many javascripts situations.
- **patternfly**: a solid multi-device web library ready to use, and well
  maintained.
- **react**: a frontend library easy to get started.
- **test**: jest framework is used for unit tests. playwright is used for the
  end2end tests.

It provides automation based on github actions for:

- Check missed operations that generate code in the repository.
- Check commit messages to be aligned with conventional commits.
- Check that unit tests pass.

Allow to run many automations based on make rules, so the pipeline and the
developer in their local machine run as similar as possible.

- **format**: Keep format consistent (checked in the pipeline).
- **lint**: Arise code smell and potential bugs before we arrive to the repository
  (checked in the pipeline).
- **doc**: generate documentation from src/ and docs/ directory.
- **test**: run all the tests that can be made in the local workstation.
- **test-unit**: run unit tests.
- **test-e2e**: run e2e tests based on playwright.
- **test-cov**: print coverage report. This is important to keep high level of
  coverage, and which components need more attention for this.
- **generate-client**: generate REST API client components from the openapi
  specification. This save a huge initial work.
- **container** operations (build, push, clean). Help on get container bits.
- **compose** operations (up, down, build, pull, logs, clean). Help con get
  infrastructure running locally.

It provides guidelines at `docs/` directory so you do not have to keep your
knowledge in your head, and can dedicate time for the real important things,
bring your ideas to real world, and play with them.

## Structure

To let start from specific things and grow to provide general components, the
repo is structured in a way where the initial granular unit are pages and the
components within, but as we discover they can be reused, we promote components
to the shared location, to reuse on the different pages.

## 

