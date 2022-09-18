# ASM Caesar Cipher Cryptography

This program written in x86 Assembly encrypts and decrypts a message using the Caesar Cipher cryptography.

## Compilation

Install NASM with:

```bash
sudo apt-get install -y nasm
```

With NASM and MINGW confirmed to be installed, proceed with compilation fot your system architecture:
    
```bash
nasm -f win32 main.asm -o main
gcc main.obj
```

## Acknowledgments
Although, I learnt and use Assembly for fun, leave this repository a star.