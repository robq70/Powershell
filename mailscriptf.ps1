#
.SYNOPSIS
Wysyłanie maila via jakiś adres smtp
.DESCRIPTION
Wyślij email poprzez podanie adresata, tytułu wiadomości oraz zawartości.
Wiadomość będzie wysłana poprzez zadeklarowene konto email
. D:\Script\mailscript.ps1 - wywołanie w ten sposób skryptu kropka plus ścieżka wczytuje go do pamięci Powershell w bieżącej sesji

.PARAMETER EmailTo
Wpisz email do którego chcesz przesłać wiadomość - obowiązkowe
.PARAMETER Subject
Wpisz tytuł wiadomości. Nie jest on niezbędny do podania bo posiada wartość którą przyjmie jeśli użytkownik jej nie poda
.PARAMETER Body
Wpisz zawartość wiadomości email - obowiązkowe
.EXAMPLE
    Send-EmailFromGmail -EmailTo mail@wp.pl -Subject "Greetings" -Body "Best regards" -Verbose



#92 Skrypty i funkcje

function Send-EmailFromGmail { #Jako funkcja dodajemy funkction jej nazwę najlepiej w konwencji nazewniczej verb-noun nawias klamrowy i zamykamy wszystko też nawiasem

[CmdletBinding()] # Powershell zastosuje automatycznie pewne mechanizmy zabezpieczające. Nie można np. przekazywać parametru który nie jest przyjmowany 

Param( #Param - Powershell wie jakich parametrów oczekuje nasz skrypt
[Parameter(Mandatory=$true)]  #Oznacza to że poniższy parametr jest niezbędny do uruchomienia skryptu
[string]$EmailTo, #Do
[string]$Subject= "IT Department Information",
[Parameter(Mandatory=$true)] #Oznacza to że poniższy parametr jest niezbędny do uruchomienia skryptu
[string]$Body #Zawartość wiadomości musi być
)

$EmailFrom= "robq70@hotmail.com" #Od

$SMTPServer = "outlook.office365.com" #serwer smtp
Write-Verbose "Creating SMTP Client..."
$SMTPClient= New-Object Net.Mail.SmtpClient($SMTPServer, 993) #Obiekt .net - Net.Mail.SmtpClient, który jest serwerem poczty na porcie 587 
$SMTPClient.EnableSsl = $true #włączenie ssl
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("robq70", "Tr@kt0rek06"); #obiekt który umożliwi uwierzytelnienie wskazujemy nazwę użytkownika i jego hasło
Write-Verbose "Sending email..."
$SMTPClient.Send($EmailFrom,$EmailTo,$Subject,$Body)  #Wysyłamy maila na podstawie utworzonych zmiennych
Write-Verbose "Email sent."
}


#Moduły

Import-Module sqlps #Wymagany zainstalowany serwer SQL. Po wywołaniu utworzy się wirtualny napęd SQLSERVER
c:
Remove-Module sqlps #Aby go usunąć najpierw trzeba zmienić napęd jak powyżej na C: i dopiero wywołać polecenie

#aby sprawdzić ścieżki dostepu do modułów cmd>echo %PSModulePath%
Można tworzyć własne moduły ale we wałasnym folderze C:\Users\robq7\Documents\WindowsPowerShell\Modules\
gdzie tworzymy folder z nazwą nodułu MyFunctions a w środku powinien znajdować się plik o tej samej nazwie myFunctions.psm1 