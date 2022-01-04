"DOMOWY" | Out-File D:\script\computername.txt
Get-Content D:\script\computername.txt
Get-Content D:\script\computername.txt | Get-Process <# Tak nie zadziała #>
Get-Help Get-Process -ShowWindow
Get-Content D:\script\computername.txt | Select-Object @{n='ComputerName';e={$_}} | Get-Process
Get-Process -ComputerName (Get-Content D:\script\computername.txt)

"winlogon","WWAHost" | Out-File D:\script\processes.txt
Get-Content D:\script\processes.txt
Get-Content D:\script\processes.txt | Get-Process <# Tak nie zadziała #>
Get-Help Get-Process -ShowWindow
Get-Content D:\script\processes.txt | Select-Object @{n="Name";e={$_}} | Get-Process
Get-Process -Name (Get-Content D:\script\processes.txt)

notepad
Get-Process -Name notepad
Get-Process -Name notepad | Get-Member
Get-Help Stop-Process -ShowWindow
Get-Process -Name notepad | Stop-Process
"notepad" | Out-File D:\script\Process-to-stop.txt
Get-Content D:\script\Process-to-stop.txt
notepad
Get-Content D:\script\Process-to-stop.txt | Stop-Process
Get-Help Stop-Process -ShowWindow
Get-Content D:\script\Process-to-stop.txt | Select-Object @{n="Name";e={$_}} | Stop-Process
notepad
Stop-Process -Name (Get-Content D:\script\Process-to-stop.txt)

Get-Volume
"C" | Get-Volume
Get-Help Get-Volume -ShowWindow
'C' | select @{n='DriveLetter';e={$_}}
'C' | select @{n='DriveLetter';e={$_}} | Get-Volume
'C','D' | foreach {Get-Volume -DriveLetter $_}