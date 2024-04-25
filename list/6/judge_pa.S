.section .data
    string1:
        .asciz "1011_1101"
    string2:
        .asciz "1101_1001"
.section .text
    .globl main
main:
    pushl $string2
    call judge
    addl $4, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type judge, @function
judge:
    movl 4(%esp), %ecx
    movl $8, %edi
    movl $0, %esi
L1:
    movb (%ecx,%edi), %al
    movb (%ecx,%esi), %ah
    cmp %ah, %al
    jne L2
    incl %esi
    decl %edi
    cmpl %edi, %esi
    jle L1

    movl $4, %eax
    movl $1, %ebx
    movl $9, %edx
    int $0x80
    ret

L2:
    ret

