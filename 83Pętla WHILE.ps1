$i=0 <#Przypisujemy zmiennej wartość 0#>
while($i -lt 10) <#Warunek - dopóki $i jest mniejsze niż 10 wykonuj pętlę#>
{
    $i++ <#Zwiększ $i o 1#>
    Write-Host "$i" <#Wyświetl obecną wartość $i#>
}


<#Kolejny brdziej skomplikowany przykład#>
$i=0 <#Przypisujemy zmiennej wartość 0#>
while($i -lt 10) <#Warunek - dopóki $i jest mniejsze niż 10 wykonuj pętlę#>
{
    $i++ <#Zwiększ $i o 1#><##>
    if($i%2 -eq 0) <#Wyświetl obecną wartość tylko jeżeli $i%2 (i modulo 2) jest podzielne przez 2#>
    {
        Write-Host "$i is even" <#Wyświetl wynik $i jest parzyste#>
    }
    Else <#W przeciwnym przypadku#>
    {
        Write-Host "$i is odd" <#Wyświetl $i jest nieparzysta#>
    }
}



<#Kolejny jeszcze inny przykład#>
$i=0 <#Przypisujemy zmiennej wartość 0#>
while($i -lt 100) <#Warunek - dopóki $i jest mniejsze niż 100 wykonuj pętlę#>
{
    $i++ <#Zwiększ $i o 1#><##>
    if($i%2 -eq 0) <#Wyświetl obecną wartość tylko jeżeli $i%2 (i modulo 2) jest podzielne przez 2#>
    {
        Write-Host "$i is even" <#Wyświetl wynik $i jest parzyste#>
    }
    Else
    {
        Write-Host "$i is odd" <#Wyświetl $i jest nieparzysta#>
    }
    If($i -eq 10) <#Warunek - jeżeli $i jest równe 10#>
    {
        Write-Host "We have reached '10', so I'm breaking the loop" <#Wyświetl napis że osiągnięto 10 i pętla będzie przerwana#>
        Break <#Polecenie to przerywa natychmiast wykonywanie pętli#>
    }
    }


<#A&Q#>
<#Załóżmy, że komputer został właśnie zresetowany po czym uruchomiono w/w kod. Jaki będzie efekt działania kodu?#>
$comp = "cantor8"

while ( -not (Test-Connection -ComputerName $comp -Count 1 -Quiet)) <# Pętla będzie wykonywana co 10 s#>

{

Write-Warning "$comp is not reachable" <#Będzie wyświetlany napis#>

Start-Sleep -Seconds 10 <#10 s#>

}

<#1. Dopóty dopóki komputer nie odpowie na pin i wyświetli napis z datą odpowiedzi.#>
<#2. Jeśli komputer będzie od razu dostępny to info o nieosiągalności nie wyświetli się wcale#>
<#3. Gdy komputera nie ma, to warunek pętli zawsze będzie $true, więc pętla nigdy się nie skończy#>

Write-Host "$comp reachable at $(Get-Date)" 


<#Pętla będzie działać w nieskończoność (nie dodano $i++) i pingować komputer z adresem 1#>
$i=1

while($i -lt 10)

{

if (Test-Connection -ComputerName "192.168.100.$i" -Quiet -Count 1)

{

Write-Host "$i is available"

}

else

{

Write-Host "$i is not responding"

}

}

<#LAB#>

$i = 0 <#Zadeklaruj zmienne $i#>
$max = 30 <#Zadeklaruj zmienne $max#>
$sourceFileName = 'D:\script\master.txt' <#Zadeklaruj zmienną $sourceFileName#>
"This is a master configuration file" | Out-File $sourceFileName <#Umieść w pliku wskazywanym przez $sourceFileName napis#>
$destinationFolder = 'D:\script\distibution' <#Zadeklaruj zmienną $destinationFolder#>

if( -not (Test-Path $destinationFolder)) <#wyrażenie IF, które sprawdza istnienie katalogu wskazywanego przez $destinationFolder#>

{
    New-Item -Path $destinationFolder -ItemType Directory <# i jeśli nie ma takiego folderu to go tworzy#>
}
    while($i -lt $max) <#pętla będzie wykonywana tak długo póki $i jest mniejsze od $max#>
{    
    $i+=1 <#instrukcję zwiększającą $i o 1#>
    $destinationFile =  "$i.txt" <#Zadeklaruj zmienną $destinationFile i zainicjuj ją wartością w postaci $i.txt#>
    $newFileName = Join-Path $destinationFolder $destinationFile <#połącz nazwę $destinationFolder z $destinationFile i zapamiętaj wynik w zmiennej $newFileName#>
Copy-Item $sourceFileName $newFileName <# Skopiuj plik $sourceFile na  $newFileName #>
echo "File $newFileName has been created" <#wyświetl komunikat „File … has been created”#>
}
