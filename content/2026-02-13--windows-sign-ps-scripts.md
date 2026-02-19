---
Title: Run windows powershell scripts
Date: 2026-02-13 10:00
Modified: 2026-02-13 10:00
Category: Windows
Tags: windows, powershell, profile
Slug: run-windows-powershell-scripts
Authors: Alejandro Visiedo
Summary: Hot to get your $PROFILE signed and running
Header_Cover: static/header-cover.jpg
Status: published
---
# Run windows powershell scripts

I have not used windows from a while, and several things that I use to do in
Linux systems, are different in Windows. One of this things are customize my
Windows terminal session by using an init script ($PROFILE) so I can define
useful aliases (or functions in this case). But when I tried to use $PROFILE
I realized that to allow it I had to degrade the `ExecutionPolicy` to be
extremaly permissive, and setting the `Scope` to the `Process`, everytime I
open a terminal, is tedious. So I have tried to sign my script so the
`ExecutionPolicy` can be set to `AllSigned` and do not loose too much on the
security levels. The steps could breakdown as below:

- Define the initial content for the `$PROFILE` file.
- Create a self-signed certificate.
- Sign the `$PROFILE` file.
- Verify we can run `$PROFILE` with no issues, and the function `dotfiles` is
  available.

## Define the initial content

The initial $PROFILE content is only the below content (once it works we can
add whatever we could need).

```powershell
function dotfiles {
  git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" @args
}
```

## Create a self-signed certificate

We have to create a self-signed certificate, store it in our local
certificate storage (no system, so no privileges are needed).

```powershell
$certName = "Alejandro Visiedo"
$dnsName = "PowerShellLocal"
$cert = New-SelfSignedCertificate -Type CodeSigningCert `
                                  -Subject "CN=$certName" `
                                  -DnsName $dnsName `
                                  -CertStoreLocation "Cert:\CurrentUser\My" `
                                  -NotAfter (Get-Date).AddYears(5) `
                                  -KeyExportPolicy NonExportable
```

- `-Type CodeSigningCert`: We indicate we want a certificate to sign code as
  we want to sign our scripts.
- `-Subject "CN=$certName"`: We inform the value for the Subject of the
  certificate. As it is a self-signed, this value will be used to for the
  `-Issuer`.
- `-DnsName $dnsName`: This value is not importante, just using a common
  value that is broadly used. It is important on the scope of TLS
  certificates.
- `-CertStoreLocation "Cert:\CurrentUser\My"`: Indicate the store where the
  certificates and key pair will be stored. As we are using the user store,
  we don't need elevate privileges.
- `-NotAfter (Get-Date).AddYears(5)`: The certificate will outdate in five
  years.
- `-KeyExportPolicy NonExportable`: This argument indicate that the key stored
  are not exportable.


> We can check the certificate by running `certmgr.msc`

And now configure the trust on the new certificate by:

```powershell
$stores = "Root", "TrustedPublisher"
foreach ($storeName in $stores) {
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, "CurrentUser")
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()
    Write-Host "Added to: $storeName"
}
```

## Sign the `$PROFILE` file

```powershell
if (!(Test-Path $PROFILE)) { 
    New-Item -Path $PROFILE -Type File -Force 
    Add-Content $PROFILE "# File $PROFILE signed"
}

$status = Set-AuthenticodeSignature -FilePath $PROFILE -Certificate $cert
$status.Status
```

## Verify

```powershell
Get-AuthenticodeSignature $PROFILE | Select-Object Path, Status, Hash
```

## Final script

Before to enable $PROFILE you have to run:

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy AllSigned
```

As we can see, we shrink the scope to the current user only, and the execution
policy will be applied to all signed scripts.

Any script from other user that we don't trust or not signed scripts
will be rejected its execution.

Finally all the above together could be joined in the script below:

```powershell
# 1. Configure names
$certName = "Alejandro Visiedo"
$dnsName = "PowerShellLocal"

Write-Host "--- Generating Certificate ---" -ForegroundColor Yellow
$cert = New-SelfSignedCertificate -Type CodeSigningCert `
                                  -Subject "CN=$certName" `
                                  -DnsName $dnsName `
                                  -CertStoreLocation "Cert:\CurrentUser\My" `
                                  -NotAfter (Get-Date).AddYears(5) `
                                  -KeyExportPolicy NonExportable

Write-Host "Certificate create with Thumbprint: $($cert.Thumbprint)"

# 2. Trust on the certificate (Move to root and trusted editors)
Write-Host "--- Configuring trust ---" -ForegroundColor Yellow
$stores = "Root", "TrustedPublisher"
foreach ($storeName in $stores) {
    $store = New-Object System.Security.Cryptography.X509Certificates.X509Store($storeName, "CurrentUser")
    $store.Open("ReadWrite")
    $store.Add($cert)
    $store.Close()
    Write-Host "Added to: $storeName"
}

# 3. Sign $PROFILE
Write-Host "--- Signing $PROFILE ---" -ForegroundColor Yellow
if (!(Test-Path $PROFILE)) { 
    New-Item -Path $PROFILE -Type File -Force 
    Add-Content $PROFILE "# File $PROFILE signed"
}

$status = Set-AuthenticodeSignature -FilePath $PROFILE -Certificate $cert
$status.Status

Write-Host "--- Verification ---" -ForegroundColor Yellow
Get-AuthenticodeSignature $PROFILE | Select-Object Path, Status, Hash
```

## Signing another script

```powershell
# the long hash is the fingerprint for the certificate
$cert = Get-Item -Path "Cert:\CurrentUser\My\ea9a1d609c091bb023c1ccd54261e4982d747047"
$status = Set-AuthenticodeSignature -FilePath "myscript.ps1" -Certificate $cert
$status.Status
```

## Wrap up!

We have seen how to prepare our environment to run powershell scripts without
relaxing the execution policy, and how to add a customization for our
environment by defining the `dotfiles` function. Now we can extend this for
additional helper scripts we could want to create in our environment.

What's the next? IMHO use a hardware key increase the security, so instead of
having a certificate in the system certificate storage, I'd rather to have
the private key stored in a cryptographic device (one ring to govern all the
realms).

Another question is, how to rotate the certificate? What happen after 5 years?

But that will be another story.

See you on the next article!
