#### PURPOSE

This is just a practise repository for learning Assembly
It implements a program to print numbers from commandline arguments

#### USAGE

There is a bash script that can be used to build and link all the needed parts of the program

```bash
./run.sh main strlen itos write_newline
```

It outputs an executable with the same name as the first argument (also first source file) and runs it
If the program requires arguments you can run it afterwards

```bash
./main 12345
```

#### SOURCE FILES

- itos.asm
    integer to string
- stoi.asm
    string to integer
- strlen.asm
    implementation of strlen from c standard library
- write_newline.asm
    function to write a newline character
