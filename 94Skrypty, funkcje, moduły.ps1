<#
Wirtualne napędy w PowerShell
Jak pracować z plikami, dyskami i rejestrem
Jak załadować i usunąć moduł do pamięci
Jak samodzielnie tworzyć nowe napędy wirtualne
#>

c:
cd alias: <#Przejdziemy do napędu Alias:#>
ls <#Teraz polecenie ls lub dir wyświetli nam wszystkie aliasy#>
dir

cd variable: <#Przejdziemy do napędu Variable:#>
dir <#Teraz zobaczymy wartości wszystkich zmiennych#>
alias: <#Jeśli wpiszemy samo alias: bez cd system wygeneruje błąd#>
c: <#na dysk przejdziemy bez problemu#>

cd C:\Script <#Polecenie cd plus ścieżka zmienia katalog#>
dir <#Wyświetla zawartość#>
Set-Location C:\Script\test <#cd to alias do Set-Location#>
cd .. <#Przechodzi poziom niżej#>
Get-ChildItem <#dir,ls to alias do Get-ChildItem #>
New-Item newfile1.txt <#Utworzenie nowego pliku lub katalogu -ItemType Directory/File  -Name XXXX#>
Get-ItemProperty .\NewFile.txt <#Sprawdza właściwości pliku#>
Remove-Item .\NewFile.txt <#Usuwa obiekt#>

Get-PSProvider <#Pokazuje liste dostępnych Providerów (napędów łacznie z alias: itp.)#>

Set-Location HKLM: <#Przejście do rejestru HKLM#>
Set-Location HKLM:\SOFTWARE <#Przejście do rejestru HKLM:\SOFTWARE#>
Get-ChildItem Microsoft <#Pokaże wszystkie klucze znajdujące się w HKLM:\SOFTWARE\Microsoft#>
Set-Location .. <##>
New-Item -Name NewSoftware <#Podajemy nazwę nowego klucza w rejestrze#>
New-ItemProperty -Path NewSoftware -Name Mode -Value "Service" <#Podajemy nową właściwość w rejestrze#>
Get-ItemProperty -Path NewSoftware <#Wyświetlenie wartości dla istniejącego klucza#>
Set-ItemProperty -Path NewSoftware -Name Mode -Value "Application" <#Modyfikujemy nową właciwość#>
Get-ItemProperty -Path NewSoftware <#Wyświetlenie wartości dla istniejącego klucza#>
Remove-Item NewSoftware <#Usunięcie klucza w rejestrze#>

Get-Module -ListAvailable <#Pokazuje listę zainstalowanych modułów#>
Import-Module SQLPS <#Załadowuje moduł do pamięci pod warunkiem że mamy zainstalowanego SQL#>
Set-ExecutionPolicy RemoteSigned <#Jeśli nie można załadować modułu ustawiamyExecutionPolicy #>
Get-PSProvider <#Pokazuje listę dostępnych Providerów (napędów łacznie z nowo załadowanym)#>
Import-Module PSSQL
Set-Location SQLSERVER:\SQL\Domowy\Default\Databases <##>
dir | select Name,Size
Remove-Module SQLPS <#Jeśli nie możemy usunąć modułu to#>
C: <#przechodzimy na inny napęd#>
Remove-Module SQLPS <#I próbujemy usunąć ponownie#>
Get-PSProvider <#Pokazuje liste dostępnych Providerów (napędów)#>
Get-PSDrive <#Sprawdzenie dostępności napędów#>
New-PSDrive Script FileSystem C:\Script <#Można też samodzielnie definiować takie napędy#>
cd script: <#Przechodzimy do napędu#>
cd\ <#Aby go usunąć przechodzimy najpierw na inny dysk#>
Remove-PSDrive Script <#i dopiero go usuwamy#>

<#LAB#>
Get-PSDrive <##>
New-Item -Name PowershellLib -ItemType Directory <#Utwórz nowy katalog#>
"New-Item -Name PowershellLib -ItemType Directory" | Out-File C:\PowershellLib\skrypt.ps1 <#i zapisz w nim właśnie tworzony skrypt#>
New-PSDrive Lib FileSystem C:\PowershellLib <#Utwórz nowy napęd wirtualny PowerShell o nazwie Lib wskazujący na utworzony przed chwilą folder#>
cd Lib: <##>
dir <##>
Get-Module <#Wyświetl listę załadowanych modułów#>
Get-Module -ListAvailable <#Wyświetl listę dostępnych modułów#>
Get-Command -Module NetTCPIP <#Wyświetl listę poleceń znajdujących się w module NetTCPIP#>
Get-NetIPAddress <#Sprawdź działanie poleceń Get-NetIPAddress#>
Get-Module <#Sprawdź listę załadowanych modułów. Powinien się na niej znaleźć także NetTCPIP, który został załadowany automatycznie, bez użycia Import-Module, podczas uruchamiania polecenia z tego modułu#>
Remove-Module NetTCPIP <#Usuń moduł z pamięci#>
Get-Module <##>
cd HKLM:\SOFTWARE <#Przejdź do rejestru#>
New-Item -Name TestSoft <#Utwórz nowy klucz rejestru o nazwie TestSoft#>
New-ItemProperty -Path TestSoft -Name Edition -Value 'Proffesional' -PropertyType String <#Dodaj wartość do klucza rejestru Edition – typu string – o wartości ‘Professional’#>
New-ItemProperty -Path TestSoft -Name Version -Value '10' -PropertyType DWord <#Dodaj wartość do klucza rejestru Version – typu DWord – o wartości 10#>
Get-ItemProperty -Path .\TestSoft <#Wyświetl wszystkie właściwości w kluczu TestSoft#>
Get-ItemPropertyValue -Path .\TestSoft -Name Edition <#Wyświetl wartość właściwości Edition#>
Set-ItemProperty -Path TestSoft -Name Edition -Value 'Enterprise' <#Zmień wartość właściwości Edition na ‘Enterprise’#>
Get-ItemPropertyValue -Path .\TestSoft -Name Edition <##>
Remove-Item -Path TestSoft <#Usuń właściwość Version Usuń klucz TestSoft#>