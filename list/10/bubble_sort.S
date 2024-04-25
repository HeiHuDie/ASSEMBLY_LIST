.text
        .globl  bubble_sort
        .type   bubble_sort, @function
bubble_sort:
.LFB0:
        pushl   %edi
        pushl   %esi
        pushl   %ebx
        movl    16(%esp), %edi
        movl    20(%esp), %esi 
        dec	      %esi
        testl   %esi, %esi
        jle     .L1
.L3:
        testl   %esi, %esi
        jle     .L6
        movl    %edi, %eax
        movl   %edi, %ebx
        addl    %esi, %ebx
.L7:
        movzbl  (%eax), %edx
        movzbl  1(%eax), %ecx
        cmpb    %cl, %dl
        jle     .L4
        movb    %cl, (%eax)
        movb    %dl, 1(%eax)
.L4:
        addl    $1, %eax
        cmpl    %ebx, %eax
        jne     .L7
.L6:
        subl    $1, %esi
        jne     .L3
.L1:
        popl    %ebx
        popl    %esi
        popl    %edi
        ret
