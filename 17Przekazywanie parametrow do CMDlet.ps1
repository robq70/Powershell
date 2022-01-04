Get-Service -Name Spooler -ComputerName localhost
Get-Service -Na Spooler -Comp localhost
Get-Service -Name Spooler,EventLog,EFS
$services=@("Spooler","EventLog","EFS") #do zmiennej $services przypisujemy tablicę @ z wartościami
$services
Get-Service $services
$servicesFromFile=Get-Content D:\script\services.txt #zawartość pliku to nazwy ww serwisów
$servicesFromFile
Get-Service $servicesFromFile