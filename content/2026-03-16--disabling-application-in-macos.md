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
applications which have been in focus because of
security flaws, such as FaceTime, Messages and Phone.
Personally I do not use any of them, and that makes me
think, why not reduce the attack surface by preventing them from
being executed?

## Searching information about .mobileconfig

It has been very tough to find information about
.mobileconfig examples to disable those applications.
Indeed I am surprised that AI could help me more than
trying to find specific information, because it used to
be the scenario where AI starts to hallucinate.

## What I found

I found an example in an AI prompt which was showing
the example below (it was extending even for Chess.app;
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

I tried a few examples before validating this one, and the result
seems to be good. The important part is `pathBlackList` and
`pathWhiteList`. On the first we specify the path to the applications
we want to avoid executing; the second is a whitelist for
well-known applications. I am against the second, because it
is too broad, and I prefer the system, so in my personal
`.mobileconfig` I have removed the `pathWhiteList` section.

> BE AWARE that sometimes after applying the .mobileconfig and
> accepting the file had to be installed, I did not get the
> message forbidding the launch of the applications.
> **After a reboot, the profile works as expected**.

## Wrap up!

We have seen an example of disabling macOS applications to reduce
the attack surface on them, by using deny lists and allow lists.

Hope this helps!
Cheers!

