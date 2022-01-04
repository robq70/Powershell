#Działanie parametrów domyślnych
#Konfigurowanie środowiska użytkownika
#Plik profile użytkownika
#Plik profile dla komputera lokalnego

Get-WmiObject -Class Win32_OperatingSystem -ComputerName Domowy #Podaje wersje systemu operacyjnego
Get-WmiObject #Samo wywołanie nie poda nma nic oprócz pytań o klasę itp.
$PSDefaultParameterValues.Add("Get-WmiObject:Class","Win32_OperatingSystem") #Możemy sobie sami zdefiniować co ma nam pokazywać Get-WmiObject w danej sesji
$PSDefaultParameterValues.Add("Get-WmiObject:ComputerName","Domowy") #definiując parametr $PSDefaultParameterValues

Get-WmiObject #teraz zostaną nam wyświetlone dane zgodnie z wcześniej określonymi parametrami
Get-WmiObject -Class Win32_LogicalDisk -ComputerName Domowy #Jeśli chcemy coś innego określamy wtedy parametry
Get-WmiObject -Class Win32_LogicalDisk

$PSDefaultParameterValues #Pokazuje nam aktualne dla sesji parametry wywołania

$PSDefaultParameterValues.Remove("Get-WmiObject:Class") #Usuwamy wcześniej skonfigurowane parametry
$PSDefaultParameterValues.Remove("Get-WmiObject:ComputerName")

$PSDefaultParameterValues #Teraz parametr nie pokazuje nic

#Aby nie utracić parametrów i za każdym razem je mieć możemy w katalogu C:\Users\robq7\Documents\WindowsPowerShell\ stworzyć plik profile.ps1 w którym określamy co chcemy wywołać automatycznie na czas sesji
#Np. powitanie: echo "Cześć dzisiaj jest $(Get-Date). Pracujesz jako $([Environment]::UserName)." 

<#Q&A#>
#1 Chcesz załadować moduł funkcji poweshell pozwalających na pracę z SQL korzystając z Import-Module sqlps. Ponieważ często korzystasz z tego modułu chcesz, aby po uruchomieniu powershella moduł ten był dla ciebie już zawsze załadowany. Gdzie wprowadzisz tę komendę
#W pliku profile użytkownika

#2 Gdzie znajduje się plik profile użytkownika
#C:\Users\Username\Documents\WindowsPowerShell\profile.ps1

#3 Aby plik profile został uruchomiony Execution Policy musi być odpowiednio skonfigurowane
#Tak - profile to skrypt i podlega tym samym zasadom bezpieczeństwa co wszystkie inne sjkrypty.

#4 Dodając parametry domyślne używasz metody Add przekazując dwa parametry. Pierwszy określa o jaki parametr chodzi, a drugi to wartość tego parametru. Wybierz poprawną składnie dla polecenia Get-WMIObject i parametru class:
# $PSDefaultParameterValues.Add("Get-WmiObject:Class","Win32_Service")

#5$PSDefaultParameterValues to kolekcja elementów

<#LAB#>
$PSDefaultParameterValues.Add("Get-Service:Name","wsearch") #Dodaj odpowiedni parametr domyślny:
                                                            # a. Polecenie: Get-Service
                                                            # b. Parametr: Name
                                                            # c. Wartość: wsearch
Get-Service #Przetestuj działanie polecenia Get-Service bez dodatkowych parametrów
New-Item -ItemType Directory C:\Users\robq7\Documents\WindowsPowerShell #Utwórz (z poziomu powershell) katalog lub - New-Item -Path (Join-path $env:USERPROFILE "Documents\WindowsPowerShell") -ItemType Container
New-Item -ItemType File C:\Users\robq7\Documents\WindowsPowerShell\profile.ps1 #Utwórz (z poziomu powershell) plik lub - New-item -Path (Join-path $env:USERPROFILE "Documents\WindowsPowerShell\profile.ps1") -ItemType File
notepad.exe C:\Users\robq7\Documents\WindowsPowerShell\profile.ps1 #Wyedytuj (np. w notatniku) ten plik
#Umieść w nim (poniższe polecenia należy oczywiście testować najpierw w powershell
echo "Witaj $env:username"
echo "Pracujesz na stacji $env:computername"
echo "Napęd TEMP: wskazuje na D:\temp"
New-PSDrive -Name TEMP -Root 'D:\temp' -PSProvider FileSystem

Get-ExecutionPolicy #Upewnij się, że execution policy pozwala na uruchamianie skryptów
Set-ExecutionPolicy RemoteSigned #Jeśli nie to zmień execution policy na RemoteSigned