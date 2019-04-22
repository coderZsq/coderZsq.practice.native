	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 12, 2	sdk_version 12, 2
	.globl	_haha                   ; -- Begin function haha
	.p2align	2
_haha:                                  ; @haha
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16             ; =16
	.cfi_def_cfa_offset 16
	orr	w8, wzr, #0x2
	str	w8, [sp, #12]
	orr	w8, wzr, #0x3
	str	w8, [sp, #8]
	add	sp, sp, #16             ; =16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_hehe                   ; -- Begin function hehe
	.p2align	2
_hehe:                                  ; @hehe
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32             ; =32
	stp	x29, x30, [sp, #16]     ; 8-byte Folded Spill
	add	x29, sp, #16            ; =16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	orr	w8, wzr, #0x4
	stur	w8, [x29, #-4]
	mov	w8, #5
	str	w8, [sp, #8]
	bl	_haha
	ldp	x29, x30, [sp, #16]     ; 8-byte Folded Reload
	add	sp, sp, #32             ; =32
	ret
	.cfi_endproc
                                        ; -- End function

.subsections_via_symbols
