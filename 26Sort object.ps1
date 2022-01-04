Get-Service | Sort-Object -Property Name
Get-Service | Sort Name
Get-Service | Sort Status,Name
Get-Process
Get-Process | Get-Member #W skrócie GM
Get-Process | Sort VM
Get-Process | Sort VM -Descending
Get-EventLog -LogName Security | Sort-Object -Property TimeWritten -Descending #Wyświetla Log Security i sortuje po Czasie Zapisu
(Get-Process Notepad).Kill() #Wywołanie metody Kill
(Get-ChildItem c:\final.txt).CopyTo("c:\bin\final.txt")
(Get-ChildItem D:\script\1.txt).IsReadOnly #Wywołanie metody Czy jest do odczytu