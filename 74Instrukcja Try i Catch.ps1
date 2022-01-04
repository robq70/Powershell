$x=100
$y=10

Write-Host "$x / $y = $($x/$y)"

$x=100
$y=0

Write-Host "$x / $y = $($x/$y)"

<#blok try,catch, finally. Finally jest opcjonalne#>
try <#Próbujemy wykonać jakieś działanie zdając sobie sprawę że czasem przy jego wykonywaniu może dojść do błędu#>
{
Write-Host "$x / $y = $($x/$y)"
}
catch <#W bloku catch określamy co należy zrobić jeśli do takiego błedu dojdzie#>
{
Write-Host "Sorry we have an error..."

"-------------------------" | Out-File D:\script\error.txt -Append <#Po wystąpieniu błędu powstaje plik z kreską oddzielającą ich wystąpienie ------------------#>
Get-Date | Out-File D:\script\error.txt -Append <#dodatkowo data wystąpienia błądu#>
$Error[0] | Out-File D:\script\error.txt -Append <#A domyślna tablica $Error zapamietująca wszystkie błędy które wystąpiły podczas sesji zapisuje błąd do pliku. Ostatni błąd jest pierwszym elementem tej listy#>
}

Get-Content D:\script\error.txt


<#Q&A#>

<#Jaki będzie efekt następującego skryptu. Nie będzie wyświetlony błąd a następnie komunikat Cannot connect to NonExistentCompName #>

$comp = 'NonExistentCompName'
try
{
$Manufacturer = Get-WmiObject -Class Win32_BIOS -ComputerName $comp -ErrorAction Stop |
Select -expand Manufacturer
echo "Manufacturer is $Manufacturer"
}
catch
{
echo "Cannot connect to $comp"
}

<#Jaki będzie efekt następującego skryptu. Będzie wyświetlony błąd a następnie komunikat Manufacturer is #>

$comp = 'NonExistentCompName'
try
{
$Manufacturer = Get-WmiObject -Class Win32_BIOS -ComputerName $comp -ErrorAction Continue |
Select -expand Manufacturer
echo "Manufacturer is $Manufacturer"
}
catch
{
echo "Cannot connect to $comp"
}

<#LAB#>

"Text" | Out-File -FilePath D:\script\FileToCopy.txt <#Tworzymy plik w katalogu#>

Copy-Item -Path D:\script\FileToCopy.txt -Destination \\Server01\C$\temp\NewFile.txt <#Przygotuj i uruchom polecenie kopiujące plik na nie istniejący zasób sieciowy, np. \\server01\C$\temp\NewFile.txt Po uruchomieniu polecenie zakończy się błędem#>


try <#Korzystając z instrukcji try catch zmień polecenie tak, aby w przypadku błędu wyświetlało komunikat „file cannot be copied”#>
{
Copy-Item -Path D:\script\FileToCopy.txt -Destination \\Server01\C$\temp\NewFile.txt
}
catch
{
Write-Warning "file cannot be copied"
}



try <#To samo tylko zmień polecenie wyświetlające komunikat o błędzie tak aby wskazać na przyczynę błędu (skorzystaj ze zmiennej $Error[0].Exception.Message) #>
{
Copy-Item -Path D:\script\FileToCopy.txt -Destination \\Server01\C$\temp\NewFile.txt
}
catch
{
Write-Warning "File cannot be copied: $($Error[0].Exception.Message)"
}


try <#To samo tylko dodano komunikat file copied #>
{
Copy-Item -Path D:\script\FileToCopy.txt -Destination \\Server01\C$\temp\NewFile.txt
Write-Host "file copied"
}
catch
{
Write-Warning "File cannot be copied: $($Error[0].Exception.Message)" 
}


try <#To samo tylko ścieżka jest poprawna #>
{
Copy-Item -Path D:\script\FileToCopy.txt -Destination C:\Script\NewFile.txt
Write-Host "file copied"
}
catch
{
Write-Warning "File cannot be copied: $($Error[0].Exception.Message)"
}
