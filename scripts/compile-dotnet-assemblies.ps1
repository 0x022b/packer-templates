while ($true) {
    $obj = Get-ScheduledTask -TaskPath "\Microsoft\Windows\.NET Framework\" `
    | Where-Object { $_.State -eq 'Running' } `
    | Measure-Object
    if ($obj.Count -eq 0) {
        break
    }
    Start-Sleep 10
}
