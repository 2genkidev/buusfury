	AREA Head, CODE, READONLY   		; name this block of code
	ENTRY                       		; mark first instruction to execute
		B         	Init
		INCBIN 	  	baserom.gba_0x04_0xA0.extracted

		DCB			"DBZBUUSFURY",0
		DCB			"BG3E"
		DCB			"70"
		DCB			0x96
		DCB			0
		DCB			0
		DCB			0,0,0,0,0,0,0
		DCB			0
		DCB			0x84
		DCB			0,0

	END