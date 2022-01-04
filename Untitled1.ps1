Get-ChildItem D:\script
Get-ChildItem D:\script | Select-Object Name,Length
Get-ChildItem D:\script | Select-Object Name,Length,@{n='Size in KB';e={($PSItem.Lenght/1024)}}
Get-ChildItem D:\script | Select-Object Name,Length,@{n='Size in KB';e={'{0:N2}' -f ($PSItem.Lenght/1024)}},@{n='Size in MB';e={'{0:N2}' -f ($PSItem.Lenght/1MB)}}
Get-WmiObject Win32_logicaldisk | Select DeviceID, MediaType,@{Name="Free %";e={"{0,6:P0}" -f(($_.freespace) / ($_.size))}}
Get-ChildItem Cert:\LocalMachine\CA | Select-Object Thumbprint,NotBefore,NotAfter,@{Name="Difference";e={$_.NotAfter.Subtract($_.NotBefore)}}