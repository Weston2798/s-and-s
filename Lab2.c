 #include <stdio.h>
 #include <string.h>

void vulnerable_function(char *input) {
         char buffer[64];
         printf(input);
         strcpy(buffer, input);
     }

int main(int argc, char *argv[]) {
         if (argc > 1) {
             vulnerable_function(argv[1]);
         } else {
             printf("Usage: %s <input>\n", argv[0]);
         }
         return 0;
     }
