---
Title: Preparing ios Development Environment
Date: 2026-02-25 11:07
Modified: 2026-02-25 11:07
Category: apple
Tags: macos, ios, developer
Slug: preparing-ios-development-environment
Authors: Alejandro Visiedo
Summary: Steps I have followed to get a productive development environment for coding iOS applications.
Header_Cover:
---
# Preparing ios Development Environment

In a far far age, I had a lot of interest on learning and developing iOS
applications. At that moment I tried even the VIPER pattern to build that
applications and provide testing and automation based on the current existing
tools.

Today, I decided to gather all that knowledge, and create a template repository
that I could use at any moment for a quick iOS developing. Keep quality
standards take time, and my intention with the template is to accelerate the
development on iOS keeping quality standards.

- [x] Installing required tools.
- [ ] Defining directory structure.
- [ ] Add automation.
  - [ ] local
  - [ ] github workflow
- [ ] Add developer documentation.

## Installing required tools

```sh
xcode-select --install
brew install swiftlint
brew install fastlane
```

- xcode cli commands: `xcode-select --install`
- xcode installed: 
- download sdk.
- automation tools (3rd party)

## Defining directory structure.

```sh
mkdir sample1
cd sample1
git init .
swift package init --type executable --enable-xctest --enable-swift-testing --name sample1

```
- Project layout aligned to VIPER architecture.
- Login Window supporting passkey.

## Add automation

### Local

- Run linters.
- Run unit tests.
- Run integration tests.
- Build.
- Delivery.
- Deploy to local simulator.
- Run acceptance tests.

### Github

- Define workflow re-using local.

## Add developer documentation

- How to add unit tests.
- How to add integration tests.
- How to add acceptance tests.
- How to add a new component.
  - How to add a new view.
  - How to add a new interactor.
  - How to add a new presenter.
  - How to add a new entity.
  - How to modify the router.

## Wrap Up!

So far, we have learned how to prepare the environment for a day to day iOS
modern application development, a set of tools and automation to make life
easier and how to structure the repository aligned with VIPER architecture.

Next will be code some small app to get use!

Happy coding and see you on the next article :)


