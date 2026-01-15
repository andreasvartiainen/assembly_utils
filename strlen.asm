.equ ST_STR, 8
.section .text 
.globl strlen
.type strlen, @function
strlen:
  pushl %ebp
  movl %esp, %ebp
  pushl %ebx

  movl ST_STR(%ebp), %ebx
  xor %eax, %eax
loop_start:
  movb (%ebx), %cl
  cmpb $0, %cl
  je loop_end

  incl %eax
  incl %ebx
  jmp loop_start

loop_end:
  popl %ebx
  movl %ebp, %esp
  popl %ebp
  ret

