$letter='c:'
$valueToReturn="Used"
<#W tym przykladzie wykonamy to samo jak w If#>

Switch($valueToReturn) <#Switch spojrzy na wartość która znajduje się w warunku i w zależności od niej wykona jedno z poleceń#>

{n
"FreeSpace" {Get-WmiObject Win32_LogicalDisk -Filter "DeviceId='$letter'" | select FreeSpace } <#Jeżeli $valueToRetur będzie miała taką wartość to wykona to polecenie#>
"TotalSpace" {Get-WmiObject Win32_LogicalDisk -Filter "DeviceId='$letter'" | select Size } <#Jeżeli $valueToRetur będzie miała taką wartość to wykona to polecenie#>
Default {Get-WmiObject Win32_LogicalDisk -Filter "DeviceId='$letter'" | select @{n="Used";e={$_.Size-$_.FreeSpace}}} <#Jeśli $valueToReturn będzie miała inną wartość niż powyżej to wykona polecenie domyślne#>

}

<#Switch używamy gdy zmienna w czasie pracy programu może przyjąć kilka znanych wartości#>

<#A&Q#>


<#Zmienna $drive została zainicjowana przez#>

$drive='D'

<#Jaką wartość przyjmie $label po wykonaniu kodu:#>

switch($drive)

{

'C' { $label = 'system' }

'D' { $label = 'apps' }

'T' { $label = 'temp' }

default {$label = 'data'}

}


<#Jaki będzie efekt wykonania tego skryptu?#>

$symbol = 'app'

Write-Host "$(switch($symbol){'app' {'application'} 'f' {'file'} default {'other'}}) server"



<#Zmienna $drive ma wartość 'T'. Jaki będzie skutek wykonania poniższego kodu?#>

$label = switch($drive)

{

'C' { 'system' }

'D' { 'apps' }

'T' { 'temp' }

default { 'data'}

}