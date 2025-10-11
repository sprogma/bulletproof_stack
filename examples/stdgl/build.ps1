
function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}
build .\examples\stdgl\gl.c .\examples\stdgl\gl.asm
build .\examples\stdgl\math.c .\examples\stdgl\math.asm
.\linker\linker.ps1 .\examples\stdgl\gl.asm, .\examples\stdgl\math.asm, .\stdlib\io.asm -Destination res.asm
.\asm.exe res.asm a.bc
