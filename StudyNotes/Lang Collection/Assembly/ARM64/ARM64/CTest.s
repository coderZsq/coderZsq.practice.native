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

.subsections_via_symbols
