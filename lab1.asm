section .data
    hellomsg db "Hello World From Assembly", 0xa
    msglength equ $ - hellomsg

section .bss
    varMsg resb 4
    varLen resb 4

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
    
    mov [varMsg], DWORD hellomsg
    mov [varLen], DWORD msglength

    call printString
