Get-Service | Out-File D:\script\processes.txt
Get-Content D:\script\processes.txt
Get-Service | Out-GridView #Widok w zewnętrznej przeglądarce
Get-Service | Get-Member
Get-Service | Get-Member #Zamiast można użyć GM
Get-ChildItem D:\script
Get-ChildItem D:\script | GM

