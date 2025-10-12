function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}



build .\examples\raycaster_asm\math.c .\examples\raycaster_asm\math.asm
.\linker\linker.ps1 .\examples\raycaster_asm\curvedY.asm, .\examples\raycaster_asm\phong.asm, .\examples\raycaster_asm\math.asm, .\examples\raycaster_asm\balls.asm -Destination res.asm
.\asm.exe res.asm a.bc

