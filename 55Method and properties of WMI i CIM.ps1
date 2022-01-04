Get-WmiObject -Class Win32_OperatingSystem | Get-Member <#Wyświetlanie metod i właściwości#>
Get-WmiObject -Class Win32_OperatingSystem | select InstallDate <#Wyświetlanie daty zainstalowania systemu#>

Get-CimClass -ClassName Win32_OperatingSystem | Get-Member <#Wyświetlanie metod i właściwości#>
Get-CimClass -ClassName Win32_OperatingSystem | Select-Object CimClassMethods <#Wyświetlanie metod /zostały zgrupowane w kolekcjach CimClassMethods oraz CimClassProperties / i właściwości#>

Get-CimClass -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty CimClassMethods

Get-CimClass -ClassName Win32_OperatingSystem | Select-Object -ExpandProperty CimClassMethods | where Name -EQ Win32Shutdown | Select-Object -ExpandProperty Parameters

Get-CimClass -ClassName Win32_LogicalDisk | Select-Object -ExpandProperty CimClassMethods
Get-CimClass -ClassName Win32_TimeZone | Select-Object -ExpandProperty CimClassMethods <# Nie ma żadnych klas tylko właściowści #>

Get-WmiObject -Class Win32_Group
Get-CimInstance -ClassName Win32_Group
Get-CimInstance -ClassName Win32_Group -Filter "Name='PS_Test'" <# Wyświetli grupę PS_Test #>

Get-WmiObject -Class Win32_Group -Filter "Name='PS_Test'" | Invoke-WmiMethod -Name Rename -Argument "PSTest" <#zmiana nazwy na PSTest#>
Get-WmiObject -Class Win32_Group
Get-CimInstance -ClassName Win32_Group
Get-CimInstance -ClassName Win32_Group -Filter "Name='PSTest'" <# Wyświetli grupę PSTest #>
Get-CimInstance -ClassName Win32_Group -Filter "Name='PSTest'" | Invoke-CimMethod -MethodName Rename -Arguments @{"Name"='PS_Test'} <#zmiana nazwy na PSTest#>
Get-CimInstance -ClassName Win32_Group -Filter "Name='PS_Test'" <# Wyświetli grupę PSTest #>

Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{"CommandLine"="notepad.exe"}
Get-Process -Name notepad
Get-CimInstance -ClassName Win32_Process -Filter "Name='notepad.exe'" | Invoke-CimMethod -MethodName Terminate

Get-WmiObject -ClassName Win32_Process -Filter "Name='notepad.exe'" | ForEach-Object {$_.Terminate(0)} <#zmiana nazwy na PSTest#>

<#LAB#>

Get-CimInstance -ClassName Win32_NetworkAdapter <# Wyświetla wszystkie karty sieciowe #>
Get-CimClass -ClassName Win32_NetworkAdapter | Get-Member <#  metody i właściwości obiekty klasy Win32_NetworkAdapter #>
Get-CimInstance -ClassName Win32_NetworkAdapter | where DeviceID -EQ 0 <# Wyświetla wszystkie karty sieciowe #>
Get-WmiObject  Win32_NetworkAdapter | where ServiceName -eq NETwNb64 | Invoke-WmiMethod -Name Disable <#Korzystając z metody Disable wyłącz ten adapter#>
Get-WmiObject  Win32_NetworkAdapter | where ServiceName -eq NETwNb64 | Invoke-WmiMethod -Name Enable <#Korzystając z metody Enable włącz ten adapter#>

Get-WmiObject Win32_NetworkAdapter | where DHCPEnabled <# adaptery sieciowe, które mają włączone DHCP #>
Get-WmiObject Win32_NetworkAdapterConfiguration | where DHCPEnabled | gm <#jakie metody i właściwości posiadają obiekty klasy Win32_NetworkAdapterConfiguration#>
Get-WmiObject Win32_NetworkAdapterConfiguration | where DHCPEnabled | Invoke-WmiMethod -Name ReleaseDHCPLease
Get-WmiObject Win32_NetworkAdapterConfiguration | where DHCPEnabled | Invoke-WmiMethod -Name RenewDHCPLease