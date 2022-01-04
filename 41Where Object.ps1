10 -gt 5 #Greater Than
10 -eq 8 #EQuivalent with
10 -lt 11 #Less than, < 
10 -ge 10 #Greater than or Equivalent with
10 -le 10 #Less than or Equivalent with
10 -ne 11 #Not Equivalent with
'powershell' -like 'Power*'
'powershell' -clike 'Power*'
-not $true
1 -eq 1 -and 2 -eq 2
1 -eq 1 -or 2 -eq 20
-not (1 -eq 1)
-not (1 -eq 1) -and 2 -eq 2
Get-ChildItem D:\script | Get-Member
Get-ChildItem D:\script | Where-Object -Property PSIsContainer -EQ -value $true
Get-ChildItem D:\script | Where PSIsContainer -EQ $true
Get-ChildItem D:\script | Where PSIsContainer
Get-ChildItem D:\script | ? PSIsContainer
Get-ChildItem D:\script | Where PSIsContainer -EQ $false -and Extension -eq '.txt' # Źle
Get-ChildItem D:\script | Where -FilterScript {$_.PSIsContainer -EQ $false}
Get-ChildItem D:\script | Where -FilterScript {$_.PSIsContainer -EQ $false -and $_.Extension -eq '.txt'}
Get-ChildItem D:\script -Filter "*.txt" -File
ls D:\Script | where {$_.LastWriteTime -lt (Get-Date).AddMinutes(-5)}
ls D:\script  -Filter *.txt | where { $_.LastWriteTime -lt (Get-Date).AddDays(-2) }
notepad ; notepad ; notepad
Get-Process
Get-Process -Name *notepad*
Get-Process | Where-Object Name -like *notepad*
Get-Process | ? Name -like *notepad*
Get-EventLog -LogName System -Source USER32
Get-EventLog -LogName System -Source USER32 | Where-Object {$_.EventID -eq 1074 }
Get-EventLog -LogName System -Source "User32" | where {$_.EventID -eq 1074}