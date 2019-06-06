Get-ScheduledTask -TaskPath "\Microsoft\Windows\.NET Framework\" `
| Where-Object { $_.State -eq 'Ready' -and !$_.Triggers } `
| Start-ScheduledTask

while ($true) {
    Start-Sleep 10

    $obj = Get-ScheduledTask -TaskPath "\Microsoft\Windows\.NET Framework\" `
    | Where-Object { $_.State -eq 'Running' } `
    | Measure-Object

    if ($obj.Count -eq 0) {
        break
    }
}
