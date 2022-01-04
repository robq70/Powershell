Get-Help -verb ConvertTo
Get-Help -verb ConvertFrom
Get-Help -verb Export
Get-Help -verb Import
Get-Service | Select-Object -First 5 | ConvertTo-Csv
Get-Service | Select-Object -First 5 | ConvertTo-Csv | ConvertFrom-Csv | Sort Name -Descending | Select Name,Status
Get-Service | Select-Object -First 5 | ConvertTo-Csv | Out-File D:\script\services.csv
Get-Content D:\script\services.csv
Get-Content D:\script\services.csv | ConvertFrom-Csv
Get-Content D:\script\services.csv | ConvertFrom-Csv | Get-Member
Import-Csv D:\script\services.csv
Get-Service | Select-Object -Property Name -First 5 | ConvertTo-Csv | Out-File D:\script\services.csv
Get-Content D:\script\services.csv
Get-Service | Select-Object -First 5 | Export-Csv D:\script\services-expo.csv
Import-Csv D:\script\services-expo.csv
Get-Volume | Select-Object -Property DriveLetter,Size,SizeRemaining | Export-Csv D:\script\dyski.csv
Get-Volume | Select-Object -Property DriveLetter,Size,SizeRemaining | Export-Csv D:\script\dyski.csv -Append
Get-Volume | Select-Object -Property @{n='Data';e={Get-Date}},DriveLetter,Size,SizeRemaining | Export-Csv D:\script\dyski.csv -Append
Import-Csv D:\script\dyski.csv | select -Last 1
