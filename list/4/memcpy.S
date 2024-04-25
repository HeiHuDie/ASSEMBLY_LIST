.section .data
    newline:
        .asciz "\n"
    format:
        .asciz "%d "
    input:
        .long 15,12,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 
    output:
        .long 0

.section .text
    .global main
main:
    pushl $input
    pushl $output
    call mymemcpy
    addl $8, %esp

    movl $0, %ebx
    movl $output, %esi
L2:
    cmpl $18, %ebx
    je end2
    pushl (%esi,%ebx,4)
    pushl $format
    call printf
    addl $8, %esp
    inc %ebx
    jmp L2

end2:
    pushl $newline
    call printf
    addl $4, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type mymemcpy, @function
mymemcpy:
    movl 4(%esp), %ecx #output
    movl 8(%esp), %edx #input
    movl $0, %eax
    movl $0, %ebx
L1:
    cmp $18, %ebx
    je end
    movl (%edx,%ebx,4), %eax
    movl %eax, (%ecx,%ebx,4)
    inc %ebx
    jmp L1

end:
    ret
