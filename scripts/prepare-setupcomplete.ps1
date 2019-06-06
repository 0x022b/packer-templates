New-Item -Type Directory -Path "$env:SystemRoot\Setup\Scripts" -Force `
| Out-Null

Copy-Item "f:\setupcomplete.*" "$env:SystemRoot\Setup\Scripts"
