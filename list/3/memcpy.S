.section .data
    input:
        .byte 0x55, 0x6e, 0x69, 0x76, 0x65, 0x72, 0x73, 0x69, 0x74, 0x79, 0x20, 0x6f, 0x66, 0x20, 0x43, 0x41, 0x53, 0x0a 
    output:
        .byte 0x00

.section .text
    .global main
main:
    pushl $input
    pushl $output
    call mymemcpy
    addl $8, %esp

    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $18, %edx
    int $0x80

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
    movb (%edx,%ebx), %al
    movb %al, (%ecx,%ebx)
    inc %ebx
    jmp L1

end:
    ret
