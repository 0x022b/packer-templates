[CmdletBinding()]
Param(
    [Parameter(Mandatory = $false)]
    [string]$PACKER = $env:PACKER,

    [Parameter(Mandatory = $false)]
    [string]$OSCDIMG = $env:OSCDIMG
)

if (!$OSCDIMG) {
    $OSCDIMG = ".\tools\oscdimg.exe"
}

& "$OSCDIMG" -u2 -lProvision ".\provision\windows\" `
    "$env:TMP\provision.iso"

Get-ChildItem -Filter '.\templates\windows-*.variables.json' `
| ForEach-Object {
    $os_name = $_.ToString().Replace(".variables.json", "")

    & "$OSCDIMG" -u2 -lUnattend ".\resources\$os_name\" `
        "$env:TMP\$os_name.unattend.iso"

    & "$PACKER" build -var-file ".\templates\$_" `
        ".\templates\windows.template.json"

    if (Test-Path "$env:TMP\$os_name.unattend.iso") {
        Remove-Item "$env:TMP\$os_name.unattend.iso"
    }
}

if (Test-Path "$env:TMP\provision.iso") {
    Remove-Item "$env:TMP\provision.iso"
}
