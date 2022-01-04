<#
Jak uwierzytelnić użytkownika w systemie zdalnym
Pobieranie poświadczeń użytkownika - Get-Credentials
Zagrożenia podczas korzystania z remotingu
Co to jest mutual authentication
Przesyłanie do systemów zdalnych
TrustedHosts
#>

Invoke-Command -ComputerName Domowy -ScriptBlock { Get-Process -Name notepad }

winrm s winrm/config/client '@{TrustedHosts="Domowy"}'

Get-Credential <#Wyświetla okno pytające o dane uwierzytelnienia bez żadnych dodatkowych parametrów#>
Get-Credential -Message "To access this computer you need to enter your credentials" <#Wyświetl okno pytające o dane uwierzytelnienia wraz z komunikatem#>
Get-Credential -Message "To access this computer you need to enter your credentials" -UserName "robq70" <#Wyświetl okno pytające o dane uwierzytelnienia wraz z komunikatem i wypełnionym polem user#>
$cred=Get-Credential -Message "To access this computer you need to enter your credentials" -UserName "robq70" <#zapisz poprzednie polecenie do zmiennej#>

Invoke-Command -ComputerName Domowy -Credential $cred -ScriptBlock { Get-Process -Name notepad } <#Wysyła polecenie do komputera zdalnego#>

<#LAB#>
Get-Credential <#Wyświetl okno pytające o dane uwierzytelnienia bez żadnych dodatkowych parametrów#>
Get-Credential -Message 'Enter username for domain MYCOMPANY' <#Wyświetl okno pytające o dane uwierzytelnienia. Niech komunikat wyświetlany w oknie będzie następujący: „Enter username and password from MYDOMAIN”#>
$adminCred =Get-Credential -UserName "$($env:COMPUTERNAME)\Administrator" -Message 'Enter password' <#  Wyświetl okno pytające o dane uwierzytelnienia:
                                                                                                        a. Komunikat w oknie – „Enter Password”
                                                                                                        b. Wstępnie wypełniona nazwa użytkownika – w postaci <nazwa komputera lokalnego>\Administrator
                                                                                                        c. Wartość zwracana ma być zapisana do zmiennej $adminCred 
                                                                                                    #>
ls WSMan:\localhost\Client\ <#Wyświetl opcje klienta protokołu WSMAN#>
Get-Item -Path WSMan:\localhost\Client\TrustedHosts <#Wyświetl wartość opcji TrustedHosts korzystając z polecenia Get-Item#>
Set-Item -Path WSMan:\localhost\Client\TrustedHosts -Value '*' <# Zmień wartość opcji TrustedHosts na *#>
Get-Item -Path WSMan:\localhost\Client\TrustedHosts <#Wyświetl wartość opcji TrustedHosts#>
$currentValue = (Get-Item -Path WSMan:\localhost\Client\TrustedHosts).Value <#Zapisz do zmiennej $currentValue aktualną wartość opcji TrustedHosts.#>
$currentValue <#Sprawdź zawartość tej zmiennej#>
Invoke-Command -ComputerName localhost -Credential $adminCred -ScriptBlock { echo "current user is $env:USERNAME" } <#Korzystając z danych uwierzytelnienia pobranych w kroku (3) uruchom na lokalnym komputerze skrypt wyświetlający „Current user is $($env:USERNAME) Uwaga! Jeśli konto administratora na bieżącym komputerze  jest zablokowane (wyłączone) to skorzystaj z innego konta.#>