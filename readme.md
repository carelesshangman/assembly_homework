# Computer Architecture - Homework

Foobar is a Python library for dealing with word pluralization.

## Task

Given are three ASCII strings: NIZ, SEZNAM1, and SEZNAM2. Write a program in assembly language for the ARM processor that replaces all lowercase NIZ letters in the following way. If the lowercase letter of the NIZ string is an element of SEZNAM1, replace it with the uppercase letter of SEZNAM2, which is in the same position as in SEZNAM1. If the content of SEZNAM1 is "abc" and the content of SEZNAM2 is "xyz", then each character "a" in string NIZ must be replaced with a capital letter "X", each character "b" must be replaced with a capital letter "Y" and each character "c" with the capital letter "Z". You can assume that SEZNAM1 and SEZNAM2 contain only lowercase letters and are of the same length. The program framework is given below. What is the content of the string NIZ after the execution of a program? Test your program for next string values of NIZ:     

-          "Pjisjrmljrcgf h dyljcfm gfdltw dr rjm  gf crphbf Zryrhci!"

-          "lx Dfywsslcs lb kvf ejiofbb ix jfmihlcs Bwsb,
            kvfc ejisjrmmlcs mwbk yf kvf ejiofbb ix ewkklcs Tvfm lc."

-          "lk'b vrjpnrjf kvrk mrtfb r mrovlcf xrbk. lk'b Sixknrjf kvrk mrtfb A xrbk mrovlcf Suin."

Ogrodje programa ("Program Framework"):

.text

NIZ:     .asciz "ejisjrmljrcgf h dyljcfm gfdltw dr rjm  gf crphbf dryrhci!"    
SEZNAM1:      .asciz  "abcdefghijklmnoprstuvwxyz"    
SEZNAM2:      .asciz  "xsnzpejvortimwcdagklhufby"             

.align
.global _start

_start:

@Tu napisi program ("Your code here")

_end:    b _end

Write short documentation for your program. Briefly describe how your algorithm works. Describe the usage of registers and their meaning or role (base register, data register, counter, ...). All this should fit one A4 page. Submit program and documents in one zip file to the online e-classroom. After submission, you have to pass oral defense of your report - bring printed documentation with you.

## Implementation

Code was written and tested in ARMv7 using CPUlator

```assembly
.text
NIZ:     .asciz "ejisjrmljrcgf h dyljcfm gfdltw dr rjm  gf crphbf dryrhci!"
SEZNAM1:      .asciz  "abcdefghijklmnoprstuvwxyz"
SEZNAM2:      .asciz  "xsnzpejvortimwcdagklhufby"

.align
.global _start

_start:
    adr r0, NIZ
    adr r3, SEZNAM1
    adr r5, SEZNAM2
    mov r2, #0
    mov r7,#0

loop1:
    ldrb r1,[r0]
    cmp r1,#0
    beq fin
    cmp r1,#90
    bls chars
    cmp r1,#97
    bhs next

back:
    sub r6,r6,#32
    strb r6,[r0]
    add r0,r0,#1
    mov r2, #0
    mov r7,#0
    adr r3, SEZNAM1
    adr r5, SEZNAM2
    b loop1

chars:
    strb r1,[r0]
    add r0,r0,#1
    b loop1

next:
    cmp r1,#122
    bls skim

skim:
    ldrb r4,[r3]
    cmp r4,#0
    beq fin
    cmp r1,r4
    beq forward
    add r2,r2,#1
    add r3,r3,#1
    b skim

forward:
    ldrb r6,[r5]
    cmp r2,r7
    beq back
    add r7,r7,#1
    add r5,r5,#1
    b forward

fin:

_end:    b _end
```

## Explanation of code

This code is a simple program that encrypts a string of text using a substitution cipher. The string to be encrypted is stored in the memory location designated by the label "NIZ", and two lists of characters, "SEZNAM1" and "SEZNAM2", are used to perform the encryption.

The program starts by loading the memory addresses of the input string, "SEZNAM1", and "SEZNAM2" into registers r0, r3, and r5 respectively. It then initializes two more registers, r2 and r7, to zero.

The program enters a loop labeled "loop1", where it loads a single character from the input string into register r1. If the character is a null terminator (indicating the end of the string), the program jumps to a label "fin" and the program ends.

Otherwise, the program checks if the character is a lowercase letter. If it is, the program simply copies the character to the input string and continues to the next character. If it's not, the program then checks if the character is an uppercase letter. If it is, it converts the character to lowercase by subtracting 32 from its ASCII value and stores it back to the input string.

If the character is not an uppercase letter, the program enters another loop labeled "skim" where it compares the character to each character in SEZNAM1. When it finds a match, it takes the corresponding character in SEZNAM2 and stores it in the input string. The program continues this process until it reaches the end of the input string, at which point it enters an infinite loop at the label "_end" and the program stops.

## Registers and their specific uses
```assembly
R0 - base register, used for storing NIZ (decoded elements)
R1 - stores current char
R2 - index counter of wanted char from SEZNAM1
R3 - base register, used for storing the current char address in SEZNAM1
R4 - data register that stores the char from SEZNAM1
R5 - base register, used for storing the current char address in SEZNAM2
R6 - data register that stores the corresponding swapped char
R7 - counter, that stores the current index of the wanted char in SEZNAM2
```

## Version 2
```assembly
.text
NIZ:     .asciz "ejisjrmljrcgf h dyljcfm gfdltw dr rjm  gf crphbf dryrhci!"
SEZNAM1:      .asciz  "abcdefghijklmnoprstuvwxyz"
SEZNAM2:      .asciz  "xsnzpejvortimwcdagklhufby"

.align
.global _start

_start:
    adr r0, NIZ
    adr r3, SEZNAM1
    adr r5, SEZNAM2
    mov r2, #0
    mov r7,#0
    mov r8,r3
    mov r9,r5

loop1:
    ldrb r1,[r0]
    cmp r1,#0
    beq fin
    cmp r1,#90
    bls chars
    cmp r1,#97
    bhs next

back:
    sub r6,r6,#32
    strb r6,[r0]
    add r0,r0,#1
    mov r2, #0
    mov r7,#0
    mov r3,r8
    mov r5,r9
    b loop1

chars:
    strb r1,[r0]
    add r0,r0,#1
    b loop1

next:
    cmp r1,#122
    bls skim

skim:
    ldrb r4,[r3]
    cmp r4,#0
    beq fin
    cmp r1,r4
    beq forward
    add r2,r2,#1
    add r3,r3,#1
    b skim

forward:
    ldrb r6,[r5]
    cmp r2,r7
    beq back
    add r7,r7,#1
    add r5,r5,#1
    b forward

fin:
    ldrb r1,[r0]
    cmp r1,#0
    beq _end
    add r0,r0,#1
    b loop1

_end:    b _end

```

## Patch notes
The 2nd version includes these changes:

The improved version loads the addresses of "SEZNAM1" and "SEZNAM2" into registers r3 and r5 only once at the start of the program, while the original version reloads them during each iteration of the main loop. This improves the efficiency of the program by reducing the number of memory accesses.

The improved version checks for the end of the input string after the encryption process, it makes sure that all the characters in the input string are processed and not just the ones up to the first null terminator.

The improved version uses additional registers (r8, r9) to store the original addresses of SEZNAM1 and SEZNAM2 so that it can reset the pointers to the beginning of the lists after each iteration.


## License

[MIT](https://choosealicense.com/licenses/mit/)