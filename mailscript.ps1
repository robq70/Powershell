#
.SYNOPSIS
Wysyłanie maila via jakiś adres smtp
.DESCRIPTION
Wyślij email poprzez podanie adresata, tytułu wiadomości oraz zawartości.
Wiadomość będzie wysłana poprzez zadeklarowene konto email
.PARAMETER EmailTo
Wpisz email do którego chcesz przesłać wiadomość - obowiązkowe
.PARAMETER Subject
Wpisz tytuł wiadomości. Nie jest on niezbędny do podania bo posiada wartość którą przyjmie jeśli użytkownik jej nie poda
.PARAMETER Body
Wpisz zawartość wiadomości email - obowiązkowe
.EXAMPLE
.\mailscript.ps1 -EmailTo mail@wp.pl -Subject "Greetings" -Body "Best regards" -Verbose



#92 Skrypty i funkcje

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