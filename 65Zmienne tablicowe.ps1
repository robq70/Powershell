$compNames="Domowy,Toshiba,Wiktor" <#Podstawiamy pod zmienn¹#>
$compNames <#Wyœwietlamy zmienn¹ - dane po przecinkach nie nadaj¹ siê do tablicy#>

Get-Content D:\script\compnames.txt  <#Odczytujemy stworzyony rêcznie wczeœniej plik z tablic¹ komputerów rozdzielonych enterem#>
$compNames = Get-Content D:\script\compnames.txt <#Przypisujemy plik z tablic¹ do zmiennej#>
$compNames  <#Wyœwietlamy zmienn¹ jest ok#>

$compNames | ForEach-Object {"Working on $_"} <#Polecenie wyœwietla po kolei napisy z tablicy - Working on Domowy etc.#>
$compNames | ForEach-Object {Get-Content "D:\script\$_.txt"} <#Polecenie odczytuje po kolei zawartoœæ stworzonych wczeœniej plików Domowy.txt etc. podstawiaj¹c po kolei nazwy pod plik ze zmienn¹ $_.txt#>

$compNames[0] <#Odwo³ujemy siê do elementów tablicy - w Powershell rozpoczyna siê od 0#>
$compNames[1] <#Odwo³ujemy siê do elementu 1#>
$compNames.Count <#Zwraca informacjê o d³ugoœci tablicy - nie oznacza to ¿e zwraca zawsze to samo co Length#>
$compNames.Length <#Zwraca informacjê o d³ugoœci tablicy - nie oznacza to ¿e zwraca zawsze to samo co Count#>
$compNames[0].Length <#Zwraca informacjê o d³ugoœci pierwszego elementu listy#>
$compNames[$compNames.Count-1] <#Odwo³ujemy siê do ostatniego elementu tablicy Count liczy elementy i odejmujemy 1#>
$compNames[-1] <#Odwo³ujemy siê do ostatniego elementu tablicy#>
$compNames[-2] <#Odwo³ujemy siê do przedostatniego elementu tablicy#>
$compNames[11] <#Jeœli siê pomylimy to otrzymamy obiekt pusty#>

$services = Get-Service <#Pobieramy listê serwisów do zmiennej#>
$services.Count <#Obliczamy iloœæ serwisów ze zmiennej#>
$runningservices = Get-Service | where {$_.Status -eq "Running"}  <#Pobieramy listê tylko uruchomionych serwisów do zmiennej#>
$runningservices.Count  <#Obliczamy iloœæ serwisów uruchomionych ze zmiennej#>
$services.Count - $runningservices.Count <#Ile serwisów by³o w pozosta³ych stanach - odejmujemy obliczon¹ zmienn¹ ze wszystkimi serwisami od tej zmiennej z uruchomionymi#>

<#A&Q#>
<#1. Nale¿y zweryfikowaæ wa¿noœæ certyfikatów CA z lokalnego komputera czyli wyœwietliæ odcisk palca certyfikatu (thimbprint) i informacjê o jego wa¿noœci.#>
$certs = Get-ChildItem Cert:\LocalMachine\CA
$certs | ForEach-Object {$_.Thumbprint+""+$_.Verify()}

<#LAB#>
$subdirs = Get-Content D:\temp\subdirs.txt <#zadeklarowania tablicy $subdirs z pliku c:\temp\subdirs.txt, której elementami s¹ nazwy katalogów 01_Input, 02_Processing, 03_Results #>
$subdirs = '01_Input','02_Procesing','03_Results' <#to samo co wy¿ej#>
$subdirs
$BaseDir = 'D:\temp\'<#do zmiennej deklarujemy wartoœæ 'D:\temp\’#>
$subdirs | ForEach-Object {"$_"} <#wyœwietli zawartoœæ poszczególnych elementów tablicy#>
$subdirs | ForEach-Object { Write-Host $_ } <#wyœwietli zawartoœæ poszczególnych elementów tablicy#>
$subdirs | ForEach-Object {"$BaseDir"+""+"$_"} <#wyœwietli ca³¹ œcie¿kê powsta³¹ z po³aczenia zmiennej BaseDir z w danej chwili przetwarzanym podkatalogiem#>
$subdirs | ForEach-Object { Write-Host "$BaseDir$_" } <#Jak wy¿ej to samo#>
$subdirs | ForEach-Object { mkdir "$BaseDir$_"} <#Tworzy katalogi zgodnie ze œcie¿k¹ zawart¹ w $BaseDir oraz nazwami w $_#>
$subdirs | ForEach-Object { New-Item -Path "$BaseDir$_" -ItemType Directory } <#Tworzy katalogi zgodnie ze œcie¿k¹ zawart¹ w $BaseDir oraz nazwami w $_#>
$subdirs | Out-File -FilePath D:\temp\subdirs.txt <#umieœæ zawartoœæ zmiennej $subdirs w pliku#>
Get-Content D:\temp\subdirs.txt <#Wyœwietl zawartoœæ tego pliku#>
Get-Content -Path D:\temp\subdirs.txt | ForEach-Object { Write-Host "$BaseDir$_"} <#nazwy podkatalogów wczytujemy z pliku, zamiast korzystaæ ze zmiennej $subdirs#>
Get-Content -Path D:\temp\subdirs.txt | ForEach-Object { New-Item -Path "$BaseDir$_" -ItemType Directory } <#Tworzy nowe katalogi zgodnie ze œcie¿k¹ zawart¹ w $BaseDir oraz nazwami w $_#>