SYS_WRITE equ 4
SYS_EXIT equ 1
STDOUT equ 1
SAFE_EXIT equ 0

section .data
    msg db "good Job!!!", 0xA  ; Message to print
    msgLen equ $ - msg          ; Length of the message

section .bss
    x resb 4   ; Reserve space for x
    y resb 4   ; Reserve space for y

section .text
    global _start

_start:
    ; Initialize x = 1 and y = 10
    mov dword [x], 1         ; x = 1
    mov dword [y], 10        ; y = 10

while_loop:
    ; Compare if x <= y
    mov eax, [x]             ; Load x into eax
    mov ebx, [y]             ; Load y into ebx
    cmp eax, ebx             ; Compare x with y
    jg exit_program          ; If x > y, exit the loop

    ; Print the message "good Job!!!"
    mov eax, SYS_WRITE       ; syscall number for SYS_WRITE
    mov ebx, STDOUT          ; file descriptor 1 (stdout)
    mov ecx, msg             ; address of the message
    mov edx, msgLen          ; length of the message
    int 0x80                 ; invoke syscall

    ; Increment x by 1
    mov eax, [x]             ; Load x into eax
    add eax, 1               ; Increment x by 1
    mov [x], eax             ; Store the new value of x back into memory

    ; Repeat the loop
    jmp while_loop

exit_program:
    ; Exit the program
    mov eax, SYS_EXIT        ; syscall number for exit
    xor ebx, ebx             ; return code 0
    int 0x80                 ; invoke syscall
