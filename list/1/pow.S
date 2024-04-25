.section .data 
    pow:
        .long 5
    base:
        .long 3
    format:
        .string "%d\n"
.section .text
.globl main
main:
    pushl $pow
    pushl $base
    call mypow
    addl $8, %esp
    pushl %eax
    pushl $format
    call printf
    addl $8, %esp
    movl    $1, %eax
    movl    $0, %ebx
    int     $0x80


.type mypow, @function
mypow:
    movl 8(%esp), %eax
    movl 4(%esp), %ecx
    movl (%ecx), %edi # base
    movl (%eax), %esi # pow
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


