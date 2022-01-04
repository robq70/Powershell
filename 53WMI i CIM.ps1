Get-WmiObject -Namespace root -List -Recurse
Get-WmiObject -Namespace root\CIMv2 -List -Recurse
Get-WmiObject -Namespace root -List -Recurse | select -Unique __Namespace
Get-WmiObject -Namespace root\CIMv2 -List -Recurse | select -Unique __Namespace
Get-WmiObject -Namespace root\CIMv2 -List -Recurse | where {$_.Name -like "*desktop*"}
Get-WmiObject -Namespace root\CIMv2 -List | Sort-Object Name

Get-CimClass -Namespace root\cimv2 | Sort CimClassName
Get-CimClass -Namespace root\CIMv2 | where {$_.CimClassName -like "*desktop*"} | Sort CimClassName

Get-WmiObject -Class Win32_Desktop
ft
Get-WmiObject -Class Win32_LogicalDisk

Get-CimInstance -ClassName Win32_Desktop
Get-CimInstance -ClassName Win32_LogicalDisk

Get-WmiObject -Query "select * from Win32_LogicalDisk"
Get-CimInstance  -Query "select * from Win32_LogicalDisk"

Get-WmiObject -Class Win32_Process -Filter "Name = 'notepad.exe'"
Get-CimInstance -ClassName Win32_Process -Filter "Name = 'notepad.exe'"

Get-WmiObject -Query "select * from Win32_Process where Name = 'notepad.exe'"
Get-CimInstance -Query "select * from Win32_Process where Name = 'notepad.exe'"

<#lab#>

Get-WmiObject -List | WHERE Name -like *network* #Wylistuj obiekty WMI, które w nazwie zawierają *network*
Get-CimClass | WHERE CimClassName -like *network* #Wylistuj obiekty CIM, które w nazwie zawierają *network*

Get-WmiObject WIN32_NetworkAdapter #Wyświetl obiekty klasy WIN32_NetworkAdapter
Get-CimInstance WIN32_NetworkAdapter #Wyświetl obiekty klasy WIN32_NetworkAdapter

Get-WmiObject WIN32_NetworkAdapter | GM #Jakie właściwości i metody ma obiekt klasy Win32_NetworkAdapter
Get-CimInstance WIN32_NetworkAdapter | GM #Jakie właściwości i metody ma obiekt klasy Win32_NetworkAdapter

Get-WmiObject WIN32_NetworkAdapter | select -Property Caption,MACAddress #Wyświetl dla każdego obiektu z poprzednich punktów tylko właściwość Caption oraz MACAddress
Get-CimInstance WIN32_NetworkAdapter | select -Property Caption,MACAddress #Wyświetl dla każdego obiektu z poprzednich punktów tylko właściwość Caption oraz MACAddress

Get-WmiObject WIN32_BIOS #czy komputer na jakim pracujesz jest wirtualny
Get-CimInstance Win32_BIOS #czy komputer na jakim pracujesz jest wirtualny

 Get-WmiObject Win32_UserAccount #wyświetl listę lokalnych użytkowników komputera
 Get-CimInstance Win32_UserAccount #wyświetl listę lokalnych użytkowników komputera