.\ccc.exe .\examples\stdgl\gl.c gl.asm
.\ccc.exe .\examples\stdgl\math.c math.asm
.\linker\linker.ps1 gl.asm, math.asm, .\stdlib\io.asm -Destination res.asm
.\asm.exe res.asm a.bc
