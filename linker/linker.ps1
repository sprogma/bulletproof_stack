param(
    [string[]]$Files,
    [string]$Destination
)

$uuid = 0
$code = ($Files | % {
    $name = "$(($uuid++))" + (Split-Path -LeafBase $_)
    $a = gc $_;
    $b = $a | sls "^\s*(\w[\w\d]*):\s*$" | % Matches | % {$_.Groups[1].Value}
    $c = $b | ?{$_[0] -eq [char]'_'}
    $c | % {$a = $a-replace"\b$_\b", "_$($name)_$_"}
    $a-join"`n"
})-join"`n`n"

"
LEA main - 4, end_proc
`$LEA __ld_zero, main
end_proc:
; like HLT instruction
.db 0xFF
__ld_zero:
.dd 0
$code
">$Destination
