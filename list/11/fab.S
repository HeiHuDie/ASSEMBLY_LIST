.section .data
    format:
        .asciz "%d\n"
.section .text 
    .globl main
main:
    pushl $12
    call myfunc
    addl $4, %esp

    pushl %ebx
    pushl $format
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type myfunc, @function
myfunc:
    movl $0, %ebx
    movl 4(%esp), %eax
    cmp $0, %eax
    je end1
    cmp $1, %eax
    je end2
    dec %eax
    pushl %ebx
    pushl %eax
    call myfunc
    movl %ebx, %ecx
    popl %eax
    popl %ebx
    addl %ecx, %ebx
    dec %eax
    pushl %ebx
    pushl %eax
    call myfunc
    movl %ebx, %ecx
    popl %eax
    popl %ebx
    addl %ecx, %ebx
    ret   

end2:
    addl $1, %ebx
    ret
end1:
    addl $0, %ebx
    ret
