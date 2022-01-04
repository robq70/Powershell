for($i=0;$i -lt 10;$i++)
{
Write-Host "$i"
}


$list="one","two","three","four","five"
foreach($x in $list) <#$x przyjmuje aktualną wartość pętli. Polecenie iterujące#>
{
Write-Host "The current element is $x"
}



$list | foreach {Write-Host "The current element is $_" } <#CMdlet#>


<#A&Q#>

<#Jakie będzie działanie kodu zakładając, że usługa SQLSERVERAGENT jest zatrzymana, a MSSQLSERVER jest uruchomiona. Pętla wykona się dla wszystkich usług niezależnie czy są one zatrzymane czy nie#>

$services ='SQLSERVERAGENT', 'MSSQLSERVER', 'SQLBrowser'
foreach($s in $services)
{
$status = Get-Service $s | select -ExpandProperty Status
if($status -eq "stopped")
{
Write-Warning "Starting $s"
Start-Service $s
}
}

<#Jakie będzie działanie następującej pętli FOR. Zostaną utworzone podfoldery 0-9#>

for($x=0;$x -lt 10;$x++)
{
New-Item -ItemType Directory -Path "c:\temp\$x"
}
<#W folderze C:\TEMP istnieje już plik o nazwie 4. Jakie będzie działanie tych instrukcji? Zostaną utworzone podfoldery 0-9. Podczas tworzenia folderu dojdzie do błędu i pętla przerwie się#>

for($x=0;$x -lt 10;$x++)
{
try
{
Write-Warning "Creating folder $x"
New-Item -ItemType Directory -Path "c:\temp\$x" -ErrorAction stop
}
catch
{
Write-Warning "Error appeared: $($Error[0].Exception)"
break
}
}

<#W folderze C:\TEMP istnieje już plik o nazwie 4. Jakie będzie działanie tych instrukcji? Zostaną utworzone podfoldery 0-9. Podczas tworzenia folderu dojdzie do błędu, ale ponieważ błąd jest obsłużony continue powoduje skok do warunku pętli i kontynuację iteracji#>

for($x=0;$x -lt 10;$x++)
    {
try
    {
    Write-Warning "Creating folder $x"
    New-Item -ItemType Directory -Path "c:\temp\$x" -ErrorAction stop
    }
catch
    {
    Write-Warning "Error appeared: $($Error[0].Exception)"
    continue
    }
    }

<#LAB#>


$files = Get-ChildItem D:\temp <#Zadeklaruj zmienną $files i przypisz do niej wynik polecenia Get-ChildItem listującego zawartość folderu c:\temp#>
foreach($f in $files) <#Napisz pętlę foreach,która dla każdego pliku z kolekcji $files#>
{
   $f.Encrypt() <#Zaszyfruj ten plik (wywołaj metodę Encrypt() dla bieżącego elementu kolekcji)#>
   $f.IsReadOnly = $true<#Zmień atrybut ReadOnly na $true. Wykorzystaj w tym celu właściwość ReadOnly bieżącego elementu kolekcji #>
}
$files = Get-ChildItem D:\temp <#Sprawdź czy pliki  są zaszyfrowane i mają ustawiony atrybut tylko do odczytu#>
foreach($f in $files) <#Napisz koleją pętlę foreach, która#>
{
    $f.Decrypt() <#Odszyfruje pliki #>
    $f.IsReadOnly = $false <#Wygasi atrybut tylko do odczytu #>
}
for($i=0;$i -lt 5; $i++) <#Napisz pętlę for, która wygeneruje 5 dźwięków w odstępach jednosekundowych#>
{
    [console]::beep(500,300) <#powoduje wygenerowanie dźwięku (500 Hz, 300 ms)#>
    Start-Sleep -Milliseconds 1000 <#Start-Sleep – zatrzymuje działanie skryptu na określony czas #>
}  