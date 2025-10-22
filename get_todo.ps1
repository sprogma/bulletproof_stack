$a = gci *.c, *.h, *.inc, *.cs, *.ps1 -r | sls "\bTODO\s?:"
Write-Host "`nHave $($a.Matches.Count) TODO total." -Foreground Yellow
$a
