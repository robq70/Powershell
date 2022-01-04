Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC <#Sprawdzamy wersję systemu na komputerach ale pierwszy jest wyłączony lub jest inna przyczyna i wyskakuje błąd#>
Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC -ErrorAction Stop <#W tym przypadku po wystąpieniu błędu Powershell zatrzymuje polecenie i nie kontynuuje dalej po błędzie#>
Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC -ErrorAction SilentlyContinue <#Jeśli nie udało się wykonać jakiejś czynności to nie pokazuj tego i kontynuuj dalej#>
Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC -ErrorAction Inquire <#Wyświetla dodatkowy komunikat i pyta czy dalej kontynuować czy zatrzymać#>
Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC -ErrorAction Ignore <#Wystąpienie błędu zostanie zignorowane i nie zostanie wyświetlone#>
Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC -ErrorAction Continue <#Pokazuje komunikat o błedzie ale polecenie będzie dalej kontynuowane#>

$ErrorActionPreference <#Jest to zmienna która domyślnie jest ustawina na Continue#>
$ErrorActionPreference='Stop' <#Zmieniamy tę wartość na STOP. Będzie teraz ustawione domyślnie dla wszystkich które nie mają ustanowionego polecenia ErrorAction#>
$ErrorActionPreference <#Wartość teraz wynosi Stop#>

Get-WmiObject -Class Win32_operatingSystem -ComputerName Domowy1,DESKTOP-I4DSEJC <#Teraz to samo polecenie zatrzymuje się po pierwszym błędzie ponieważ zmienna została zmieniona na STOP#>

$ErrorActionPreference <##>
$ErrorActionPreference='Continue' <#Zmień wartość globalnej zmiennej ErrorActionPreference na Continue#>

<#LAB#>
$bits = Get-WmiObject -class win32_service -filter "name='bits'" <#Do zmiennej bits pobierz za pomocą Get-WmiObject usługę bits#>
$bits.StartMode <#Sprawdź aktualny status usługi#>
$bits.ChangeStartMode('Disabled') <#Korzystając z metody ChangeStartMode zmień tryb uruchomienia na Disabled#>
Stop-Service bits <#Zatrzymaj usługi bits#>
Stop-Service winrm <#Zatrzymaj usługi winrm#>
Get-Service -Name BITS,WinRM  <#Sprawdź czy usługi są rzeczywiście zatrzymane#>
$ErrorActionPreference <# sprawdź wartość zmiennej powinna wynosić Continue #>
Start-Service -Name BITS,WinRM <#Wpisz polecenia uruchamiające bits i winrm i uruchom je jednocześnie. Przy uruchamianiu usługi bits powinien pojawić się błąd#>
Get-Service -Name BITS,WinRM <#Sprawdź status usług bits i winrm. Czy winrm działa? Dlaczego? #>
$ErrorActionPreference='Stop'      <#Zmień wartość globalnej zmiennej ErrorActionPreference na Stop#>
Stop-Service bits <#Zatrzymaj usługi bits#>
Stop-Service winrm <#Zatrzymaj usługi winrm#>
Get-Service -Name BITS,WinRM <#Sprawdź status usług bits i winrm.#>
Start-Service -Name BITS,WinRM <#Wpisz polecenia uruchamiające bits i winrm i uruchom je jednocześnie. Przy uruchamianiu usługi bits powinien pojawić się błąd#>
Get-Service -Name BITS,WinRM <#Sprawdź status usług bits i winrm. Czy winrm działa? Dlaczego?#>
Start-Service -Name BITS,WinRM -ErrorAction SilentlyContinue <#Zmień polecenie uruchamiające usługi tak aby niezależnie od wartości globalnej zmiennej ErrorActionPreference, jeśli dochodzi do błędu kolejne polecenia były wykonywane bez zgłaszania komunikatów o błędzie.#>
Get-Service -Name BITS,WinRM <#Sprawdź status usług bits i winrm. Czy winrm działa? Dlaczego?#>
$bits.ChangeStartMode('Manual') <#Przywróć początkowe ustawienia trybu uruchomienia usługi bits Manual#>
