#Jak uruchamiać zadania w tle
#Jak odczytywać wyniki tych zadań
#Jak sprawdzać status zadań uruchomionych w tle
#Jak planować zadania do uruchomienia w przyszłości lub regularnie
#Jak zarządzać zadaniami zaplanowanymi
Start-Job -ScriptBlock {Get-Process} -Name "Obecnie uruchomione procesy" #Uruchamia zadanie w tle pokazując od razu parametry uruchomionego zadania
Get-Job #Sprwdzamy status zadania

Get-WmiObject -Class Win32_OperatingSystem -ComputerName Domowy -AsJob #Tak jak wyżej tylko typ zadania to WmiJob uruchamiamy z parametrem -AsJob
Get-Job #Sprwdzamy status zadania

Invoke-Command -ComputerName Domowy {Get-Process} -AsJob #Zdalne sesje uruchamiamy również z parametrem -AsJob a typ zadania to RemoteJob. Kilka zdalnych sesji może trwać dłużej.
Get-Job #Sprwdzamy status zadania

Invoke-Command -ComputerName Wiki {Get-Process} -AsJob #Zdalne sesja jak wyżej
Get-Job #Sprwdzamy status zadania

Get-Job -Id 1 #Sprwdzamy status zadania nr 1
Get-Job -Name "Obecnie uruchomione procesy" #Sprwdzamy status zadania o nazwie ""
Get-Job -HasMoreData $true #Sprwdzamy status zadania gdzie -HasMoreData zwrócił $true

Start-Job -ScriptBlock {while ($true){} } -Name loop #Uruchamiamy zadanie które nigdy się nie skończy i nazywamy loop
Get-Job #Sprwdzamy status zadania
Stop-Job -Name loop #Zatrzymuje zadanie stopped ale go nie usuwa z listy
Remove-Job -Name loop #Usuwa zadanie z listy

Receive-Job -Name 'Obecnie uruchomione procesy' #Odczytywanie wyników zadań w tym wypadku Get-Process
#Za drugim razem wywołanie polecenia się nie uda ponieważ wyniki są od razu usuwane

Receive-Job -Id 1 -Keep #Parametr -keep pozwala nam na zachowanie wyniku w pamięci i  wywołanie go ponownie
Get-Job | Remove-Job # Usuwa wszytskie zadania


<#Przykładowe zadania
Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
--     ----            -------------   -----         -----------     --------             -------
1      Obecnie uruc... BackgroundJob   Completed     True            localhost            Get-Process
3      Job3            WmiJob          Completed     True            Domowy               Get-WmiObject -Class W...
5      Job5            RemoteJob       Failed        False           Domowy               Get-Process
7      Job7            RemoteJob       Failed        False           Wiki                 Get-Process
#>

#Zaplanowanie zadań do wykonania na później
$optHide = New-ScheduledJobOption -WakeToRun -HideInTaskScheduler #Tworzymy opcję, którą zapamietujemy w zmiennej, komputer ma sie wybudzić, zadanie nie ma być pokazywane w harmonogramie zadań (w harmonogramie można zaznaczyc aby pokazywał ukryte zadania)
$optElev = New-ScheduledJobOption -RequireNetwork -RunElevated #Tworzymy opcję, którą zapamietujemy w zmiennej, wymagamny jest dostęp do sieci, zadanie ma być uruchomione  podniesionymi uprawnieniamu administratora
$optHide #Sprawdzamy zawarość zmiennej
$optElev #Sprawdzamy zawarość zmiennej

$trigWeek = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday,Wednesday,Friday -At 3am -RandomDelay 00:20 #Musimy skonfigurować również wyzwalacz który uruchomi nasze zadanie, który zachowujemy w zmiennej /co tydzień w określone dni tygodnia o 3:00 z losowym opóxnieniem 20 minut/
$trigLater = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(3) ##Musimy skonfigurować również wyzwalacz który uruchomi nasze zadanie, który zachowujemy w zmiennej, uruchomi się raz za 3 minuty
$trigWeek #Sprawdzamy zawarość zmiennej
$trigLater #Sprawdzamy zawarość zmiennej

