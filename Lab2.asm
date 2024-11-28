section .text
    global _start

_start:
    ; Set up the execve("/bin/sh", NULL, NULL) system call
    xor eax, eax          ; Clear EAX register
    push eax              ; Push NULL (terminator for the string) onto the stack
    push 0x68732f2f       ; Push "//sh" onto the stack
    push 0x6e69622f       ; Push "/bin" onto the stack
    mov ebx, esp          ; Move the stack pointer into EBX (which points to "/bin//sh")
    push eax              ; Push NULL (argv terminator)
    push ebx              ; Push pointer to "/bin//sh"
    mov ecx, esp          ; Move stack pointer into ECX (argv)
    xor edx, edx          ; Clear EDX (envp terminator)
    mov al, 0x0b          ; Set the syscall number for execve (0x0b)
    int 0x80              ; Trigger the syscall

