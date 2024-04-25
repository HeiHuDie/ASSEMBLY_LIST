.section .data
    input:
        .byte 0x55, 0x6e, 0x69, 0x76, 0x65, 0x72, 0x73, 0x69, 0x74, 0x79, 0x20, 0x6f, 0x66, 0x20, 0x43, 0x41, 0x53, 0x0a
        # "University of CAS\n"
    output:
        .byte 0
.section .text
.global main
main:
    pushl $0x69 # 'i'
    pushl $input
    pushl $output
    call delete_char
    addl $12, %esp

    movl $4, %eax
    movl $1, %ebx
    int $0x80

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type delete_char, @function
delete_char:
    movl 4(%esp), %ecx #output
    movl 8(%esp), %edi #input
    movl 12(%esp), %ebx #dechar
    movl $0, %edx
    movl $0, %esi
    movl $0, %eax
L1:
    cmp $18, %esi
    je end
    movb (%edi, %esi), %al
    cmp %bl, %al
    je noput
    movb %al, (%ecx, %edx)
    inc %edx
noput:
    inc %esi
    jmp L1
end:
    ret 
    