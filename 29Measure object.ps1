1,2,3,4,5,6 | Measure-Object #liczy ile jest cyfr a nie sumę
1,2,3,4,5,6 | Measure-Object -Sum -Minimum -Maximum
1..6 | Measure-Object -Sum #liczy ile jest cyfr i sumę całkowitą
Get-ChildItem D:\script | Measure-Object -Property Length -Sum #Ile plików jest w katalogu oraz ich wielkość
Get-ChildItem D:\script | GM
