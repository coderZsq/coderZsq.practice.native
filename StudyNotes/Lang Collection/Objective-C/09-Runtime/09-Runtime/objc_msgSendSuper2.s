; ===========================================================================

	ENTRY _objc_msgSendSuper2
	UNWIND _objc_msgSendSuper2, NoFrame
	MESSENGER_START

	ldp	x0, x16, [x0]		// x0 = real receiver, x16 = class
	ldr	x16, [x16, #SUPERCLASS]	// x16 = class->superclass
	CacheLookup NORMAL

	END_ENTRY _objc_msgSendSuper2

; ===========================================================================