.section .data
    testdata:
        .long 0x12345678
    format:
        .asciz "0x%x\n"
.section .text
.globl main
main:
    pushl $testdata
    call my_function
    addl $4, %esp
    pushl %edi
    pushl $format
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type my_function, @function
my_function:
    movl 4(%esp), %eax
    movl (%eax), %eax
    movl $28, %ecx
    movl $0, %edi
    movl $0, %edx
L1:
    movl %eax, %ebx
    shrl %ecx, %ebx
    andl $15, %ebx
    pushl %ecx
    movl %edx, %ecx
    shll %ecx, %ebx
    popl %ecx
    orl %ebx, %edi
    cmp $0, %ecx
L2:
    subl $4, %ecx
    addl $4, %edx
    cmp $0, %ecx
    jge L1
    ret
