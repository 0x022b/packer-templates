Get-NetFirewallRule `
| Where-Object { $_.Name.StartsWith("WINRM") } `
| ForEach-Object { Set-NetFirewallRule -Name $_.Name -Action Block }

& "$env:SystemRoot\system32\sysprep\sysprep.exe" /generalize /oobe `
    /unattend:e:\sysprep.xml /mode:vm /quiet /shutdown
