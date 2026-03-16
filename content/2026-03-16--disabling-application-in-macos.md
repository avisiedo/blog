---
Title: Disabling application in macOS
Date: 2026-03-16 21:04
Modified: 2026-03-16 21:04
Category: macos
Tags: security,macos
Slug: disabling-application-in-macos
Authors: Alejandro Visiedo
Summary: Disabling applications to reduce surface attacks.
Header_Cover: static/cover-header.jpg
---
# Disabling application in macOS

In macOS systems I would like to totally disable some
applications which have been in the focus because of
security flaws, such as Facetime, Messages and Phone.

Personally I do not use any of them, and that make me
think, why not reduce the surface attack avoiding they
could be executed?

## Searching information about .mobileconfig

It has been very tought to find information about
.mobileconfig examples to disable that applications.
Indeed I am surprise the IA could help me more than
trying to find specific information, becuase use to
be the scenario where the IA start to alucinate.

## What I found

I found an example in a IA prompt which was showing
the example below (it was extending event for Chess.app;
which indeed is not used normally).

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;
<plist version="1.0">
<dict>
	<key>PayloadIdentifier</key>
	<string>com.company.mcx.blockapps</string>
	<key>PayloadRemovalDisallowed</key>
	<true/>
	<key>PayloadScope</key>
	<string>System</string>
	<key>PayloadType</key>
	<string>Configuration</string>
	<key>PayloadUUID</key>
	<string>9c24d6b3-6233-4a08-a48d-9068f4f76cf0</string>
	<key>PayloadOrganization</key>
	<string>Company Name</string>
	<key>PayloadVersion</key>
	<integer>1</integer>
	<key>PayloadDisplayName</key>
	<string>Application Restrictions</string>
	<key>PayloadContent</key>
	<array>
		<dict>
			<key>PayloadType</key>
			<string>com.apple.applicationaccess.new</string>
			<key>PayloadVersion</key>
			<integer>1</integer>
			<key>PayloadIdentifier</key>
			<string>MCXToProfile.9c24d6b3-6233-4a08-a48d-9068f4f76cf0.alacarte.customsettings.2476221c-1870-4f3e-8c52-52386029c4cf</string>
			<key>PayloadEnabled</key>
			<true/>
			<key>PayloadUUID</key>
			<string>2476221c-1870-4f3e-8c52-52386029c4cf</string>
			<key>PayloadDisplayName</key>
			<string>Block Specified Applications From Launching</string>
			<key>familyControlsEnabled</key>
			<true/>
			<key>pathBlackList</key>
			<array>
				<string>/Applications/FaceTime.app/</string>
				<string>/Applications/Phone.app/</string>
				<string>/Applications/Messages.app/</string>
			</array>
			<key>pathWhiteList</key>
			<array>
				<string>/</string>
			</array>
			<key>whiteList</key>
			<array>
			</array>
		</dict>
	</array>
</dict>
</plist>
```

I tried a few examples before validate this one, and the result
seems to be good. The important part is `pathBlackList` and
`pathWhiteList`. On the first we specify the path to the applications
we want to avoid to execute; the second is a WhiteList for
well known applications. Im am against the second, because it
is too broadly, and I prefer the system, so in the personal
`.mobileconfig` I have removed the section `pathWhiteList`.

> BE AWARE that sometimes after apply the .mobileconfig and
> accept the file had to be installed, I did not get the
> message forbiding the leverage of the applications.
> **After reboot, the profile work as expected**.

## Wrap up!

We have seen an example of disabling macOS application to reduce
the surface attack on them, by using deny list and allowed lists.

Hope this helps!
Cheers!

