.section .data 
    arr:
        .long 3,6
    format:
        .string "%d\n"
.section .text
.globl main
main:
    pushl $arr
    call mypow
    addl $4, %esp
    pushl %eax
    pushl $format
    call printf
    addl $8, %esp
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80


.type mypow, @function
mypow:
    movl 4(%esp), %ecx
    movl (%ecx), %edi # base
    addl $4, %ecx
    movl (%ecx), %esi # pow
    movl $1, %eax
    movl $0, %ecx
L1:
    cmp %ecx, %esi
    je end
    imull %edi, %eax
    incl %ecx
    jmp L1 

end:
    ret


