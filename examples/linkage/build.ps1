.\linker\linker.ps1 .\examples\linkage\a.asm, .\examples\linkage\b.asm -Destination res.asm
.\asm.exe .\res.asm a.bc
.\spu.exe -mem (64MB) -image 0x4000 a.bc -entry 0x4000 -map "1:hexstdio"
