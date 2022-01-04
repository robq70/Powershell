$compNames="Domowy,Toshiba,Wiktor" <#Podstawiamy pod zmienn�#>
$compNames <#Wy�wietlamy zmienn� - dane po przecinkach nie nadaj� si� do tablicy#>

Get-Content D:\script\compnames.txt  <#Odczytujemy stworzyony r�cznie wcze�niej plik z tablic� komputer�w rozdzielonych enterem#>
$compNames = Get-Content D:\script\compnames.txt <#Przypisujemy plik z tablic� do zmiennej#>
$compNames  <#Wy�wietlamy zmienn� jest ok#>

$compNames | ForEach-Object {"Working on $_"} <#Polecenie wy�wietla po kolei napisy z tablicy - Working on Domowy etc.#>
$compNames | ForEach-Object {Get-Content "D:\script\$_.txt"} <#Polecenie odczytuje po kolei zawarto�� stworzonych wcze�niej plik�w Domowy.txt etc. podstawiaj�c po kolei nazwy pod plik ze zmienn� $_.txt#>

$compNames[0] <#Odwo�ujemy si� do element�w tablicy - w Powershell rozpoczyna si� od 0#>
$compNames[1] <#Odwo�ujemy si� do elementu 1#>
$compNames.Count <#Zwraca informacj� o d�ugo�ci tablicy - nie oznacza to �e zwraca zawsze to samo co Length#>
$compNames.Length <#Zwraca informacj� o d�ugo�ci tablicy - nie oznacza to �e zwraca zawsze to samo co Count#>
$compNames[0].Length <#Zwraca informacj� o d�ugo�ci pierwszego elementu listy#>
$compNames[$compNames.Count-1] <#Odwo�ujemy si� do ostatniego elementu tablicy Count liczy elementy i odejmujemy 1#>
$compNames[-1] <#Odwo�ujemy si� do ostatniego elementu tablicy#>
$compNames[-2] <#Odwo�ujemy si� do przedostatniego elementu tablicy#>
$compNames[11] <#Je�li si� pomylimy to otrzymamy obiekt pusty#>

$services = Get-Service <#Pobieramy list� serwis�w do zmiennej#>
$services.Count <#Obliczamy ilo�� serwis�w ze zmiennej#>
$runningservices = Get-Service | where {$_.Status -eq "Running"}  <#Pobieramy list� tylko uruchomionych serwis�w do zmiennej#>
$runningservices.Count  <#Obliczamy ilo�� serwis�w uruchomionych ze zmiennej#>
$services.Count - $runningservices.Count <#Ile serwis�w by�o w pozosta�ych stanach - odejmujemy obliczon� zmienn� ze wszystkimi serwisami od tej zmiennej z uruchomionymi#>

<#A&Q#>
<#1. Nale�y zweryfikowa� wa�no�� certyfikat�w CA z lokalnego komputera czyli wy�wietli� odcisk palca certyfikatu (thimbprint) i informacj� o jego wa�no�ci.#>
$certs = Get-ChildItem Cert:\LocalMachine\CA
$certs | ForEach-Object {$_.Thumbprint+""+$_.Verify()}

<#LAB#>
$subdirs = Get-Content D:\temp\subdirs.txt <#zadeklarowania tablicy $subdirs z pliku c:\temp\subdirs.txt, kt�rej elementami s� nazwy katalog�w 01_Input, 02_Processing, 03_Results #>
$subdirs = '01_Input','02_Procesing','03_Results' <#to samo co wy�ej#>
$subdirs
$BaseDir = 'D:\temp\'<#do zmiennej deklarujemy warto�� 'D:\temp\�#>
$subdirs | ForEach-Object {"$_"} <#wy�wietli zawarto�� poszczeg�lnych element�w tablicy#>
$subdirs | ForEach-Object { Write-Host $_ } <#wy�wietli zawarto�� poszczeg�lnych element�w tablicy#>
$subdirs | ForEach-Object {"$BaseDir"+""+"$_"} <#wy�wietli ca�� �cie�k� powsta�� z po�aczenia zmiennej BaseDir z w danej chwili przetwarzanym podkatalogiem#>
$subdirs | ForEach-Object { Write-Host "$BaseDir$_" } <#Jak wy�ej to samo#>
$subdirs | ForEach-Object { mkdir "$BaseDir$_"} <#Tworzy katalogi zgodnie ze �cie�k� zawart� w $BaseDir oraz nazwami w $_#>
$subdirs | ForEach-Object { New-Item -Path "$BaseDir$_" -ItemType Directory } <#Tworzy katalogi zgodnie ze �cie�k� zawart� w $BaseDir oraz nazwami w $_#>
$subdirs | Out-File -FilePath D:\temp\subdirs.txt <#umie�� zawarto�� zmiennej $subdirs w pliku#>
Get-Content D:\temp\subdirs.txt <#Wy�wietl zawarto�� tego pliku#>
Get-Content -Path D:\temp\subdirs.txt | ForEach-Object { Write-Host "$BaseDir$_"} <#nazwy podkatalog�w wczytujemy z pliku, zamiast korzysta� ze zmiennej $subdirs#>
Get-Content -Path D:\temp\subdirs.txt | ForEach-Object { New-Item -Path "$BaseDir$_" -ItemType Directory } <#Tworzy nowe katalogi zgodnie ze �cie�k� zawart� w $BaseDir oraz nazwami w $_#>