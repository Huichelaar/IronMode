	.cpu arm7tdmi
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 4
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	1
	.global	IMM_swapSpritesInit
	.arch armv4t
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_swapSpritesInit, %function
IMM_swapSpritesInit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, r0
	@ sp needed
	movs	r3, #1
	adds	r2, r2, #96
	adds	r0, r0, #98
	strh	r3, [r2]
	strb	r3, [r0]
	bx	lr
	.size	IMM_swapSpritesInit, .-IMM_swapSpritesInit
	.align	1
	.global	IMM_difficultySelectInit
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_difficultySelectInit, %function
IMM_difficultySelectInit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	movs	r2, r0
	@ sp needed
	movs	r3, #0
	adds	r2, r2, #96
	adds	r0, r0, #99
	strb	r3, [r2]
	strb	r3, [r0]
	bx	lr
	.size	IMM_difficultySelectInit, .-IMM_difficultySelectInit
	.align	1
	.global	IMM_swapSpritesLoop
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_swapSpritesLoop, %function
IMM_swapSpritesLoop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}
	movs	r5, r0
	movs	r6, r0
	adds	r5, r5, #97
	ldrb	r3, [r5]
	adds	r3, r3, #1
	lsls	r3, r3, #24
	lsrs	r3, r3, #24
	strb	r3, [r5]
	adds	r6, r6, #98
	ldrb	r2, [r6]
	movs	r4, r0
	cmp	r2, #0
	bne	.L10
	movs	r1, #136
	movs	r0, #1
	adds	r2, r2, #8
	rsbs	r1, r1, #0
