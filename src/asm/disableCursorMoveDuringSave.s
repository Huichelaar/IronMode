@ Disable moving cursor when saving on an iron save.
@ Hooked at 0xABA00.
.thumb

mov   r2, r0
add   r2, #0x42
ldrb  r2, [r2]        @ saveMenuProc->actionFlags.
cmp   r2, #0x40
bne   return
  @ Saving.
  ldr   r2, =gChapterData+0x42
  ldrb  r2, [r2]
  mov   r3, #0x40
  tst   r2, r3
  beq   return
    @ Iron mode enabled.
    mov   r0, #0x0    @ Don't allow cursor to move.
    pop   {r4-r5}
    pop   {r1}
    bx    r1

@ Vanilla, overwritten by hook.
return:
lsl   r1, #0x18
lsr   r2, r1, #0x18
mov   r1, #0x0
add   r0, #0x2C
ldr   r3, =0x80ABA09
bx    r3
