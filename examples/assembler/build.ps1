function build($a, $b)
{
    if (!(Test-Path $b) -or (gi $a).LastWriteTime -gt (gi $b).LastWriteTime)
    {
        .\ccc.exe $a $b
    }
    Write-Host "Skip build of $b"
}



# build .\examples\raycaster_asm\math.c .\examples\raycaster_asm\math.asm
.\linker\linker.ps1 .\examples\assembler\main.asm, .\examples\assembler\read.asm, .\examples\assembler\encode.asm, .\examples\assembler\process.asm, .\examples\assembler\label.asm, .\examples\assembler\command.asm, .\examples\assembler\directive.asm -Destination res.asm
.\asm.exe res.asm a.bc


# current test:
# "   a:  ; `n`n  a:;`n.db 0`n .dd 0x503`n   bb;  a a abb`n  c cc" | .\spu.exe -mem (256MB) -image 0x4000 a.bc -entry 0x4000 -map "1:stdio 2:hexstdio"