.L4:
	movs	r7, #7
	str	r7, [sp]
	ldr	r7, .L11
	bl	.L13
	ldr	r3, [r4, #52]
	strh	r0, [r3, #62]
	ldrb	r2, [r5]
	cmp	r2, #6
	bls	.L3
	ldrb	r2, [r6]
	cmp	r2, #0
	beq	.L6
	movs	r2, r4
	adds	r2, r2, #99
	ldrb	r1, [r2]
	cmp	r1, #0
	bne	.L7
	adds	r1, r1, #1
	strb	r1, [r2]
	movs	r2, #48
	ldr	r0, .L11+4
	strh	r2, [r3, #46]
	ldr	r3, .L11+8
	bl	.L14
	movs	r2, #168
	movs	r1, #216
	adds	r0, r0, #42
	ldrb	r0, [r0]
	ldr	r3, .L11+12
	lsls	r2, r2, #2
	adds	r3, r3, r2
	lsls	r0, r0, #6
	adds	r0, r0, r3
	movs	r2, #64
	ldr	r3, .L11+16
	lsls	r1, r1, #2
	bl	.L14
.L8:
	movs	r2, #0
	ldr	r3, [r4, #52]
	adds	r3, r3, #43
	strb	r2, [r3]
	movs	r3, r4
	adds	r3, r3, #48
	strb	r2, [r3]
	movs	r0, r4
	ldr	r3, .L11+20
	bl	.L14
.L9:
	movs	r3, #0
	strb	r3, [r5]
	ldrb	r2, [r6]
	adds	r3, r3, #1
	eors	r3, r2
	strb	r3, [r6]
	movs	r0, r4
	ldr	r3, .L11+24
	bl	.L14
.L3:
	@ sp needed
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L10:
	movs	r2, #136
	movs	r0, #0
	movs	r1, #8
	rsbs	r2, r2, #0
	b	.L4
.L7:
	cmp	r1, #1
	bne	.L8
	movs	r1, #0
	strb	r1, [r2]
	movs	r2, #32
	strh	r2, [r3, #46]
	b	.L8
.L6:
	movs	r3, r4
	adds	r3, r3, #96
	strb	r2, [r3]
	b	.L9
.L12:
	.align	2
.L11:
	.word	GetValueFromEasingFunction
	.word	gProc_SaveMenu
	.word	ProcFind
	.word	gPaletteBuffer
	.word	CopyToPaletteBuffer
	.word	DrawDifficultyModeText
	.word	BreakProcLoop
	.size	IMM_swapSpritesLoop, .-IMM_swapSpritesLoop
	.align	1
	.global	IMM_modeSelectKeyHandler
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_modeSelectKeyHandler, %function
IMM_modeSelectKeyHandler:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, lr}
	ldr	r3, .L29
	ldrh	r1, [r3, #6]
	movs	r4, r0
	movs	r2, #192
	movs	r0, r1
	ands	r0, r2
	tst	r1, r2
	beq	.L16
	movs	r5, r4
	movs	r3, #1
	adds	r5, r5, #48
	ldrb	r2, [r5]
	eors	r3, r2
	strb	r3, [r5]
	ldr	r3, .L29+4
	adds	r3, r3, #65
	ldrb	r3, [r3]
	lsls	r3, r3, #30
	bmi	.L17
	movs	r0, #102
	ldr	r3, .L29+8
	bl	.L14
.L17:
	ldr	r0, [r4, #52]
	movs	r2, r0
	ldrb	r3, [r5]
	ldr	r1, .L29+12
	adds	r2, r2, #43
	strb	r3, [r2]
	lsls	r3, r3, #2
	adds	r2, r1, r3
	ldrb	r2, [r2, #1]
	lsls	r2, r2, #24
	ldrsb	r1, [r3, r1]
	asrs	r2, r2, #24
	ldr	r3, .L29+16
	bl	.L14
	movs	r0, r4
	ldr	r3, .L29+20
.L28:
	bl	.L14
.L15:
	@ sp needed
	pop	{r4, r5, r6}
	pop	{r0}
	bx	r0
.L16:
	ldrh	r2, [r3, #8]
	movs	r3, #2
	movs	r1, r2
	ands	r1, r3
	tst	r2, r3
	beq	.L19
	ldr	r2, .L29+4
	adds	r2, r2, #65
	ldrb	r2, [r2]
	str	r0, [r4, #44]
	tst	r2, r3
	bne	.L20
	movs	r0, #107
	ldr	r3, .L29+8
	bl	.L14
.L20:
	movs	r0, r4
	ldr	r3, .L29+24
	b	.L28
.L19:
	movs	r0, #9
	tst	r2, r0
	beq	.L15
	ldr	r2, .L29+4
	adds	r2, r2, #65
	ldrb	r2, [r2]
	str	r1, [r4, #44]
	tst	r2, r3
	bne	.L21
	ldr	r3, .L29+8
	adds	r0, r0, #97
	bl	.L14
.L21:
	ldr	r3, .L29+28
	ldr	r0, .L29+32
	bl	.L14
	movs	r3, r4
	adds	r3, r3, #48
	ldrb	r3, [r3]
	adds	r0, r0, #61
	cmp	r3, #0
	beq	.L23
	cmp	r3, #1
	beq	.L23
.L24:
	movs	r1, #1
	movs	r0, r4
	ldr	r3, .L29+36
	bl	.L14
	b	.L15
.L23:
	strb	r3, [r0]
	b	.L24
.L30:
	.align	2
.L29:
	.word	gKeyState
	.word	gChapterData
	.word	m4aSongNumStart
	.word	IMM_difficultyCursorMove
	.word	updateDifficultySprites
	.word	DrawDifficultyModeText
	.word	BreakProcLoop
	.word	ProcFind
	.word	gProc_SaveMenu
	.word	ProcGoto
	.size	IMM_modeSelectKeyHandler, .-IMM_modeSelectKeyHandler
	.align	1
	.global	IMM_loadPals
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_loadPals, %function
IMM_loadPals:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r0, r1, r2, r4, r5, r6, r7, lr}
	movs	r5, #0
	movs	r7, #32
	str	r0, [sp, #4]
.L39:
	ldr	r3, .L46
	ldrb	r4, [r3, r5]
	movs	r3, #4
	asrs	r4, r4, #4
	ands	r4, r3
	ldr	r3, .L46+4
	ldrb	r2, [r3, r5]
	ldr	r3, .L46+8
	lsls	r1, r5, #3
	adds	r0, r3, r1
	ldrb	r0, [r0, #2]
	lsls	r0, r0, #26
	bmi	.L32
	cmp	r2, #1
	bne	.L33
	adds	r2, r2, #15
.L44:
	orrs	r4, r2
.L34:
	adds	r3, r3, r1
	ldrb	r3, [r3, #2]
	lsls	r3, r3, #25
	bpl	.L37
	movs	r3, #8
	orrs	r4, r3
.L37:
	ldr	r3, [sp, #4]
	cmp	r3, r5
	beq	.L38
	movs	r3, #2
	orrs	r4, r3
.L38:
	lsls	r6, r5, #1
	movs	r1, r6
	movs	r0, #1
	ldr	r3, .L46+12
	adds	r1, r1, #26
	orrs	r0, r4
	bl	.L14
	movs	r1, r6
	movs	r0, #247
	ldr	r3, .L46+12
	adds	r1, r1, #27
	ands	r0, r4
	adds	r5, r5, #1
	bl	.L14
	cmp	r5, #3
	bne	.L39
	@ sp needed
	ldr	r3, .L46+16
	bl	.L14
	pop	{r0, r1, r2, r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L33:
	cmp	r2, #2
	bne	.L35
.L36:
	orrs	r4, r7
	b	.L34
.L35:
	cmp	r2, #3
	bne	.L34
.L45:
	adds	r2, r2, #61
	b	.L44
.L32:
	cmp	r2, #3
	bne	.L36
	b	.L45
.L47:
	.align	2
.L46:
	.word	gUnknown_02000940
	.word	gUnknown_02000944
	.word	gUnknown_02000948
	.word	loadDifficultyPal
	.word	EnablePaletteSync
	.size	IMM_loadPals, .-IMM_loadPals
	.align	1
	.global	IMM_drawDifficultySpritesInit
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_drawDifficultySpritesInit, %function
IMM_drawDifficultySpritesInit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r1, r0
	movs	r2, #3
	adds	r1, r1, #41
	ldrb	r3, [r1]
	bics	r3, r2
	push	{r4, lr}
	strb	r3, [r1]
	@ sp needed
	movs	r3, r0
	movs	r2, #0
	adds	r3, r3, #42
	strb	r2, [r3]
	movs	r1, #232
	movs	r3, #8
	str	r2, [r0, #44]
	strh	r3, [r0, #62]
	adds	r2, r2, #64
	ldr	r0, .L49
	ldr	r3, .L49+4
	lsls	r1, r1, #2
	bl	.L14
	pop	{r4}
	pop	{r0}
	bx	r0
.L50:
	.align	2
.L49:
	.word	144735256
	.word	CopyToPaletteBuffer
	.size	IMM_drawDifficultySpritesInit, .-IMM_drawDifficultySpritesInit
	.align	1
	.global	IMM_drawDifficultySpritesLoop
	.syntax unified
	.code	16
	.thumb_func
	.fpu softvfp
	.type	IMM_drawDifficultySpritesLoop, %function
IMM_drawDifficultySpritesLoop:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r2, r0
	push	{r4, r5, r6, r7, lr}
	ldr	r3, [r0, #20]
	sub	sp, sp, #52
	str	r3, [sp, #28]
	adds	r2, r2, #42
	ldrb	r3, [r2]
	adds	r3, r3, #1
	strb	r3, [r2]
	ldr	r3, [sp, #28]
	adds	r3, r3, #99
	ldrb	r7, [r3]
	movs	r5, r0
	cmp	r7, #0
	bne	.L52
	ldr	r3, .L63
	str	r3, [sp, #36]
	ldr	r3, .L63+4
	str	r3, [sp, #40]
	ldr	r3, .L63+8
	str	r3, [sp, #44]
.L60:
	movs	r3, #3
	b	.L61
.L52:
	cmp	r7, #1
	beq	.LCB507
	b	.L58	@long jump
.LCB507:
	ldr	r3, .L63+12
	str	r3, [sp, #36]
	ldr	r3, .L63+16
	str	r3, [sp, #40]
	movs	r3, #2
	adds	r7, r7, #2
.L61:
	str	r3, [sp, #20]
	movs	r3, #128
	movs	r2, #4
	lsls	r3, r3, #6
	movs	r0, r2
	ldr	r4, .L63+20
	movs	r1, #56
	str	r3, [sp]
	ldr	r3, .L63+24
	bl	.L65
	movs	r3, #128
	movs	r2, #4
	lsls	r3, r3, #7
	movs	r0, r2
	str	r3, [sp]
	movs	r1, #56
	ldr	r3, .L63+28
	bl	.L65
	movs	r4, #6
	movs	r2, #160
	ldr	r3, [sp, #20]
	lsls	r2, r2, #23
	subs	r4, r4, r3
	lsls	r3, r7, #29
	adds	r3, r3, r2
	lsrs	r3, r3, #16
	str	r3, [sp, #12]
	movs	r3, #0
	lsls	r4, r4, #20
	str	r3, [sp, #16]
	lsrs	r4, r4, #16
.L56:
	ldrh	r6, [r5, #62]
	lsls	r6, r6, #23
	lsrs	r3, r6, #23
	str	r3, [sp, #24]
	movs	r3, r5
	adds	r3, r3, #43
	ldrb	r3, [r3]
	ldr	r2, [sp, #16]
	cmp	r3, r2
	bne	.L54
	ldr	r3, [sp, #12]
.L62:
	movs	r2, r4
	movs	r0, #4
	str	r3, [sp]
	ldr	r1, [sp, #24]
	ldr	r3, .L63+32
	ldr	r6, .L63+20
	bl	.L66
	ldr	r3, [sp, #16]
	lsls	r2, r3, #2
	movs	r3, #128
	lsls	r3, r3, #7
	str	r3, [sp]
	add	r3, sp, #36
	ldr	r3, [r2, r3]
	movs	r0, #4
	movs	r2, r4
	ldr	r1, [sp, #24]
	ldr	r6, .L63+20
	bl	.L66
	movs	r2, #128
	lsls	r2, r2, #6
	mov	ip, r2
	ldr	r3, [sp, #16]
	adds	r3, r3, #1
	str	r3, [sp, #16]
	ldr	r3, [sp, #12]
	add	r3, r3, ip
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	str	r3, [sp, #12]
	adds	r4, r4, #32
	ldr	r3, [sp, #20]
	ldr	r2, [sp, #16]
	lsls	r4, r4, #16
	lsrs	r4, r4, #16
	cmp	r3, r2
	bne	.L56
	movs	r3, r5
	adds	r3, r3, #43
	ldrb	r1, [r3]
	adds	r1, r7, r1
	subs	r3, r3, #1
	lsls	r1, r1, #24
	ldrb	r0, [r3]
	lsrs	r1, r1, #24
	ldr	r3, .L63+36
	bl	.L14
	ldr	r3, [sp, #28]
	adds	r3, r3, #96
	ldrb	r3, [r3]
	cmp	r3, #0
	bne	.L51
	movs	r0, r5
	ldr	r3, .L63+40
	bl	.L14
.L51:
	add	sp, sp, #52
	@ sp needed
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L58:
	movs	r7, #0
	b	.L60
.L54:
	movs	r2, #128
	ldr	r3, [sp, #12]
	lsls	r2, r2, #5
	adds	r3, r3, r2
	lsls	r3, r3, #16
	lsrs	r3, r3, #16
	b	.L62
.L64:
	.align	2
.L63:
	.word	144837328
	.word	144837348
	.word	144837362
	.word	IMM_classicTextOAM
	.word	IMM_ironTextOAM
	.word	ObjInsert
	.word	144837280
	.word	144837294
	.word	144837314
	.word	DifficultyMenuSelectedPaletteLoop
	.word	DrawDifficultyMenuCursor
	.size	IMM_drawDifficultySpritesLoop, .-IMM_drawDifficultySpritesLoop
	.global	IMM_difficultySelectProc
	.section	.rodata.str1.1,"aMS",%progbits,1
.LC30:
	.ascii	"IMM_difficultySelectProc\000"
	.global	BITPACKED
	.section	.rodata
	.align	2
	.type	IMM_difficultySelectProc, %object
	.size	IMM_difficultySelectProc, 240
IMM_difficultySelectProc:
	.short	1
	.short	0
	.word	.LC30
	.short	4
	.short	0
	.word	134922361
	.short	2
	.short	0
	.word	134927797
	.short	14
	.short	0
	.word	0
	.short	2
	.short	0
	.word	IMM_difficultySelectInit
	.short	2
	.short	0
	.word	134922665
	.short	14
	.short	1
	.word	0
	.short	2
	.short	0
	.word	134927833
	.short	24
	.short	8
	.word	NewFadeIn
	.short	20
	.short	0
	.word	FadeInExists
	.short	11
	.short	0
	.word	0
	.short	3
	.short	0
	.word	134922889
	.short	11
	.short	3
	.word	0
	.short	2
	.short	0
	.word	IMM_swapSpritesInit
	.short	3
	.short	0
	.word	IMM_swapSpritesLoop
	.short	3
	.short	0
	.word	IMM_swapSpritesLoop
	.short	14
	.short	1
	.word	0
	.short	3
	.short	0
	.word	IMM_modeSelectKeyHandler
	.short	2
	.short	0
	.word	IMM_swapSpritesInit
	.short	3
	.short	0
	.word	IMM_swapSpritesLoop
	.short	3
	.short	0
	.word	IMM_swapSpritesLoop
	.short	14
	.short	1
	.word	0
	.short	12
	.short	0
	.word	0
	.short	11
	.short	1
	.word	0
	.short	14
	.short	10
	.word	0
	.short	11
	.short	2
	.word	0
	.short	24
	.short	8
	.word	NewFadeOut
	.short	20
	.short	0
	.word	FadeOutExists
	.short	2
	.short	0
	.word	134923229
	.short	0
	.short	0
	.word	0
	.bss
	.align	2
	.type	BITPACKED, %object
	.size	BITPACKED, 8
BITPACKED:
	.space	8
	.ident	"GCC: (devkitARM release 55) 10.2.0"
	.text
	.code 16
	.align	1
.L14:
	bx	r3
.L65:
	bx	r4
.L66:
	bx	r6
.L13:
	bx	r7
