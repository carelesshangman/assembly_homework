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
