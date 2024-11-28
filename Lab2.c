 #include <stdio.h>
 #include <string.h>

void vulnerable_function(char *input) {
         char buffer[128];
         strcpy(buffer, input);
     }

int main(int argc, char *argv[]) {
    char pipeArg[128];

         if (argc > 1) {
             vulnerable_function(argv[1]);
         }
        else if (fgets(pipeArg, sizeof(pipeArg), stdin) != NULL){
            vulnerable_function(pipeArg);
         } else  {
             printf("Usage: %s <input>\n", argv[0]);
         }
         return 0;
     }
