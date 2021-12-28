cls
del lendo.exe
nasm -f win32 lendo.asm -o lendo.o
ld -L C:\Windows\System32 -l kernel32 -o lendo.exe lendo.o