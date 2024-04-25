.section .data
    format:
        .asciz "Maximum value is %d\n"
    arr:
        .long 66,67,34,222,45,75,54,34,44,33,22,11,0
.section .text
.globl main
main:
    pushl $arr
    call my_func
    addl $4, %esp
    pushl %eax
    pushl $format
    call printf
    addl $8, %esp

    movl $1, %eax
    movl $0, %ebx
    int $0x80

.type my_func, @function
my_func:
    pushl %ebp                
    movl %esp, %ebp           
	movl 8(%ebp), %ecx        
    movl (%ecx), %eax                          
    movl 4(%ecx), %ebx        
start_loop:	                  
	addl $4, %ecx             
    movl (%ecx), %ebx
	cmpl $0, %ebx             
	je maximum_exit
	cmpl %ebx, %eax           
	jge start_loop                                      
	movl %ebx, %eax           
	jmp start_loop            
maximum_exit:
    movl %ebp, %esp           
    popl %ebp                 
    ret
    