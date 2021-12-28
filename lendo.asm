NULL EQU 0
STD_OUTPUT_HANDLE_CODE EQU -11
STD_INPUT_HANDLE_CODE EQU -10
TESTE_BUFFER EQU 256

extern _GetStdHandle@4
extern _ExitProcess@4
extern _WriteFile@20
extern _ReadConsoleA@20
global inicio

section .data
mensagem db "Digite seu nome:",10,13,0 ;10 new line / 13 carriage return
tamanho_mensagem EQU $-mensagem

section .bss
    buffer1: resb 32
    buffer2: resb 32

section .text
inicio:
    ;Buscando handle de saida que e retornado em eax
    push STD_OUTPUT_HANDLE_CODE
    call _GetStdHandle@4
    mov ebx,eax

    ;escrevendo mensagem na tela
    ; WriteFile( hstdOut, message, length(message), &bytes, 0);
    push NULL
    push NULL
    push tamanho_mensagem ;se colocar 17 aparece tudo
    push mensagem
    push ebx
    call _WriteFile@20

    ;buscando handle de entrada que e retornado em eax
    push STD_INPUT_HANDLE_CODE
    call _GetStdHandle@4
    mov ebx,eax

    ;Lendo do buffer de entrada
    ;ReadConsole (hstdInput, lpBuffer (recebe dados lidos), numberOfCharsToRead,)
    push NULL
    push buffer1
    push TESTE_BUFFER
    push buffer2
    push ebx
    call _ReadConsoleA@20

    ;Buscando handle de saida que e retornado em eax
    push STD_OUTPUT_HANDLE_CODE
    call _GetStdHandle@4
    mov ebx,eax

    ;escrevendo dados digitados na tela
    ; WriteFile( hstdOut, message, length(message), &bytes, 0);
    push NULL
    push NULL
    push TESTE_BUFFER
    push buffer2
    push ebx
    call _WriteFile@20

    ;Saindo
    push NULL
    call _ExitProcess@4