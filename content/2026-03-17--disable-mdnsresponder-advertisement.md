---
Title: Disabling advertisements on mDNSResponder
Date: 2026-03-17 21:00:00 +0100
Modified: 2026-03-17 21:00:00 +0100
Category: macos
Tags: macos, system, dns, mdns
Slug: disabling-advertisements-on-mdnsresponder
Authors: Alejandro Visiedo
Summary: Reducing anounces about the system into mDNSResponder
Header_Cover: static/header-cover.jpg
Status: published
---

What is mDNSResponder in macOS systems? what is the target of this application?
My understanding so far is it serve several porpose related with DNS, but not
only that.

- It resolve DNS names to ip.
- It cache DNS requests to accelerate the connected applications.
- It listen for mDNS (bonjour: listen who is there).
- It emit advertisements about the houst (bonjour: tells I am here).

Ok, from the point of view of security, I am worried about the advertisements
when my laptop is not a service for other hosts, so my question once that
I know I don't need is, how could I disable that functionality? "It depends"

I have been reading several articles and the way how to afford this task
could vary depending on your system, but let's focus on using .mobileconf
profiles. This allow to apply them in a modular way and is the new way
to appli restrictions on our system.

Let's see how looks that disable-mdsnresponder-anouncements.mobileconfig

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

A quick look tell us what is the description we are interesting
on. That is `<key>NoMulticastAdvertisements<key><true/>

Now if you open wireshark, you will see that no network traffic
with bonjour anouncments are leaving your hosts, and keeping your
host a bit more anonymous.

But wait, how could I apply this file from the command line?
`sudo profiles -I -F /path/to/yout/disable-mdsnresponder-anouncements.mobileconfig`

## Wrap up!

We have seen how to disable dns announces for our host, which
will leak less information about what services are available in
our machine, and helping to get the things harder for the
reconicement stage.

Hope this help and, See you on the next on!

