function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}



build .\examples\ball_jumper\math.c .\examples\ball_jumper\math.asm
.\linker\linker.ps1 .\examples\ball_jumper\curvedY.asm, .\examples\ball_jumper\phong.asm, .\examples\ball_jumper\math.asm, .\examples\ball_jumper\balls.asm, .\examples\ball_jumper\keyinput.asm -Destination res.asm
.\asm.exe res.asm a.bc


# .\spu.exe -mem (256MB) -image 0x4000 a.bc -entry 0x4000 -map "1:video10 2:stdio 3:stdio"
