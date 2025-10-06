.\asm.exe .\examples\audio_saw\a.asm a.bc
.\spu.exe -mem (64MB) -image 0x4000 a.bc -entry 0x4000 -map "1:audio"
