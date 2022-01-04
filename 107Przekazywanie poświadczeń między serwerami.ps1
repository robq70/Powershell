#
Omówienie scenariusz tzw. Double Hop - jesteśmy na komputerze A i konfigurujemy komputer B ale wymaga on pobrania pewnych danych z komputera C używając poświadczeń.
W zykłej konfiguracji to nie zadziała ponieważ komputer B nia ma takich uprawnień. aby to zrobić musimy na komputerze B musi być włączona obsługa protokołu Enable-WSManCredSSP -Role Server
Na komputerze A musimy zezwolić aby poświadczenia były przekazywane dalej Enable-WSManCredSSP -Role Client -DelegateComputer <RemoteCompName>
Można to też zrobić w zasadach GPO - Allow delegating fresh credential oraz Allow delegating fresh credential NTLM-only server authentication
Konfiguracja serwera pośredniczącego w przekazywaniu poświadczeń
Konfiguracja komputera lokalnego
Konfiguracja komputerów za pomocą zasad grupy

Invoke-Command -Authentication -UseSSL -Port

winrm s winrm/config/client '@{TrustedHosts="Domowy"}'

#On remote computer
Enable-WSManCredSSP -Role Server

#On local computer

Enable-WSManCredSSP -Role Client -DelegateComputer Wiki

#LAB

Get-Command *credssp* #Wyświetl polecenia pozwalające na modyfikację i wyświetlania opcji związanych z CREDSSP

Get-WSManCredSSP #Zezwól na przekazywanie poświadczeń
			#a. Uruchom gpedit.msc
			#b. Przejdź do Local Security Policy >> Computer Configuration >> Administrative Templates >> System >> Credentials delegation >> Allow delegating fresh credentials with NTLM-only server authorization
			#c. Przełącz stan na Enabled
			#d. Kliknij “Show” obok Add servers to list I wpisz wsman/<nazwa twojego komputera> 

Disable-WSManCredSSP #Sprawdź czy delegowanie poświadczeń jest wyłączone. Gdyby delegowanie było włączone, wyłącz je.

Enter-PSSession -ComputerName $env:COMPUTERNAME # tym zadaniu symulujemy sytuację połączenia z serwera A do B i dalej do C. Aby zadanie można było wykonać nawet dysponując jednym komputerem połączenie jest nawiązywane z lokalnego komputera do lokalnego komputera a następnie znowu do tego samego lokalnego komputera. Otwórz połączenie do  swojego komputera z wykorzystaniem Enter-PSSession

Invoke-Command -computerName $env:COMPUTERNAME -ScriptBlock  { Get-Date } #Mając otwarte połączenie zdalne, w ramach tej zdalnej sesji uruchom kolejne polecenie remotingu (do tego samego komputera): Invoke-Command wyświetlające datę i czas. Polecenie powinno zakończyć się błędem, bo nie jest jeszcze skonfigurowane przekazywanie poświadczeń.

Exit-PSSession #Zamknij otwarte połączenie zdalne.

Enable-WSManCredSSP -Role Client -DelegateComputer $env:COMPUTERNAME #Skonfiguruj komputer do przekazywania poświadczeń:Jako klient do przekazywania poświadczeń do komputera zdalnego

Enable-WSManCredSSP -Role Server #Skonfiguruj komputer do przekazywania poświadczeń:Jako serwer do przyjmowania poświadczeń

Get-WSManCredSSP #Sprawdź bieżącą konfigurację CredSSP

Enter-PSSession -ComputerName $env:COMPUTERNAME -Authentication Credssp -Credential (Get-Credential) #Połącz się do komputera z wykorzystaniem Enter-PSSession przekazując parametr -Authentication CredSSP oraz -Credential (Get-Credential)

Invoke-Command -computerName $env:COMPUTERNAME -ScriptBlock  { pwd } #W sesji zdalnej wykonaj ponownie polecenie Invoke-Command jak w pkt. (5). Tym razem polecenie powinno zadziałać.

Exit-PSSession #zakończ sesję zdalną