#Sesje

#Tworzenie sesji
#Nawiązywanie połączenia z wykorzystaniem sesji
#Zarządzanie sesjami
#Konfigurowanie protokołu WSMAN

$cred = Get-Credential -Message "Enter Credentials for Domowy" #Tworzymy zmienną z naszymi poświadczeniami
$cred2 = Get-Credential -Message "Enter Credentials for Wiki" #Tworzymy zmienną z naszymi poświadczeniami

$session = New-PSSession -ComputerName Domowy -Credential $cred #Tworzymy zmienną sesji używając zmienną z naszymi poświadczeniami
$session #Sprawdzamy zawartość zmiennej

Enter-PSSession -Session $session #Nawiązujemy połączenie korzystając z gotowego obiektu $session
cd D:\temp
Exit-PSSession #Kończymy połączenie 

Get-PSSession #ale nasza sesja dalej istnieje

Invoke-Command -Session $session -ScriptBlock { Get-WmiObject -Class Win32_OperatingSystem } #korzystamy z invoke wykorzystując parametr $session

New-PSSession -ComputerName Wiki -Credential $cred2 -Name "Backup Session" #Tworzymy kolejną sesję z komputerem zdalnym

Get-PSSession #Sprawdzamy które sesje są otwarte

Invoke-Command -Session (Get-PSSession -Name "Backup Session") -ScriptBlock {Get-WmiObject -Class Win32_OperatingSystem} #Tutaj nie używamy zmiennej  $session ale nazwy sesji którą utworzyliśmy wcześniej "Backup Session"

$session | Remove-PSSession #niepotrzebną sesję usuwamy

Get-PSSession #Sprawdzamy czy pierwsza sesja została usunięta
Get-PSSession | Remove-PSSession #A tak usuwamy wszytskie sesje

Get-PSSession

dir WSMan:\localhost\Shell

Disconnect-PSSession -Session $session #Jeśli chcemy na chwilę przerwać sesję z komputerem zdalnym

Get-PSSession
Connect-PSSession -Session (Get-PSSession -ComputerName Wiki -State Disconnected) #Jeśli chcemy się połączyć ponownie a nie dysponujemy obiektem sesji to możemy się podłączyć jak w nawiasie
Get-PSSession

Enter-PSSession $session

#Po zakończeniu pracy Powershella aktualne sesje są automatycznie zamykane

<#Q&A#>
# 1 Jaki będzie wynik dodawania?
# Tak. W sesji zdalnej występuje tylko zmienna $y o wartości 3.

$x=10
$session=New-PSSession -Computer Cantor8
Enter-PSSession -session $session
$y=3
Exit-PSSession
$y=6
Enter-PSSession -session $session
$x+$y

#2 Jaki będzie wynik dodawania?
# Lokalnie zmienna X ma wartość 10, a zmienna y nie istnieje 
$x=10
$session=New-PSSession -Computer Cantor8
Enter-PSSession -session $session
$y=3
Exit-PSSession
$x+$y

#3 Nadawanie sesji nazwy pozwala na łatwiejsze zarządzanie sesją: wyszukiwanie, usuwanie, połączenia do sesji itp.
#Prawda

#4 Polecenie Disconnect-PSSession zamyka sesję i nie można już jej więcej używać. Kiedy chcesz dalej kontynuować pracę musisz utworzyć nową sesję.
#Nieprawda

#5 Polecenie Remove-PSSession
# Usunie wszystkie sesje otwarte i rozłączone

<#LAB#>
$sessionComp1 = New-PSSession -ComputerName localhost #Utwórz obiekt sesji $sessionComp1 wskazujący na localhost
$sessionComp2 = New-PSSession -ComputerName localhost #Utwórz obiekt sesji $sessionComp2 wskazujący na localhost
Get-PSSession #Wyświetl dostępne w tej chwili sesje

Invoke-Command -Session $sessionComp1 -ScriptBlock { $bitStatus=(Get-Service BITS).Status } #Korzystając z sesji do pierwszego komputera zapytaj o stan usługi bits i zapisz go w zdalnej zmiennej $bitStatus

$bitsStatusComp1 = (Invoke-Command -Session $sessionComp1 -ScriptBlock { $bitsStatus }).Value #Do lokalnej zmiennej $bitStatusComp1 wpisz wartość ze zmiennej z poprzedniego punktu (skorzystaj z właściwości Value zwracanej przez Invoke-Command)

Invoke-Command -Session $sessionComp2 -ScriptBlock { $wsearchStatus = (Get-Service WSearch).Status } #Korzystając z sesji do drugiego komputera zapytaj o stan usługi wsearch i zapisz go w zdalnej zmiennej $wsearchStatus

$wsearchStatusComp2 = (Invoke-Command -Session $sessionComp2 -ScriptBlock { $wsearchStatus }).Value #Do lokalnej zmiennej $wsearchStatusComp2 wpisz wartość ze zmiennej z poprzedniego punktu (skorzystaj z właściwości Value zwracanej przez Invoke-Command)

<#Jeśli jednocześnie są spełnione warunki:
        a. Usługa bits była w statusie ‘stopped’
        b. Usługa wsearch była w statusie ‘running’
Wykonaj następujące czynności:
        c. Uruchom usługę bits w sesji numer 1
        d. Zatrzymaj usługę wsearch w sesji numer 2 #>

if( $bitsStatusComp1 -eq 'Stopped' -and $wsearchStatusComp2 -eq 'Running' )
{
    Invoke-Command -Session $sessionComp1 -ScriptBlock { Start-Service bits }
    Invoke-Command -Session $sessionComp2 -ScriptBlock { Stop-Service wsearch }
}

Get-PSSession | Remove-PSSession #Usuń wszystkie sesje.