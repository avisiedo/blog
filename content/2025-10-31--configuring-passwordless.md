---
Title: Passwordless environment
Date: 2025-10-31 1:00
Modified: 2025-11-30 21:00
Category: security
Tags: silverblue, yubico, gdm, ssh, login, fido2, passkey
Slug: passwordless
Authors: Alejandro Visiedo
Summary: Quick steps to get passwordless working in Silverblue
Header_Cover:
---
# Passwordless environment

The below are the steps I have followed to get passwordless on
a Silverblue 43 distro with yubico. It is based in the steps found at the
references.

> I recommend to try in a VM before use in your primary system,
> and then extend to it.

## Requirements

- Install the required packages: `rpm-ostree install pam-u2f pamu2fcfg`
- Reboot to get the packages available: `systemctl reboot`
- Create directory where store the configuration for your account:
  `mkdir ~/.config/Yubico`
- Add the configuration line by: `pamu2fcfg --username=$USER > ~/.config/Yubico/u2f_keys`
- Shrink permissions: `chmod 0400 ~/.config/Yubico/u2f_keys`
- Copy u2f_keys to a the global location below by: `run0 cp -vf ~/.config/Yubico/u2f_keys /etc/u2f_mappings`

## Set up passwordless

```sh
$ run0 authselect enable-feature with-pam-u2f
```

## Set up 2FA

```sh
$ run0 authselect enable-feature with-pam-u2f-2fa
```

---

Notes about `pamu2fcfg`:

- For the yubikey I am using, I required to use the `--username=$USER` argument
  or I got `error: fido_dev_make_cred (63) FIDO_ERR_UV_INVALID`

## Setup Git signing

Generate the key pair as below:

```sh
ssh-keygen -t ed25519-sk \
    -O resident \
    -O application=ssh: \
    -O verify-required \
    -f ~/.ssh/id_ed25519_sk_rk
```

- `-O resident` indicate to generate a resident key.
- `-O application=ssh:fedora` set the application namespace associated to the
  handler key. By default it is `ssh:`, and we need to prefix it always with
  `ssh:` if we want to generate a different key for different purposes.
- `-O verify-required` indicates to verify (by PIN or biometrics) the user
  when the key is going to be used.

OR (if you are moving your keys to another machine)

```sh
# The below will extract the resident key to use the private key stored
# inside the crypto device (the private key never is disclosed from the
# device). The below will extract all the resident keys (if you had
# one tagged `ssh:` and another `ssh:fedora`, both redident keys would
# be extracted.
cd ~/.ssh
ssh-keygen -K
```

> NOTE: In macOS requires to install ssh from homebrew, because the openssh
> installed by the system does not have support for **secret keys** (physical
> security key) nor **resident key** (stored in the device internal memory).
>
> I moved the identities from one system to another without compromise them.

Configure Git for SSH Signing:

```sh
git config --global gpg.format ssh
git config --global user.signingkey "~/.ssh/id_ed25519_sk_rk.pub"
git config --global commit.gpgSign true
git config --global tag.forceSignAnnotated true
```

