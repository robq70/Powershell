#Przekazywanie parametrów lokalnych do komputerów zdalnych
#Opcja ArgumentList i sekcja Param
#Zaawansowane polecenia Invoke-Command


$name = "notepad" <#zapamiętujemy w zmiennej
Invoke-Command -ComputerName Domowy -Credential $cred -ScriptBlock { Get-Process -Name $name } #logujemy się do zdalnego komputera przy użyciu wcześniej zapamiętanych danych /$cred - w poprzednim ćwiczeniu/
Polecenie nie zostanie wykonane ponieważ zmienna $name jest zapamiętana lokalnie a dla zdalnego systemu nie istnieje
Invoke-Command -ComputerName Domowy -Credential $cred -ScriptBlock { Param($x) Get-Process -Name $x } -ArgumentList ($name) #
Aby poprzedni skrypt zadziałał musimy użyć param który definiuje jedną lub więcej zmiennych (powinno być ich tyle samo co w Argumentlist) oraz -ArgumentList który zawiera listę zmiennych i dla systemu zdalnego będą widoczne jako parametry
zmienna $x przyjmuje wartość z parametru ArgumentList#>


#Przykład z kilkoma zmiennymi
$log = "Security" #definiujemy pierwszą zmienną
$num = 10 #definiujemy drugą zmienną

Get-EventLog $log -Newest $num #tak ta komenda wyglądałaby lokalnie z Logów security pobiera 10 najnowszych

Invoke-Command -ComputerName Domowy -Credential $cred -ScriptBlock { Param($logName,$n) Get-EventLog $logName -Newest $n } -ArgumentList ($log,$num) #A tak wygląda to samo ale zdalnie

<#Q&A#>


<#Pytanie 1:
Popatrz na następujący skrypt:
Co się stanie po uruchomieniu polecenia?
Nie zadziała ponieważ wartość $service wyniesie null#>

$service = Invoke-Command -Computer SAPP0001 -Script {Get-Service bits}
Invoke-Command -Computer SAPP0001 Script { Stop-Service $service }

<#Pytanie 2:
Przeanalizuj poniższy skrypt:
Co stanie się po uruchomieniu skryptu?
Zostanie zatrzymana usługa bits na systemie zdalnym#>

$service = Invoke-Command -Computer turing -Script {Get-Service bits}
Invoke-Command -Computer turing -Script { Param($s) Stop-Service $s } -ArgumentList $service

<#Pytanie 3:
Popatrz na poniższy fragment skryptu:
Co się stanie po uruchomieniu skryptu?
Zostanie zatrzymana usługa bits na systemie lokalnym#>

$service = Invoke-Command -Computer turing -Script {Get-Service bits}
Stop-Service $service

<#Pytanie 4:
Popatrz na poniższy fragment skryptu:
Co się stanie kiedy go uruchomisz?
Nie zadziała ponieważ wartość $service wyniesie null#>

$service = Invoke-Command -Computer turing -Script {Get-Service bits}
Invoke-Command -Computer turing -Script { Param($s) Stop-Service $service } -ArgumentList $service

#Pytanie 5:
#Gdy do polecenia Invoke-Command przekazujesz argumenty przez -AgumentList a następnie przyjmujesz te argumenty w seskcji param, to nie jest istotne aby nazwy zmiennych w -ArgumentList oraz w sekcji Param były takie same.


<#LAB#>

Get-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -ne $null } #wyświetla listę zainstalowanych na komputerze aplikacji. Sprawdź działanie tego polecenia
Get-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -ne $null } | Select DisplayName,Publisher,DisplayVersion,InstallDate #wyświetl tylko wybrane informacje z tej listy
Get-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -ne $null } | Select DisplayName,Publisher,DisplayVersion,InstallDate | Sort-Object DisplayName #wyświetl posortowane wg DisplayName
$DisplayName= "C++"
$Publisher = "Microsoft"
Get-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -ne $null } | Select DisplayName,Publisher,DisplayVersion,InstallDate | Sort-Object DisplayName | Where {$_.DisplayName -like "*$DisplayName*" -and $_.Publisher -like "*$Publisher*" }  #wyświetl tylko programy zawierające w nazwie $DisplayName i wydane przez dostawców, którzy w nazwie mają ciąg znaków znajdujący się w zmiennej $Publisher
Invoke-Command -Computer localhost -ScriptBlock { Param($DisplayName,$Publisher) 
Get-ItemProperty -Path HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | 
Where { $_.DisplayName -ne $null } | Select DisplayName,Publisher,DisplayVersion,InstallDate | 
Sort-Object DisplayName | Where {$_.DisplayName -like "*$DisplayName*" -and $_.Publisher -like "*$Publisher*" } } -ArgumentList ($DisplayName,$Publisher) #To samo co wcześniej tylko system zdalny