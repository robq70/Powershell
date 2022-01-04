#92Skrypty i funkcje LAB

[CmdletBinding()]
Param(
[Parameter(mandatory=$true)]
[DateTime]$OlderThan = (Get-Date).AddDays(-1), #zadeklarowanie daty -1 wczoraj
[Parameter(mandatory=$true)]
[string]$BaseFolder #zadeklarowanie zmiennej
)

Get-ChildItem $BaseFolder -Recurse -File | Where-Object { $_.LastWriteTime -lt $OlderThan } #Stałe zastąpione przez zmienne