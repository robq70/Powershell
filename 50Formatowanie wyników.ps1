Get-EventLog Security -Newest 10

Get-Service
Get-Service | Format-Wide
Get-Service | FW
Get-Service | Format-Wide -Property ServiceName
Get-Service | Format-Wide -Property DisplayName
Get-Service | Format-Wide -Col 5
Get-Service | Format-Wide -AutoSize

Get-Service | Format-List
Get-Service | FL
Get-Service | Format-List -Property *
Get-Service | Format-List -Property Name,Status
Get-Service | Format-List Name,Status

Get-Service | Format-Table
Get-Service | FT
Get-Service | Format-Table -Property *
Get-Service | Format-Table Name,Status,DisplayName
Get-Service | Format-Table Name,Status,DisplayName,ServiceType
Get-Service | Format-Table Name,Status,DisplayName,ServiceType -AutoSize
Get-Service | Format-Table Name,Status,DisplayName,ServiceType -AutoSize -Wrap

ls D:\script | FT Name, @{n='Size in KB';e={$_.Length/1KB}}
ls D:\script | FT Name, @{n='Size in KB';e={$_.Length/1KB};formatstring="N2"}
ls D:\script | FT Name, @{n='Size in KB';e={$_.Length/1KB};formatstring="N2"} -AutoSize

Get-Service | FT
Get-Service | Sort Status | FT
Get-Service | FT | Sort Status <# wodwrotnej kolejnosci sie nie da#>
Get-Service | Sort Status | FT | Get-Member
Get-Service | Sort Status | select Status,Name,DisplayName
Get-Service | Sort Status | select Status,Name,DisplayName | Get-Member

Get-Service | Sort-Object Status | FT
Get-Service | FT -GroupBy Status
Get-Service | Sort Status | FT -GroupBy Status

Get-Service | Group-Object Status <#pokazuje ile grup jest uruchomionych lub zatrzymanych#>

Get-Service | Select Status,Name,DisplayName | ConvertTo-Html | Out-File D:\script\service.html
Invoke-Item D:\script\service.html <#wyświetla plik#>
Get-Service | Out-Host <#wyświetla plik tak jak samym poleceniem Get-service#>
Get-Service | Out-GridView <#wyświetla plik w przeglądarce powershell można je sortować, filtrować itp#>
Get-Service | Out-Printer
Get-ChildItem D:\script -Recurse | Group-Object PSIsContainer <#pokazuje ile w D:\script jest plików a ile katalogów#>
Get-Process | FL -Property *