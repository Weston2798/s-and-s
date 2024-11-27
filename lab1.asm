SYS_WRITE equ 4
SYS_READ equ 3
SYS_EXIT equ 1
STDOUT equ 1
STDIN equ 0
SAFE_EXIT equ 0

section .data
    prompt db "Enter a string: ", 0xA
    promptLen equ $ - prompt
    maxInputLen equ 128

section .bss
    userInput resb maxInputLen
    inputLen resb 4

section .text
    global _start

printString:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, [varMsg]
    mov edx, [varLen]
    int 0x80
    ret

_start:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, prompt
    mov edx, promptLen
    int 0x80 

    mov eax, SYS_READ
    mov ebx, STDIN
    mov ecx, userInput
    mov edx, maxInputLen
    int 0x80

    mov eax, userInput
    xor ecx, ecx
find_length:
    cmp byte [eax + ecx], 0
    je done_find_length
    inc ecx
    jmp find_length
done_find_length:
    mov [inputLen], ecx

    mov [varMsg], eax
    mov [varLen], ecx
    call printString

    ; Exit the program
    mov eax, SYS_EXIT
    xor ebx, ebx
    int 0x80