Register-ScheduledJob -ScriptBlock { Get-WmiObject -Class Win32_OperatingSystem | select FreePhysicalMemory } -Trigger $trigWeek -ScheduledJobOption $optElev -Name "Raport o uzyciu pamieci" #Zadanie rejestrujemy tą komendą która sprwdzi nam 3x w tygodniu dostępną pamięć
Get-Job #Daje tylko informację o aktualnych zadaniach w tle a nie zaplanowanych
Get-ScheduledJob #To pokazuje zaplanowane zadania
Register-ScheduledJob -ScriptBlock {Get-Process} -Trigger $trigLater -ScheduledJobOption $optHide -Name "Proces po 3 minutach" #Tego typu zadania można znaleźć w harmonogramoie Windows Task Scheduler
Get-ScheduledJob #To pokazuje zaplanowane zadania
#Zaplanowane zadania możemy też znaleźć w folderze C:\Users\robq70\AppData\Local\Microsoft\Windows\PowerShell
Get-Job #Jeśli zadanie się wykona 
Unregister-ScheduledTask -TaskName "Raport o uzyciu pamieci" #Pozbywanie się zadania z harmonogramu
Unregister-ScheduledTask -TaskName "Proces po 3 minutach" #Pozbywanie się zadania z harmonogramu
Get-Job
Receive-Job -Id 1 -Keep #Odczytanie wyników zadania z Id 3 oraz pozostawienie go aby odczytać go później

<#Q&A#>
#1 Chcesz zaplanować restart komputera na dziś na godzinę 23: 30 Które polecenie zrealizuje ten zamiar

$trigg = New-ScheduledTaskTrigger -Once -At ([DateTime]::Today.AddHours(23)) 
Register-ScheduledJob -ScriptBlock {Restart-Computer} -Trigger $trigg -Name "Restart komputera na żadanie"

#2Przypadkowo uruchomiłeś w tle zadanie, które będzie bardzo długo trwało. Jaka komenda zatrzyma to zadanie?
Stop-Job

#3Zadanie ma uruchamiać usługę, a do tego są potrzebne wysokie uprawnienia administratora. Które polecenie powoli określić, że zadanie uruchomi się z podniesionymi uprawnieniem
$option = New-ScheduledJobOption -RunElevated
Register-ScheduledJob -FilePath C:\temp\startservice.ps1 -ScheduledJobOption $option -Name "StartService"

#4Chcesz odczytać wynik zadania tak, aby odczyt wyników był możliwy do powtórzenia. Jakiej opcji należy użyć?
#Keep

#5Które z poniższych poleceń NIE będzie uruchomione w tle
Invoke-Command -ScriptBlock { Get-Service BITS } -ComputerName Domowy,Wiki

<#LAB#>

Start-Job -ScriptBlock {Get-WmiObject -Class Win32_LogicalDisk | out-File c:\temp\disks.txt -Append } #Chcesz w tle wykonać (długotrwałe) zadanie. Przygotuj polecenie, które z wykorzystaniem Start-Job:
                                                                                                      #a. Pobierze obiekt win32_LogicalDisk
                                                                                                      #b. Zapisze wynik  w pliku c:\temp\disks.txt

Get-WmiObject -Class Win32_Processor -AsJob #Przygotuj polecenie, które w tle uruchomi polecenie pobierające i=obiekt WMI odpowiedzialny za procesor. Skorzystaj przy tym wyłącznie z polecenia Get-WMIObject i jego opcji.

Invoke-Command -ComputerName $env:COMPUTERNAME -ScriptBlock {Get-Service} -AsJob #Przygotuj polecenie, które na komputerze zdalnym uruchomi Get-Service. Skorzystaj przy tym z polecenie Invoke-Command i jego opcji. 

Get-Job #Wyświetl listę jobów uruchamianych w tle

Receive-Job -Id 10 -Keep # Pobierz wynik job-a zdefiniowanego w kroku (2) tak aby wynik można było odczytywać jeszcze kolejny raz

Get-Job | Receive-Job #Pobierz wynik wszystkich jobów. Zrób to w jednym poleceniu

Get-Job | Remove-Job #Usuń jednym poleceniem wszystkie joby

$trigDaily = New-JobTrigger -Daily -At 2pm #Przygotuj trigger do uruchomienia zadania zaplanowanego o godzinie 14:00 codziennie (możesz dopasować godzinę do np. za 10 minut od teraz)

Register-ScheduledJob -ScriptBlock { Get-WmiObject -Class Win32_LogicalDisk >> c:\temp\logicaldisks.txt } -Trigger $trigDaily -Name "Dyski logiczne" # Zarejestruj planowane zadanie, które zostanie wyzwolone triggerem z poprzedniego punktu, które pobierze informacje o dyskach logicznych i zapisze je w pliku w c:\ temp

Get-ScheduledJob #Wyświetl listę zdefiniowanych zadań

Get-ScheduledJob | Unregister-ScheduledJob #Poczekaj aż zadanie się wykonana a potem wyrejestruj je