Get-EventLog -LogName Application -Newest 5
Get-ChildItem D:\script | Sort-Object -Property Length -Descending | Select-Object -First 3
Get-ChildItem D:\script | Sort-Object -Property Length -Descending | Select-Object -First 3 -Skip 1
Get-ChildItem D:\script | Sort-Object -Property Length -Descending
Get-ChildItem D:\script | Sort-Object -Property Length -Descending | Select-Object -Property Name,IsReadOnly,CreationTime,Extension
Get-ChildItem D:\script | Sort-Object -Property Length -Descending | Select-Object -Property Name,IsReadOnly,CreationTime,Extension -First 3
Get-ChildItem D:\script | Sort-Object -Property Length -Descending | Select-Object -Property *
