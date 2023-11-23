@ Disable Restart option if Iron suspended save exists.
@ Hooked at 0xAB8E0.
@   r4: SaveMenu proc.
.thumb

sub   sp, #0x4C         @ Allocate buffer for chapterData.

mov   r0, #0x3          @ Save slot. Suspend save is slot 3.
ldr   r3, =0x80A5DA9    @ IsValidSuspendSave. Check if there is a suspend. 
bl    GOTO_R3
cmp   r0, #0x0
beq   enableRestart     @ Enable if no suspend.

  mov   r0, #0x3        @ Save slot. Suspend save is slot 3.
  mov   r1, sp
  ldr   r3, =LoadSuspendedChapterState
  bl    GOTO_R3
  mov   r0, #0x42
  add   r0, sp
  ldrb  r0, [r0]
  mov   r1, #0x40
  tst   r0, r1
  bne   return

    @ No suspend save or
    @ suspend save doesn't have iron bit set.
    @ Add Restart to menu options.
    enableRestart:
    mov   r0, r4          @ SaveMenu proc.
    mov   r1, #0x2        @ 2 is Restart option's ID.
    ldr   r3, =0x80AB875  @ Function used to add option to SaveMenu.
    bl    GOTO_R3

return:
add   sp, #0x4C
ldr   r0, =0x80AB8E9
bx    r0
GOTO_R3:
bx    r3
