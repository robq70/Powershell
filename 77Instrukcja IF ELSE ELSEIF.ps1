$letter='c:'

Get-WmiObject Win32_LogicalDisk <#Pokazuje logiczne dyski#>
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='c:'" <#Pokazuje dysk c:#>
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='$letter'" <#Pokazuje dysk c: wykorzystując zmienną $letter z parametrem#>
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='$letter'" | GM <#Sprawdzamy co może być zwracane#>
Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$letter'" | select Size,FreeSpace,@{n="Used";e={$_.Sise-$_.FreeSpace}} <#Zwraca rozmiar dysku, wolne miejsce oraz oblicza zużyte miejsce#>



$letter='c:' <#określamy przez zmienną dysk#>
$valueToReturn='TotalSpace' <# oraz określamy również co ma być zwrócone#>

If($valueToReturn -eq "FreeSpace") <#Jeżeli $valueToReturn=FreeSpace to wykonane zostanie pierwsze polecenie bloku, jeśli nie przeskoczy do kolejnego#>
{

Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='$letter'" | select FreeSpace
}
ElseIf($valueToReturn -eq "TotalSpace")<#Jeżeli $valueToReturn=TotalSpace to wykonane zostanie drugie polecenie bloku, jeśli nie przeskoczy do kolejnego#>
{
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='$letter'" | select Size
}
Else <#Jeżeli $valueToReturn=TotalSpace to wykonane zostanie trzeciego polecenie bloku, jeśli nie przeskoczy do kolejnego#>
{
Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='$letter'" | select @{n="Used";e={$_.Sise-$_.FreeSpace}}
}



<#A&Q#>
<#Administrator przygotował i załadował już do pamięci funkcję Get-Freespace, która dla określonego dysku zwraca informację o ilości wolnego miejsca na dysku.#>
<#Na dysku C: jest obecnie 4 GB wolnego miejsca. Jaki będzie efekt działania tego skryptu? - Disk low space warning#>

$freespace = Get-Freespace -disk 'c:'

if($freespace -lt 1GB)
{
Write-Warning "Disk low space alert"
}
elseif($freespace -lt 5GB)
{
Write-Warning "Disk low space warning"
}
else
{
Write-Warning "Disk space ok"
}


<#Administrator przygotował i załadował już do pamięci funkcję Get-Freespace, która dla określonego dysku zwraca informację o ilości wolnego miejsca na dysku. Nie wykona się ponieważ zastosowano znak < #>

$freespace = Get-Freespace -disk 'c:'

if($freespace < 1GB)
{
Write-Warning "Disk low space alert"
}
elseif($freespace < 5GB)
{
Write-Warning "Disk low space warning"
}
else
{
Write-Warning "Disk space ok"
}


<#Polecenie Test-Connection sprawdza czy komputer określony przez ComputerName odpowiada na żądania ping. Określ działanie poniższego fragmentu kodu zakładając, że w sieci jest dostępny komputer Turing - Connection OK #>
If (Test-Connection -Quiet -ComputerName Turing)
{
Write-Host "Connection OK"
}
else
{
Write-Host "Cannot connect"
}


<#LAB#>

<#Twoim zadaniem będzie przekopiować plik między dwoma komputerami. Aby uniknąć błędu w pierwszej kolejności sprawdzisz czy zdalny komputer odpowiada na ping. Wykonaj testowe sprawdzenie łączności ze zdalnym komputerem za pomocą polecenia Test-Connection.#>
Get-Help Test-Connection -Online

Test-Connection -ComputerName 'localhost' -Count 1 -Quiet <#Postaraj się aby polecenie zwracało wynik prawda. Wykonywało test tylko w oparciu o odpowiedź na pojedynczy pakiet ping#>

Test-Connection -ComputerName 'SomeComputer' -Count 1 -Quiet <#Postaraj się aby polecenie zwracało wynik fałsz. Wykonywało test tylko w oparciu o odpowiedź na pojedynczy pakiet ping#>

<#Wynik polecenia Test-Connection zapamiętaj w zmiennej $isAlive #>
$isAlive = Test-Connection -ComputerName 'SomeComputer' -Count 1 -Quiet 

<#Wykorzystaj zmienną $isAlive w warunku polecenia if. Jeśli warunek jest spełniony plik ma być kopiowany z komputera lokalnego na zdalny #>
if($isAlive)

{

    Copy-Item C:\temp\FileToCopy.txt \\SomeComputer\c$\temp\NewFile.txt

} 

<#Dodaj do polecenia wyrażenie else. W przypadku braku łączności z komputerem zdalnym wyświetl komunikat „remote host is not responding”#>

if($isAlive)

{

    Copy-Item C:\temp\FileToCopy.txt \\SomeComputer\c$\temp\NewFile.txt

}

else

{

    Write-Host "Remote host is not responding"

} 

<#Napisz polecenie, które uruchomi usługę tylko o ile aktualnie ta usługa nie jest uruchomiona. Przed i po uruchomieniu usługi dodaj polecenia wyświetlające na ekranie dodatkowe komunikaty. #>
if( (Get-Service bits).Status -eq "Stopped")

{

    Write-Host "Starting service"

    Start-Service bits

    Write-Host "Service started"

} 

<#Dodaj do poprzedniej instrukcji polecenie else, które w przypadku gdy usługa już działa wyświetli komunikat „Service is already running”#>

if( (Get-Service bits).Status -eq "Stopped")

{

    Write-Host "Starting service"

    Start-Service bits

    Write-Host "Service started"

}

else

{

    Write-Host "Service is already running"

}