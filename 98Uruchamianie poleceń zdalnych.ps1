<#
Wprowadzenie do remotingu
Uruchamianie komend zdalnych
Sesje interaktywne Enter-PSSession
Polecenie wykonania zdalnego komendy Invoke-Command
Co to jest serializacja i deserializacja
Wykorzystywany jest protokół WS-MAN
#>

Get-Command -Noun PSRemoting
Enable-PSRemoting -WhatIf <# Aby zarządzć komputer zdalny musi mieć włączony dostęp zdalny poprzez Enable-PSRemoting #>
Enable-PSRemoting -SkipNetworkProfileCheck <#Opcja ta spowoduje skonfigurowanie remotingu nawet jeśli komputer pracowałby na profilu publicznym sieci#>

Enter-PSSession -ComputerName Domowy <#Praca na zasadzie telnetu interaktywna z komputerem zdalnym#>
Exit-PSSession <#Zakończenie sesji zdalnej#>
Get-WmiObject -Class Win32_OperatingSystem | FL *

Enter-PSSession -ComputerName Wiki

Invoke-Command -ComputerName Domowy -ScriptBlock { Get-WmiObject -Class Win32_OperatingSystem } <#Wysyłanie poleceń do komputera zdalnego po -ScriptBlock w nawiasie {} wpisujemy polecenie które chcemy przesłać #>
Invoke-Command -ComputerName Domowy -ScriptBlock { Get-WmiObject -Class Win32_OperatingSystem } | Get-Member
Get-WmiObject -Class Win32_OperatingSystem | Get-Member

Invoke-Command -ComputerName Domowy -ScriptBlock { Get-Process -Name notepad } Stop-Process
Invoke-Command -ComputerName Domowy -ScriptBlock { Get-Process -Name notepad | Stop-Process }

<#LAB#>
Enable-PSRemoting -SkipNetworkProfileCheck <#Włącz remoting na lokalnym komputerze korzystając z opcji SkipNetworkProfileCheck#>
Enter-PSSession -ComputerName localhost <#Nawiąż połączenie do komputera lokalnego za pomocą polecenia Enter-PSSession#>
echo $env:COMPUTERNAME <#Wyświetl nazwę komputera, do którego połączenie zostało nawiązane#>
Exit-PSSession <#Zakończ połączenie#>
Invoke-Command -ComputerName localhost -ScriptBlock { $env:COMPUTERNAME } <#Uruchom na systemie zdalnym polecenie wyświetlające nazwę komputera w sposób wsadowy (nieinteraktywny)#>
Invoke-Command -ComputerName localhost -ScriptBlock { $env:COMPUTERNAME } | Get-Member <#Wyświetl wszystkie właściwości zwrócone przez zdalnie uruchomione polecenia. Zwróć uwagę, że wśród właściwości znajduje się PSComputerName, które zawiera informacje o komputerze na którym polecenie było wykonywane.#>
Invoke-Command -ComputerName localhost -ScriptBlock { $env:COMPUTERNAME } | Select-Object PSComputerName <#Wyświetl PSComputerName#>