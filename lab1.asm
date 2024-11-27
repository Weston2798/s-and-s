SYS_WRITE equ 4
SYS_EXIT equ 1
STDOUT equ 1
SAFE_EXIT equ 0

section .data
    msgEven db "x is even", 0xA  ; Message when x is even
    msgEvenLen equ $ - msgEven   ; Length of the "even" message

    msgOdd db "x is odd", 0xA    ; Message when x is odd
    msgOddLen equ $ - msgOdd     ; Length of the "odd" message

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

    ; Check if x is even or odd
    mov eax, [x]             ; Load x into eax
    and eax, 1               ; Perform bitwise AND with 1 to check even/odd
    cmp eax, 0               ; If the result is 0, x is even
    je even_case             ; Jump to even_case if x is even
    jne odd_case             ; Otherwise, it's odd (jump to odd_case)

even_case:
    ; Print "x is even"
    mov eax, SYS_WRITE       ; syscall number for SYS_WRITE
    mov ebx, STDOUT          ; file descriptor 1 (stdout)
    mov ecx, msgEven         ; address of the "even" message
    mov edx, msgEvenLen      ; length of the "even" message
    int 0x80                 ; invoke syscall
    jmp increment_x          ; Jump to increment x

odd_case:
    ; Print "x is odd"
    mov eax, SYS_WRITE       ; syscall number for SYS_WRITE
    mov ebx, STDOUT          ; file descriptor 1 (stdout)
    mov ecx, msgOdd          ; address of the "odd" message
    mov edx, msgOddLen       ; length of the "odd" message
    int 0x80                 ; invoke syscall

increment_x:
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
