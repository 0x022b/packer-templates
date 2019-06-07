[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false)]
    [string]$packer = $env:PACKER,

    [Parameter(Mandatory = $false)]
    [string]$oscdimg = $env:OSCDIMG
)

if (!$oscdimg) {
    $oscdimg = ".\tools\oscdimg.exe"
}

& "$oscdimg" -u2 -lProvision ".\provision\windows\" `
    "$env:TMP\provision.iso"

Get-ChildItem -Filter '.\templates\windows-*.variables.json' `
| ForEach-Object {
    $os_name = $_.ToString().Replace(".variables.json", "")

    & "$oscdimg" -u2 -lUnattend ".\resources\$os_name\" `
        "$env:TMP\$os_name.unattend.iso"

    & "$packer" build -var-file ".\templates\$_" `
        ".\templates\windows.template.json"

    if (Test-Path "$env:TMP\$os_name.unattend.iso") {
        Remove-Item "$env:TMP\$os_name.unattend.iso"
    }
}

if (Test-Path "$env:TMP\provision.iso") {
    Remove-Item "$env:TMP\provision.iso"
}
