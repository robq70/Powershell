[int]$number=100 <#Przpisujemy typ int do zmiennej i nadajemy jej wartość 100#>
$number <#wyświetlamy#>
$number="twenty" <#nie można przypisać do int tekstu#>

[datetime]$date="2021-09-29" <#Przpisujemy typ datetime do zmiennej i nadajemy jej wartość#>
$date <#Power shell wyświetli po swojemu całość - środa, 29 września 2021 00:00:00#>
$date.AddDays(20) <#sprawdzamy datę za 20 dni#>
$date.AddDays(20).DayOfWeek <#sprawdzamy dzień tygodnia#>
$date.AddDays(-13) <#sprawdzamy datę 13 dni temu#>

[Boolean]$bool=$true <#Przpisujemy typ Boolean do zmiennej i nadajemy jej wartość#>
$bool <#Wyświetli True#>
$bool="False" <#Wyświetli błąd - możemy przypisać do typu Boolean tylko $true, $false lub 0, 1 #>
$bool=0 <#zmieniamy na 0#>
$bool <#Wyświetli False#>

[string]$s="Hello" <#Przpisujemy typ string do zmiennej i nadajemy jej wartość#>
$s <#Wyświetlamy#>
$s.Contains("He") <#Sprawdzamy czy w zmiennej występuje ciąg znaków#>
$s.IndexOf("l") <#Sprawdzamy w zmiennej w którym miejscu występuje litera l - powershell liczy od 0 #>
$s="one,two,three,four,five" <#Przpisujemy do zmiennej wartość#>
$s.Split(",") <#Tworzymy tablicę poniewż zmienna typu string ma metodę split, metoda otrzymuje informację co jest znakiem rozdzielającym#>
$s -is [String] <#Sprawdzamy czy zmienna jest typu string tutaj prawda#>
$s -is [int] <#Tutaj fałsz $s nie jest int#>
$s=10 <#Przpisujemy jej nową wartość#>
$s
$s -is [String] <#Jest to dalej string#>
$s -is [int]  <#Tutaj fałsz $s dalej jest string#>
$number=$s <#Jeśli coś jest string ale jest liczbą to można to przypisać do zmiennej int#>
$number <#pokazuje wartość 10#>
$number+$s <#Pomimo że $s to string to powershell sprawdza że jest to jednak liczba i wykonuje dodawanie#>
$s="ten" <#Przpisujemy jej nową wartość#>
$number+$s <#Teraz powershell nie jest w stanie skonwertować ciągu znaków "ten" na cyfrę i wyskakuje błąd#>

<#A&Q#>

<#Na komputerze z polskimi ustawieniami lokalnymi zadeklarowano zmienną#>
[datetime]$start = '2015/09/04'
$start <#Wartość to piątek, 4 września 2015 00:00:00#>

<#Co będzie wynikiem następującego polecenia#>
[datetime]$start = '2015-10-13'
$start.AddDays(7).AddMonths(3).AddDays(-5).ToString("yyMMdd") <#160115#>

<#Co będzie wynikiem następujących poleceń:#>
[string]$s = '2015-05-30'
[string]$s = '2015-05-30'
[datetime]$d = $s
$d -is [datetime] <#Będzie True#>

<#Przeanalizuj poniższy kod. Jaki będzie wynik polecenia?#>
$s1 = '2015'
$s2 = '03'
$s3 = '13'
[datetime]$v = $s1+'-'+$s2+'-'+$s3
$v <#piątek, 13 marca 2015 00:00:00 ponieważ $v jest typu datestring#>

<#LAB#>

[string]$LogFile = 'C:\' <#utworzenie zmiennej, która może dalej posłużyć jako nazwa pliku identyfikujaca kiedy plik powstał#>
(Get-Date).ToString("yyyy_MM_dd") <#Korzystając z literałów YYYY_MM_DD oraz metody ToString typu DateTime wyświetl aktualna datę w postaci odpowiednio sformatowanego napisu#>

[string]$LogFile = (Get-Date).ToString("yyyy_MM_dd") <#Zainicjuj zmienną $LogFile wartością bieżącej daty – czyli połącz to co zostało zrobione wcześniej#>
[string]$LogFile = (Get-Date).ToString("yyyy_MM_dd"+","+"HH") <#Dodatkowo wyświetl godzinę#>
$LogFile

<#Twoim zadaniem jest zmierzenie czasu, przez który będzie pracować pewna aplikacja (u nas notepad). Zadeklaruj zmienne typu Datetime#>
[Datetime]$StartTime = Get-Date <#Przypisz do zmiennej bieżący czas#>
[Datetime]$StopTime = Get-Date <#Przypisz do zmiennej bieżący czas#>

Start-Process -FilePath "notepad.exe"  -Wait <#uruchom notatnik#>

$StopTime = Get-Date <#Przypisz do Zmiennej bieżący czas#>
[TimeSpan]$TimeSpent = $StopTime.Subtract($StartTime) <#Zadeklaruj zmienną $TimeSpent typu TimeSpan i przypisz jej różnicę między StopTime a $StartTime. Użyj metody Subtract wywoływanej na rzecz $StopTime, która wyznaczy poszukiwaną różnicę#>
$TimeSpent.TotalSeconds <#Wyświetl wyznaczoną różnicę w sekundach#>