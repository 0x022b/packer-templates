Get-NetFirewallRule `
| Where-Object { $_.Name.StartsWith("WINRM") } `
| ForEach-Object { Set-NetFirewallRule -Name $_.Name -Action Allow }
