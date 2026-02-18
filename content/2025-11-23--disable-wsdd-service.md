---
Title: Disable wsdd service
Date: 2025-11-23 13:11
Modified: 2025-11-23 13:11
Category: Linux
Tags: linux,services,administration
Slug: disable-wsdd-service
Authors: Alejandro Visiedo
Summary: Disable Web Search Discovery host Daemon.
Header_Cover:
---
# Disable wsdd service

The Web Search Discovery host Daemon allow to discover hosts in a windows
network. It uses ports 3702/udp and 5357/tcp. But this service reveals
information that we could want to void, because it makes easier the discovery
and recognition in a network.

This service is not managed by systemd, but exists a way to disable it, by
using `gsettings` command.

So to disable the service run:

```sh
gsettings set org.gnome.system.wsdd display-mode 'disabled'
```

You could need to reboot, but after that, you should not see the service
listening on port 3702/udp and 5357/tcp.

See you on the next post!

## References

https://github.com/christgau/wsdd
https://gitlab.gnome.org/GNOME/gvfs/-/issues/753

