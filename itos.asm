# PURPOSE: convert a number into a string
#
# void itos(char *buf, int buf_size, int value)
#
# doesnt return anything
.equ ST_BUF, 8
.equ ST_BUF_SIZE, 12
.equ ST_VALUE, 16
.section .text
.globl itos
.type itos, @function
itos:
  pushl %ebp # save the original base pointer
  movl %esp, %ebp # get the new base pointer from stack pointer
  # pushl %eax
  pushl %ebx
  pushl %edx

  subl $1, %esp # make space for the letter

  movl ST_BUF(%ebp), %ebx # point to the buffer with ebx
  # movl ST_BUF_SIZE(%ebp), %ecx # keep track of the buffer size with ecx

loop_begin:
  cmpl $0, ST_VALUE(%ebp)
  jle loop_end

 # div EAX:EDX EDX has the remainder
  movl ST_VALUE(%ebp), %eax # move the input value to eax
  movl $0, %edx # move the input value to edx too for no reason
  movl $10, %edi
  divl %edi # divide by 10

  # take modulo of the value and put it in the 
  # buffer as byte with added '0' to make it ascii
 
  xor %ecx, %ecx
  addl %edx, %ecx
  addl $'0', %ecx
  movb %cl, (%ebx)

  movl %eax, ST_VALUE(%ebp) # move the new value in memory

  incl %ebx
  jmp loop_begin

loop_end:
  movb $0, (%ebx) # add null terminator

  pushl ST_BUF(%ebp)
  call reverse_str
  addl $4, %esp

  pushl %edx
  pushl %ebx
  # pushl %eax
  movl %ebp, %esp
  popl %ebp
  ret

.type reverse_str, @function
reverse_str:
  pushl %ebp # save the original base pointer
  movl %esp, %ebp # get the new base pointer from stack pointer

  movl ST_BUF(%ebp), %eax # start pointer
  movl ST_BUF(%ebp), %ebx # end pointer
trav_start:
  movb (%ebx), %cl
  cmpb $0, %cl # if the byte is not \0
  je trav_end

  incl %ebx
  jmp trav_start

trav_end:
  decl %ebx # step back the pointer

r_loop_start:
  cmpl %ebx, %eax # compare pointers (addresses)
  jge r_loop_end  # if eax is bigger than ebx which
                  # indicates that we have passed the middle point
                  # jump to end

  ## swap the contents of the pointers ##
  movb (%ebx), %cl
  movb (%eax), %dl
  movb %cl, (%eax)
  movb %dl, (%ebx)

  incl %eax
  decl %ebx
  jmp r_loop_start

r_loop_end:
  movl %ebp, %esp
  popl %ebp
  ret
