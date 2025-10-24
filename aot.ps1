.\aot.exe
gcc res.S -masm=intel -c -o a.o
gcc aotcompiler/runtime.c -c -o b.o
gcc a.o b.o -o a.exe
