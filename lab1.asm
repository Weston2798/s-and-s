SYS_WRITE equ 4
SYS_EXIT equ 1
STDOUT equ 1
STDIN equ 0

section .data
    msgGreater db "valA is greater than valB", 0xA  ; Message when valA > valB
    msgGreaterLen equ $ - msgGreater                ; Length of the message

    msgLess db "valA is less than valB", 0xA       ; Message when valA < valB
    msgLessLen equ $ - msgLess                      ; Length of the message

    msgEqual db "valA is equal to valB", 0xA       ; Message when valA == valB
    msgEqualLen equ $ - msgEqual                    ; Length of the message

section .text
    global _start

_start:
    ; Initialize valA and valB
    mov eax, 10        ; valA = 10
    mov ebx, 15        ; valB = 15

    ; Compare valA and valB
    cmp eax, ebx       ; Compare valA with valB
    je equal_case      ; If valA == valB, jump to equal_case
    ja greater_case    ; If valA > valB, jump to greater_case
    jb less_case       ; If valA < valB, jump to less_case

equal_case:
    ; Print "valA is equal to valB"
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msgEqual
    mov edx, msgEqualLen
    int 0x80
    jmp exit_program

greater_case:
    ; Print "valA is greater than valB"
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msgGreater
    mov edx, msgGreaterLen
    int 0x80
    jmp exit_program

less_case:
    ; Print "valA is less than valB"
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msgLess
    mov edx, msgLessLen
    int 0x80

exit_program:
    ; Exit the program
    mov eax, SYS_EXIT
    xor ebx, ebx       ; Return code 0
    int 0x80           ; Invoke the system call to exit