*** First throw call stack:
(
	0   CoreFoundation                      0x000000010cbfc6fb __exceptionPreprocess + 331
	1   libobjc.A.dylib                     0x000000010c109ac5 objc_exception_throw + 48
	2   CoreFoundation                      0x000000010cc1aab4 -[NSObject(NSObject) doesNotRecognizeSelector:] + 132
	3   CoreFoundation                      0x000000010cc01443 ___forwarding___ + 1443
	4   CoreFoundation                      0x000000010cc03238 _CF_forwarding_prep_0 + 120
	5   09-Runtime                          0x000000010b83084f main + 95
	6   libdyld.dylib                       0x000000010e519541 start + 1
)
libc++abi.dylib: terminating with uncaught exception of type NSException

; ===========================================================================

	ENTRY __objc_msgForward

	adrp	x17, __objc_forward_handler@PAGE
	ldr	x17, [x17, __objc_forward_handler@PAGEOFF]
	br	x17
	
	END_ENTRY __objc_msgForward

; ===========================================================================

	STATIC_ENTRY __objc_msgForward_impcache

	MESSENGER_START
	nop
	MESSENGER_END_SLOW

	// No stret specialization.
	b	__objc_msgForward

	END_ENTRY __objc_msgForward_impcache

; ===========================================================================