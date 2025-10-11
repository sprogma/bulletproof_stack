
function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}
build .\examples\raymarcher\gl.c .\examples\raymarcher\gl.asm
build .\examples\raymarcher\math.c .\examples\raymarcher\math.asm
.\linker\linker.ps1 .\examples\raymarcher\gl.asm, .\examples\raymarcher\math.asm, .\stdlib\io.asm -Destination res.asm
.\asm.exe res.asm a.bc
