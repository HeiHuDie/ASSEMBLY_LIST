.section .data 
    input:
        .asciz "Hello, World!"
    output:
        .byte 0x00

.section .text
.globl main
main:
    pushl $input
    pushl $output
    call my_function
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type my_function, @function
my_function:
    movl 4(%esp), %ecx #output
    movl 8(%esp), %esi #input
    movl $13, %edi
    movl $0, %eax
L1:
    cmp $13, %eax
    je end
    movb (%esi,%eax), %bl
    movb %bl, (%ecx,%edi)
    inc %eax
    dec %edi
    jmp L1

end:
    movl $4, %eax
    movl $1, %ebx
    movl $14, %edx
    int $0x80
    ret
