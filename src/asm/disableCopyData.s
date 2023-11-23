@ Disable Copy Data if there is no non-iron save.
@ Hooked at 0xAB8EC.
@   r4: SaveMenu proc.
@   r5: Save file count.
.thumb

push  {r6}
sub   sp, #0x4C                       @ Allocate buffer for chapterData.

mov   r6, #0x0
saveFileLoop:
  mov   r0, r6                        @ Save slot.
  ldr   r3, =SaveMetadata_CheckId     @ AKA IsSaveValid. Check if this slot holds a save.
  bl    GOTO_R3
  cmp   r0, #0x0
  beq   continue
    mov   r0, r6
    mov   r1, sp
    ldr   r3, =LoadSavedChapterState  
    bl    GOTO_R3
    mov   r0, #0x42
    add   r0, sp
    ldrb  r0, [r0]
    mov   r1, #0x40
    tst   r0, r1
    bne   continue
      b     addOption
  continue:
  add   r6, #0x1
  cmp   r6, #0x3
  bge   return
    b     saveFileLoop

@ Found a non-iron save.
@ Add Copy Data to menu options.
addOption:
mov   r0, r4          @ SaveMenu proc.
mov   r1, #0x4        @ 4 is Copy Data option's ID.
ldr   r3, =0x80AB875  @ Function used to add option to SaveMenu.
bl    GOTO_R3

return:
add   sp, #0x4C
pop   {r6}
ldr   r0, =0x80AB8F5
bx    r0
GOTO_R3:
bx    r3
