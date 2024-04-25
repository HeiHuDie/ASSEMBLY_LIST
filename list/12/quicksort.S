.section .data
testdata:
    .long 64,46,78,12,50,41,50,84,98,10,63,99,87,83,89,75,78,34,48,48,72,94,17,8,54,23,20,37,58,61,77,49,8,56,22,4,58,80,10,35,64,94,45,25,39
divsor:
    .long 10
result:
    .byte 0
.section .text
.globl main
main:
    subl $16,%esp
    movl $result,12(%esp) #result
    movl $testdata,8(%esp) #array
    movl $44,4(%esp) #high
    movl $0,(%esp) #low
    call quick_sort
# output
    call puts
# exit 
    call exit

.type quick_sort, @function
quick_sort:
    pushl %ebx
    pushl %esi
    pushl %edi
    movl 24(%esp), %ebx #array
    movl 20(%esp), %esi #high
    movl 16(%esp), %edi #low
    movl %edi , %eax #i = low
    movl %esi , %edx #j = high
    cmp %eax, %edx #i >= j?
    jl .end
.L1:
    movl (%ebx,%edi,4), %ecx #ecx = array[low]
    cmpl %eax, %edx #cmp i j
    je .L5
.L2:
    cmpl %ecx, (%ebx,%edx,4) #temp > arrary[j]?
    jl .L3
    cmpl %eax, %edx #i >= j?
    jle .L3
    subl $1, %edx #j--
    jmp .L2

.L3:
    cmpl %ecx, (%ebx,%eax,4) #temp < array[i]?
    jg .L4
    cmpl %eax, %edx #i >= j?
    jle .L4
    addl $1, %eax #i++ 
    jmp .L3

.L4:
    cmpl %eax, %edx #i >= j?
    jle .L1 
    #exchange array[i] and array[j] eax=i edx=j ebx=array
    pushl %ecx
    pushl %ebx
    pushl %esi
    pushl %edx
    pushl %eax
    pushl %edx
    call swap
    popl %edx
    popl %eax
    popl %edx
    popl %esi
    popl %ebx
    popl %ecx 
    jmp .L1

.L5:
    #exchange array[low] and array[i] eax=i edx=j ebx=array
    pushl %ecx
    pushl %ebx
    pushl %esi
    pushl %edx
    pushl %edi
    pushl %eax
    call swap
    popl %eax
    popl %edi
    popl %edx
    popl %esi
    popl %ebx
    popl %ecx

    #quick_sort(array,low,i-1)
    subl $1, %eax #i--
    movl %esi, %ecx
    movl %eax, %esi #high = i-1
    pushl %ecx
    pushl %eax
    pushl %edx
    pushl %ebx
    pushl %esi
    pushl %edi
    call quick_sort
    popl %edi
    popl %esi
    popl %ebx
    popl %edx
    popl %eax
    popl %ecx
    movl %ecx, %esi #restore high

    #quick_sort(array,i+1,high)
    addl $2, %eax #i++ 
    movl %edi, %ecx
    movl %eax, %edi #low = i+1
    pushl %ecx
    pushl %eax
    pushl %edx
    pushl %ebx
    pushl %esi
    pushl %edi
    call quick_sort
    popl %edi
    popl %esi
    popl %ebx
    popl %edx
    popl %eax
    popl %ecx
    movl %ecx, %edi #restore low

.end:
    popl %edi
    popl %esi
    popl %ebx
    ret

.type swap, @function
swap:
    pushl %ebx
    pushl %esi
    pushl %edi
    movl 8(%esp), %ebx #array
    movl 20(%esp), %esi #i
    movl 16(%esp), %edi #j
    movl (%ebx,%esi,4), %eax #temp = array[i]
    movl (%ebx,%edi,4), %ecx #array[j]
    movl %eax, (%ebx,%edi,4) #array[j] = temp
    movl %ecx, (%ebx,%esi,4) #array[i] = array[j]
    popl %edi
    popl %esi
    popl %ebx
    ret

.type puts, @function
puts:
    pushl %ebx
    pushl %esi
    pushl %edi
    movl 24(%esp), %ebx #array
    movl 20(%esp), %esi #high
    movl 28(%esp), %edi #result
    movl $0, %ecx #i = 0

.judge:
    cmpl %esi, %ecx #if i > high then end
    jg puts_end
    movl (%ebx), %eax #div_low = array[i]
    movl $0, %edx #div_hign = 0
    divl divsor
    # cmpb $0, %al #if div_low % 10 == 0 then notput0
    # je .notput0 
    addb $48, %al #convert to ascii
    movb %al, (%edi) #store to result
    inc %edi #result++
#.notput0:
    addb $48, %dl #convert to ascii
    movb %dl, (%edi) #store to result
    inc %edi #result++
    movb $44, (%edi) #store ','
    inc %edi #result++
    inc %ecx #i++
    addl $4, %ebx #array++
    jmp .judge

puts_end:
    dec %edi #delete ','
    movb $10, (%edi)
    xorl %edx, %edx
    movl %ecx, %edx
    addl %ecx, %edx
    addl %ecx, %edx
    movl $4, %eax
    movl $1, %ebx
    movl $result, %ecx

    int $0x80
    popl %edi
    popl %esi
    popl %ebx
    ret

.type exit, @function
exit:
    movl $1, %eax
    movl $0, %ebx
    int $0x80
