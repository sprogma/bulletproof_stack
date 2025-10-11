function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}
build .\examples\raycaster\math.c .\examples\raycaster\math.asm
build .\examples\raycaster\main.c .\examples\raycaster\main.asm
.\linker\linker.ps1 .\examples\raycaster\curvedY.asm, .\examples\raycaster\math.asm, .\examples\raycaster\main.asm, .\stdlib\io.asm -Destination res.asm
.\asm.exe res.asm a.bc
