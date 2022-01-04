Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName Toshiba

$S=New-CimSession -ComputerName Toshiba <#wywołujemy połączenie / sesję z komputerem zdalnym i zapamiętujemy w zmiennej $S - domyślnie protokół WSMAN #>
Get-CimInstance -ClassName Win32_LogicalDisk -CimSession $S <# wykorzystujemy zmienną $S do połączenia z komputerem i pobrania danych o dyskach logicznych#>

$option=New-CimSessionOption -Protocol Dcom <#tworzymy obiekt opcji $option jeśli chcemy skorzystać ze starszego protokołu#>
$s2=New-CimSession -ComputerName Toshiba -SessionOption $option <#wywołujemy połączenie / sesję z komputerem zdalnym i zapamiętujemy w zmiennej $S2 z opcją $option poprzez DCOM#>
Get-CimInstance -ClassName Win32_OperatingSystem -CimSession $s2 <# wykorzystujemy zmienną $S2 do połączenia z komputerem i pobrania danych o systemie operacyjnym #>

$S <#wyświetlamy wartości zmiennej - WSMAN#>
$s2 <#wyświetlamy wartości zmiennej - DCOM#>

Get-CimSession <#Lista otwartych secji#>
Get-CimSession | Remove-CimSession <#Usuwanie sesji#>
Get-CimSession <#Brak sesji#>

$S <#wpisy w sesji WSMAN nadal istnieją#>
Get-CimInstance -ClassName Win32_LogicalDisk -CimSession $S <#odwołanie do tej sesji jednak zwraca błąd bo jej nie ma#>

<#Jak skonfigurować protokół WSMAN jeśli nie został skonfigurowany#>

Get-CimInstance -ClassName Win32_LogicalDisk -ComputerName Toshiba <#Otrzymujemy błąd jeśli na zdalnym komputerze zdalnym nie został uruchominoy serwis Web srvices for Management#>

<#na komputerze uruchamiamy komendę commandcom -> winrm quickconfig lub Powershell -> Enable-PSRemoting #>
winrm quickconfig
Enable-PSRemoting

<#LAB#>

$env:COMPUTERNAME <#sprawdzamy nazwę komputera#>
$CIMSession = New-CIMSession -ComputerName $env:COMPUTERNAME <#Tworzymy obiekt sesji zdalnej $CIMSession#>
Get-CimInstance -CimSession $CIMSession -ClassName Win32_OperatingSystem <#sprawdzamy jaki jest zainstalowany system operacyjny#>
Get-CimInstance -CimSession $CIMSession -ClassName Win32_product <#sprawdzamy jakie aplikacje są zainstalowane#>
Get-CimSession <#Wyświetla aktualnie dostępne sesje#>
Get-CimSession | Remove-CimSession <#Usuwa wszystkie sesje#>
$CIMSessionOption = New-CimSessionOption -Protocol Dcom <#Tworzy obiekt sesji oparty o protokół DCOM#>
Get-CimInstance -CimSession $CIMSession -ClassName win32_printer <#wyświetla informacje o drukarkach dostępnych na zdalnym komputerze#>
Get-CimSession | Remove-CimSession <#Usuwa wszystkie sesje#>