$EmailFrom= "robq70@hotmail.com" <#Od#>
$EmailTo= "robq70@gmail.com" <#Do#>
$Subject= "Test email from PowerShell" <#Tytuł#>
$Body = "Sorry - only a test" <#Treść#>
$SMTPServer = "outlook.office365.com" <#serwer smtp#>
$SMTPClient= New-Object Net.Mail.SmtpClient($SMTPServer, 993) <#Obiekt .net - Net.Mail.SmtpClient, który jest serwerem poczty na porcie 587 #>
$SMTPClient.EnableSsl = $true <#włączenie ssl#>
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("robq70", "Tr@kt0rek06"); <#obiekt który umożliwi uwierzytelnienie wskazujemy nazwę użytkownika i jego hasło#>
$SMTPClient.Send($EmailFrom,$EmailTo,$Subject,$Body)  <#Wysyłamy maila na podstawie utworzonych zmiennych#>

<#Skrypt początek#>


<#
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

#>

<#92 Skrypty i funkcje#>

[CmdletBinding()] <# Powershell zastosuje automatycznie pewne mechanizmy zabezpieczające. Nie można np. przekazywać parametru który nie jest przyjmowany #>

Param( <#Param - Powershell wie jakich parametrów oczekuje nasz skrypt#>
[Parameter(Mandatory=$true)]  <#Oznacza to że poniższy parametr jest niezbędny do uruchomienia skryptu#>
[string]$EmailTo, <#Do#>
[string]$Subject= "IT Department Information",
[Parameter(Mandatory=$true)] <#Oznacza to że poniższy parametr jest niezbędny do uruchomienia skryptu#>
[string]$Body <#Zawartość wiadomości musi być#>
)

$EmailFrom= "robq70@hotmail.com" <#Od#>

$SMTPServer = "outlook.office365.com" <#serwer smtp#>
Write-Verbose "Creating SMTP Client..." <#Write-Verbose uruchomi się tylko jeśli plik wywołamy z parametrem -Verbose#>
$SMTPClient= New-Object Net.Mail.SmtpClient($SMTPServer, 993) <#Obiekt .net - Net.Mail.SmtpClient, który jest serwerem poczty na porcie 587 #>
$SMTPClient.EnableSsl = $true <#włączenie ssl#>
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("robq70", "Tr@kt0rek06"); <#obiekt który umożliwi uwierzytelnienie wskazujemy nazwę użytkownika i jego hasło#>
Write-Verbose "Sending email..."
$SMTPClient.Send($EmailFrom,$EmailTo,$Subject,$Body)  <#Wysyłamy maila na podstawie utworzonych zmiennych#>
Write-Verbose "Email sent."

<#Koniec skryptu#>


<#Początek skryptu - jako funkcja#>

function Send-EmailFromGmail {

[CmdletBinding()] <# Powershell zastosuje automatycznie pewne mechanizmy zabezpieczające. Nie można np. przekazywać parametru który nie jest przyjmowany #>

Param( <#Param - Powershell wie jakich parametrów oczekuje nasz skrypt#>
[Parameter(Mandatory=$true)]  <#Oznacza to że poniższy parametr jest niezbędny do uruchomienia skryptu#>
[string]$EmailTo, <#Do#>
[string]$Subject= "IT Department Information",
[Parameter(Mandatory=$true)] <#Oznacza to że poniższy parametr jest niezbędny do uruchomienia skryptu#>
[string]$Body <#Zawartość wiadomości musi być#>
)

$EmailFrom= "robq70@hotmail.com" <#Od#>

$SMTPServer = "outlook.office365.com" <#serwer smtp#>
Write-Verbose "Creating SMTP Client..."
$SMTPClient= New-Object Net.Mail.SmtpClient($SMTPServer, 993) <#Obiekt .net - Net.Mail.SmtpClient, który jest serwerem poczty na porcie 587 #>
$SMTPClient.EnableSsl = $true <#włączenie ssl#>
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential("robq70", "Tr@kt0rek06"); <#obiekt który umożliwi uwierzytelnienie wskazujemy nazwę użytkownika i jego hasło#>
Write-Verbose "Sending email..."
$SMTPClient.Send($EmailFrom,$EmailTo,$Subject,$Body)  <#Wysyłamy maila na podstawie utworzonych zmiennych#>
Write-Verbose "Email sent."
}

<#Koniec skryptu#>

Send-EmailFromGmail -EmailTo 'robq70@gmail.com' -Subject 'Temat' -Body 'Jakaś treść'

<#Moduły#>

Import-Module sqlps <#Wymagany zainstalowany serwer SQL. Po wywołaniu utworzy się wirtualny napęd SQLSERVER#>
c:
Remove-Module sqlps <#Aby go usunąć najpierw trzeba zmienić napęd jak powyżej na C: i dopiero wywołać polecenie#>

<#aby sprawdzić ścieżki dostepu do modułów cmd>echo %PSModulePath%
Można tworzyć własne moduły ale we wałasnym folderze C:\Users\robq7\Documents\WindowsPowerShell\Modules\
gdzie tworzymy folder z nazwą nodułu MyFunctions a w środku powinien znajdować się plik o tej samej nazwie myFunctions.psm1 #>


<#A&Q#>

<#Definiujesz funkcję Get-ServiceStatus, która ma za zadanie wyświetlać informacje o stanie wybranych usług. 
Jakim słowem rozpoczniesz definicję tej funkcji
Function Get-ServiceStatus#>

<#Debuggujesz funkcję. Używasz Write-Verbose aby wyświetlać informacje o kolejnych krokach wykonywanych w funkcji. 
Niestety podczas wywołania funkcji komunikaty nie pojawiają się. Czym może to być spowodowane
Należy uruchomić funkcję z parametrem -Verbose#>

<#Przygotowujesz funkcję. Chcesz aby funkcja „samodzielnie” kontrolowała potencjalne literówki, 
jakie użytkownicy mogą zrobić wywołując ją z parametrami. Chcesz aby funkcja obsługiwała tzw 
Common Parameters jak –Verbose czy –Debug.
Wystarczy dodać dyrektywę CmdletBinding#>

<#Masz plik memory.ps1 zawierający między innymi funkcję Release-Memory. Plik znajduje się w 
katalogu bieżącym. Chcesz wczytać plik i uruchomić funkcję.
../memory Release-Memory#>


<#LAB#>
<#Do katalogu c:\temp wgraj kilka plików o różnych datach modyfikacji.#>
Get-ChildItem D:\temp -Recurse -File | Where-Object{$_.LastWriteTime -lt '2021-06-20'} <#Przygotuj polecenie, które wyświetli pliki starsze niż zobacz datę#>

<#finalnie tworzymy funkcję któą zapisujemy jako plik modułu utilities.psm1#>
function Get-FilesOlderThan
{
    [CmdletBinding()]
    Param(
    [Parameter(mandatory=$true)]
    [DateTime]$OlderThan = (Get-Date).AddDays(-1),
    [Parameter(mandatory=$true)]
    [string]$BaseFolder
    )
    Get-ChildItem $BaseFolder -Recurse -File | Where-Object { $_.LastWriteTime -lt $OlderThan }
}

<#W nowym oknie powershell wywołujemy moduł w następujący sposób:

Import-Module c:\scripts\utilities.psm1

Get-FilesOlderThan -OlderThan '2021-06-01' -BaseFolder 'd:\temp' 
#>