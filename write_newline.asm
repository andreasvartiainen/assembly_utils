# PURPOSE: Print a newline character
#
# RETURN: nonthing

.section .data
  newline:
    .ascii "\n"
.globl write_newline
.section .text
.type write_newline, @function
write_newline:
  movl $4, %eax
  movl $1, %ebx
  movl $newline, %ecx
  movl $1, %edx
  int $0x80

  ret
