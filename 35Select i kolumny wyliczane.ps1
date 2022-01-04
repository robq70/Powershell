Get-ChildItem D:\script
Get-ChildItem D:\script | Select-Object -Property Name,Length
Get-ChildItem D:\script | Select-Object -Property Name,Length,@{n="Size KB";e={($_.Length/1024)}}
Get-ChildItem D:\script | Select-Object -Property Name,Length,@{n="Size KB";e={($_.Length/1KB)}}
Get-ChildItem D:\script | Select-Object -Property Name,Length,@{n="Size KB";e={($PSItem.Length/1KB)}},@{n="Size MB";e={($_.Length/1MB)}}
Get-ChildItem D:\script | Select-Object -Property Name,Length,@{n="Size KB";e={'{0:N2}' -f ($PSItem.Length/1KB)}},@{n="Size MB";e={'{0:N2}' -f ($_.Length/1MB)}}

Get-ChildItem Cert:\LocalMachine\CA
Get-ChildItem Cert:\LocalMachine\CA | Select-Object -Property Thumbprint,NotBefore,NotAfter
Ls Cert:\LocalMachine\CA | Select-Object -Property Thumbprint,NotBefore,NotAfter,@{n='Ile dni';e={$_.NotAfter.Subtract($_.NotBefore)}}
Get-Process | Sort-Object -Descending -Property CPU
Get-Process | Sort-Object -Descending | Select-Object -Property ProcessName,@{n='W sek';e={($_.CPU/60)}} -First 5