Get-ChildItem D:\script
Get-ChildItem D:\script | Get-Member
Get-ChildItem D:\script -Filter "*.csv" | ForEach Delete
Get-ChildItem D:\script
Get-ChildItem D:\script -Filter "*.txt" | ForEach {$_.CopyTo('D:\scriptnew\'+$_.Name)}
Get-Process | ForEach-Object -Begin {Get-Date | Out-File -FilePath 'D:\script\report.txt' -Append} -Process {$_ | Select-Object Name,VM | Out-File 'D:\script\report.txt' -Append}
Get-Process | Foreach -Begin {Get-Date | Out-File -FilePath 'D:\script\report.txt' -Append} -Process {$_ | Select-Object Name,VM | Out-File 'D:\script\report.txt' -Append}
Get-Process | Foreach -Begin {Get-Date | Out-File -FilePath 'D:\script\report.txt' -Append} -Process {$_ | Select-Object Name,VM | Out-File 'D:\script\report.txt' -Append}
ls D:\script | % {$_.Encrypt()} #szyfruje pliki we wskazanym katalogu, korzysta ze składni złożonej
ls D:\script | foreach {Get-Content $_.FullName} # W katalogu D:\Script znajdują się pliki tekstowe. Twoim zadaniem jest wyświetlić zawartość wszystkich tych plików tak, jakby był to jeden duży plik (Konkatenacja pliku).
Get-Service | Where { $_.status -eq "Running" } | ForEach -Begin { Write-Host "Serwisy uruchomione $(Get-Date)" } -Process {$_} <#Polecenie ma wyświetlić napis "Serwisy uruchomione <data dzisiejsza>", a następnie poniżej wszystkie usługi w stanie running.
ls D:\data | % Encrypt #szyfruje pliki we wskazanym katalogu, korzysta ze składni uproszczonej
Get-Volume | foreach -Begin {Get-Date | Out-File 'D:\data\vol.txt' -Append} -Process {$_ | Select-Object DriveLetter,FileSystem,Size | Out-File 'D:\data\vol.txt' -Append}
Get-Content D:\data\vol.txt
"wuauserv","bits" | Out-File D:\data\services.txt
Get-Content D:\data\services.txt | foreach -Process {Stop-Service $_}
Get-Content D:\data\services.txt | foreach -Process {Start-Service $_}
Get-Content D:\data\services.txt | foreach {Write-Host "Starting $_"; Start-Service $_} <#Instrukcja powodującą wyświetlenie napisu „Starting …”. W miejscu kropek pojawi się nazwa startowanej usługi#>
Get-Content D:\data\services.txt | ForEach -Begin { Write-Host "STARTING SERVICES"} -Process {Write-Host "Starting $_"; Start-Service $_ } -End {Write-Host "DONE"} # Na końcu pojawi się napis DONE