Configure SSH (the key to identify does not match the defaults that try SSH, so
we need to let it know to SSH by adding the content below to `.ssh/config`:

```raw
IdentityFile ~/.ssh/id_ed25519_sk_rk
```

> This was detected in macOS system when verifying the connection by
> `ssh -T git@github.com`

Create and configure the allowed signers file.

```sh
touch ~/.ssh/allowed_signers
EMAIL="$(git config --global user.email)"
PUB_KEY="$(cat ~/.ssh/id_ed25519_sk_rk_fedora.pub | awk '{ print $2 }')"
printf '%s namespaces="git" ssh-ed25519 %s Git signing key %s\n' "${EMAIL}" "${PUB_KEY}" "${EMAIL}" >> ~/.ssh/allowed_signers
unset PUB_KEY EMAIL
```

Tell git where to find the allowed signers:

```sh
git config --global gpg.ssh.allowedSignersFile "~/.ssh/allowed_signers"
```

---

> Don't forget to add your public key to yout github, gitlab or another
> SCM where you push your commits.

## Unlock LUKS using FIDO2

I tried in a VM several configurations, and the one that fit well
in terms of security and usability was the below one:

```sh
run0 systemd-cryptenroll \
  --fido2-device=auto \
  --fido2-with-client-pin=no \
  --fido2-with-user-presence=yes \
  --fido2-with-user-verification=yes \
  /dev/sdXY
```

If you want to only unlock the disk by using your FIDO2 device you can remove
the password slot with the following command:

> WARNING: Before run this command, check you can boot and unlock LUKS by
> using your FIDO2 device.

```sh
run0 systemd-cryptenroll \
    --wipe-slot=password \
    /dev/sdXY
```

> Update `/dev/sdXY by your LUKS partition; `lsblk` should help you.

Edit `/etc/crypttab` and add to your LUKS device entry: ` - fido2-device=auto`

Reboot your system: `systemctl reboot` and now you should be
able to unlock your LUKS partition using your FIDO2 device and
touching it.

## Lock screen on extracting token

- Note the product and vendor for your fido device: `ls usb`
- Create the file `/usr/local/bin/lockcomputer.sh`:

```sh
# Create /usr/local/bin/lockcomputer.sh
cat <<EOF | run0 tee /usr/local/bin/lockcomputer.sh
#!/bin/sh

# Inspired by: https://gist.github.com/jhass/070207e9d22b314d9992

lockscreen() {
  for bus in /run/user/*/bus; do
    uid=\$(basename \$(dirname \$bus))
    if [ \$uid -ge 1000 ]; then
      user=\$(id -un \$uid)
      export DBUS_SESSION_BUS_ADDRESS=unix:path=\$bus
      if su -c 'dbus-send --session --dest=org.freedesktop.DBus --type=method_call --print-reply  /org/freedesktop/DBus org.freedesktop.DBus.ListNames' \$user | grep org.gnome.ScreenSaver; then
        su -c 'dbus-send --session --type=method_call --dest=org.gnome.ScreenSaver /org/gnome/ScreenSaver org.gnome.ScreenSaver.Lock' \$user
      fi
    fi
  done
}

disconnect-network() {
  devices=\$(nmcli --fields DEVICE,TYPE,STATE device status | grep ethernet | grep connected | awk '{ print \$1 }')
  for device in \$devices; do
    nmcli device down "\$device"
  done
}

disconnect-network
lockscreen
EOF

# Change permissions
run0 chmod u+x /usr/local/bin/lockcomputer.sh

# Check your ID_MODEL_ID and ID_VENDOR_ID by: lsusb

# FIXME Add udev rule / be aware ID_MODEL_ID and ID_VENDOR_ID should match your device
cat <<EOF | run0 tee /etc/udev/rules.d/20-yubico.rule
ACTION=="remove", ENV{ID_BUS}=="usb", ENV{ID_MODEL_ID}=="0407", ENV{ID_VENDOR_ID}=="1050", RUN+="/usr/local/bin/lockcomputer.sh"
EOF
```

- Reload udev rules by: `run0 udevadm control -R`

## Wrap up

So far we set up our login, gdm, git commits and tags, LUKS and lockcomputer
on key extraction by using our passwordkey token. This is a step forward to
keep your environment safer.

Stay tuned and see you on the next post!

**UPDATE**: Added `Unlock LUKS using FIDO2` section.

## References

- [How to use yubikey with fedora linux](https://fedoramagazine.org/how-to-use-a-yubikey-with-fedora-linux/)
- [pam-u2f](https://developers.yubico.com/pam-u2f/)
- [Using Yubikeys](https://docs.fedoraproject.org/en-US/quick-docs/using-yubikeys/)
- [Set up Yubikey for Passwordless Sudo Authentication](https://dev.to/bashbunni/set-up-yubikey-for-passwordless-sudo-authentication-4h5o)
- [Authenticating with GDM and sudo with a U2F security key](https://www.reddit.com/r/Fedora/comments/akck9m/authenticating_with_gdm_and_sudo_with_a_u2f/)

