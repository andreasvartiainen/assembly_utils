.section .data
  str:
    .ascii "25\0"
  value:
    .long 123

.section .bss
  .equ BUFFER_SIZE, 32
  .lcomm BUFFER, BUFFER_SIZE

.section .text
.equ ST_ARGC, 0
.equ ST_ARGV_0, 4
.equ ST_ARGV_1, 8
.globl _start
_start:
  movl %esp, %ebp

  cmpl $1, ST_ARGC(%ebp)
  jle end

  pushl ST_ARGV_1(%ebp)
  call stoi
  addl $4, %esp # restore stack
  movl (%eax), %ebx

  pushl %ebx
  pushl $BUFFER_SIZE
  pushl $BUFFER
  call itos
  subl $12, %esp

  movl $4, %eax
  movl $1, %ebx
  movl $BUFFER, %ecx
  movl $BUFFER_SIZE, %edx
  int $0x80

  call write_newline

end:
  # exit sequence
  movl $1, %eax 
  # movl 8(%ebp), %ebx
  # movl (%ebx), %ebx
   movl $0, %ebx
  int $0x80
