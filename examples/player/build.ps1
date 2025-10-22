function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}



build .\examples\player\math.c .\examples\player\math.asm
.\linker\linker.ps1 .\examples\player\math.asm, .\examples\player\main.asm -Destination res.asm
.\asm.exe res.asm a.bc

