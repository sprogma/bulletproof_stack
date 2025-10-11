
function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}
build .\examples\raytracer\gl.c .\examples\raytracer\gl.asm
build .\examples\raytracer\math.c .\examples\raytracer\math.asm
.\linker\linker.ps1 .\examples\raytracer\gl.asm, .\examples\raytracer\math.asm, .\stdlib\io.asm -Destination res.asm
.\asm.exe res.asm a.bc
