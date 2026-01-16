# PURPOSE: Converts an input string to a number
#
# RETURN: Resulting number is returned through %eax

.equ ST_STR, 8    # Null terminated string to be converted to a number
.equ ST_VALUE, -4 # Local variable to store the value to be returned in
.section .text
.globl stoi
.type stoi, @function
stoi:
  pushl %ebp
  movl %esp, %ebp
  pushl %ebx
  subl $4, %esp
  leal ST_VALUE(%ebp), %eax

  movl ST_STR(%ebp), %ebx
loop_start:
  movb (%ebx), %cl
  cmpb $0, %cl
  je loop_end

  subb $'0', %cl # make the character into a number by subtracting '0'

  movl (%eax), %edx # move the current value to edx
  imul $10, %edx # multiply it by 10
  movl %edx, (%eax) # move it back to eax

  movzbl %cl, %edx # move with zero extend
  addl %edx, (%eax) # add now zero extended value to (%eax)

  incl %ebx
  jmp loop_start

loop_end:
  popl %ebx
  movl %ebp, %esp
  popl %ebp
  ret
