# assemble all files inputted as arguments
for var in "$@"
do
  as --32 -g $var.asm -o $var.o
done

# link all files inputted as arguments to an executable 
ld -m elf_i386 ${ for var in "$@"; do echo $var.o; done; } -o $1
./$1 &
printf "\nexit code: $?\n"
