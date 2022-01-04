$compNames = "Domowy" <#ustawiamy zmienną jako nazwę komputera#>
$compNames
Get-Service -ComputerName Domowy | where Name -Like "Intel*"
Get-Service -ComputerName $compNames | where Name -Like "Intel*"

Get-ChildItem VARIABLE:\ <#Wyświetl zawartość napędu#>
Get-ChildItem VARIABLE:\comp*

Get-Command -Noun Variable
Clear-Variable compNames
Remove-Variable compNames <#to samo co wyżej#>
$compNames
Get-ChildItem VARIABLE:\comp*
Set-PSDebug -Strict <#Wywołuje się aby użycie niezainicjowanej zmiennej spowodowało błąd#>

Set-Variable compNames Domowy <#Używa się aby nadawać zmienną dynamicznie#>
$compNames

New-Variable FilterExpression <#utworzenie nowej zmiennej bez wartości#>
Set-Variable FilterExpression Intel <#nadanie jej wartości sql#>
$FilterExpression
Get-Service -ComputerName $compNames | where Name -Like "$FilterExpression*"
"Displaying services like $FilterExpression on computer(s) $compNames" <# Wyświetli Displaying services like Intel on computer(s) Domowy#>
'Displaying services like $FilterExpression on computer(s) $compNames' <#Wyświetli to co napialiśmy nie podstawiając wartości pod zmienne#>


<#LAB#>

$MyService = "bits" <# Zadeklaruj zmienną o nazwie MyService i przypisz do niej wartość „bits”#>
Get-Service $MyService <# Wyświetl usługi o nazwie $MyService#>
New-Variable 'EventLogName' <# zadeklaruj nową zmienną #>
Set-Variable EventLogName System <#przypisz jej wartość#>
New-Variable EventNumber <#zadeklaruj nową zmienną#>
Set-Variable EventNumber 5 <#przypisz jej wartość#>
$EventLogName <#sprawdzenie wartości#>
$EventNumber <#sprawdzenie wartości#>

Get-EventLog -Newest 3 -LogName application <#Wywołanie polecenia#>
Get-EventLog -Newest $EventNumber -LogName $EventLogName <#Wywołanie polecenia z utworzonymi wcześniej zmiennymi#>
Get-ChildItem Env: <#Wyświetl zawartość napędu#>
$MyComputerName = Get-Content  Env:\COMPUTERNAME <#przypisanie wartości#>
$MyOperatingSystem = Get-Content Env:\os <#przypisanie wartości#>
$MyUserName = Get-Content  Env:\USERNAME <#przypisanie wartości#>
Get-Content -Path Env:\PROCESSOR_ARCHITECTURE <#Zmienne środowiskowe z napędu ENV: są w powershell traktowane jak pliki. Aby wczytać ich wartość posłuż się poleceniem Get-Content#>
$env:COMPUTERNAME <#Do zmiennych środowiskowych można się również odwoływać przez zmienną $env#>
$env:USERNAME <#Do zmiennych środowiskowych można się również odwoływać przez zmienną $env#>
$env:OS <#Do zmiennych środowiskowych można się również odwoływać przez zmienną $env#>