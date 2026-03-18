---
Title: Disabling advertisements on mDNSResponder
Date: 2026-03-17 21:00:00 +0100
Modified: 2026-03-17 21:00:00 +0100
Category: macos
Tags: macos, system, dns, mdns
Slug: disabling-advertisements-on-mdnsresponder
Authors: Alejandro Visiedo
Summary: Reducing announcements about the system from mDNSResponder
Header_Cover: static/header-cover.jpg
Status: draft
---

What is mDNSResponder in macOS systems? What is the purpose of this application?
My understanding so far is that it serves several purposes related to DNS, but not
only that.

- It resolves DNS names to IP.
- It caches DNS requests to accelerate the connected applications.
- It listens for mDNS (bonjour: listen who is there).
- It emits advertisements about the host (bonjour: tells I am here).

Ok, from the point of view of security, I am worried about the advertisements
when my laptop is not a service for other hosts, so my question once that
I know I don't need is, how could I disable that functionality? "It depends"

I have been reading several articles and the way to approach this task
could vary depending on your system, but let's focus on using .mobileconfig
profiles. This allows them to be applied in a modular way and is the new way
to apply restrictions on our system.

Let's see what the `disable-mdnsresponder-announcements.mobileconfig` looks like.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com">
<plist version="1.0">
<dict>
    <key>PayloadContent</key>
    <array>
        <dict>
            <key>PayloadEnabled</key>
            <true/>
            <key>PayloadIdentifier</key>
            <string>com.example.mdns.disablemulticast</string>
            <key>PayloadType</key>
            <string>com.apple.mDNSResponder</string>
            <key>PayloadUUID</key>
            <string>A1B2C3D4-E5F6-4A5B-8C9D-E0F1A2B3C4D5</string>
            <key>PayloadVersion</key>
            <integer>1</integer>
            <key>NoMulticastAdvertisements</key>
            <true/>
        </dict>
    </array>
    <key>PayloadDisplayName</key>
    <string>Disable mDNS Multicast Advertisements</string>
    <key>PayloadIdentifier</key>
    <string>com.example.mdns.profile</string>
    <key>PayloadType</key>
    <string>Configuration</string>
    <key>PayloadUUID</key>
    <string>A1B2C3D4-E5F6-4A5B-8C9D-E0F1A2B3C4D6</string>
    <key>PayloadVersion</key>
    <integer>1</integer>
</dict>
</plist>
```

A quick look tells us the key we are interested
in. That is `<key>NoMulticastAdvertisements</key><true/>`.

Now if you open wireshark, you will see that no network traffic
with Bonjour announcements are leaving your host, and keeping your
host a bit more anonymous.

But wait, how could I apply this file from the command line?
`sudo profiles -i -F /path/to/yout/disable-mdsnresponder-anouncements.mobileconfig`

## Wrap up!

We have seen how to disable DNS announcements for our host, which
will leak less information about what services are available in
our machine, and helping to make things harder for the
reconnaissance stage.

Hope this helps, and see you on the next one!

