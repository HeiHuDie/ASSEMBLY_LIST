 #!/bin/bash
 as --32 -g -o quicksort.o quicksort.S 
 ld -e main -m elf_i386 -g -o quicksort quicksort.o