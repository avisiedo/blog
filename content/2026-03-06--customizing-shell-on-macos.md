---
Title: Customizing shell on macOS
Date: 2026-03-06 08:17
Modified: 2026-03-06 08:17
Category: macos
Tags: shell, starship, nerd fonts
Slug: customizing-shell-on-macos
Authors: Alejandro Visiedo
Summary: A macOS shell customization for developers
Header_Cover: images/hover-customizing-shell-on-macos.png
---
# Customizing shell on macOS

I use to develop on Linux systems, but I do from a VM, and I was wondering how
to customize in similar way for zsh in macOS. If you want to set up a shell
environment similar to Linux using powerline, this article might be of interest to you.

The contents are the below:

- Installing "0xProto nerd fonts mono".
- Custom prompt by using starship.

> **Pre-requisites**: brew is installed in your system

## Installing "0xProto nerd fonts mono"

This font or another font for developing is necessary to print out properly the
prompt. Below are the steps to install the font in the system.

```sh
# Download font
curl -L -O "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/0xProto.zip"

# unpack the fonts at 0xProto/ directory
unzip 0xProto.zip -d 0xProto

# Install the fonts in the system
cp -vf 0xProto/*.ttf ~/Library/Fonts

# Reboot if you don't see the new fonts
```

Additionally I added the font to my VSCode IDE, so the embedded terminal
experience is the same as my system terminal.

1. Open the VSCode settings.
2. Select User tab.
3. Search for 'Text Editor > Font : Font Family'
4. Add at the beginning: "0xProto Nerd Font Mono"

## Custom prompt by using starship

- Install starship by: `brew install starship`

- Configure your starship by:
  `starship preset gruvbox-rainbow -o ~/.config/starship.toml`

- Now we want to make effective the prompt configuration so we add the below
  to our .zshrc file or similar. In my case I have `.profile.d/starship.zsh`
  that is included from the `.zshrc` file:

    ```sh
    if command -v starship &>/dev/null; then
      if tty -s &>/dev/null; then
        source <(starship init zsh)
      fi
    fi
    ```

- Finally, close your terminal, and re-open again, and you will see your prompt
  shell customized.

## Wrap up!

To have a prompt that display useful information for the developer is important
to avoid human mistakes, and already is cool to have a prompt shell that display
such information.

Hope this help!

See you on the next article!

