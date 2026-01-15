.equ ST_STR, 8 # position for the string input
.equ ST_VALUE, -4 # position for value
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
