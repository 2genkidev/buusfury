;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Main Game ASM file.
; =====================================
;
; Everything that has not been properly decompiled will be put here first.
;
	AREA GameStart, CODE, READONLY 		; name this block of code
		CODE32
		INCLUDE 	crt0.s
		INCBIN 	  	baserom.gba_0x0158_0x3d4d0.extracted
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		INCLUDE		GBARam.s
	
|GBARam_UnusedFunctionsAndTheirVariables|
		INCBIN		baserom.gba_0x03d740_0x03d784.extracted		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|Unknown__1|
		INCBIN		baserom.gba_0x03d784_0x049114.extracted
	
	AREA AfterLibs, CODE, READONLY
		CODE32
|MaybeStart|
		LDR			R12, |FUN_08046aec_PTR|
		BX			R12
|FUN_08046aec_PTR|
		DCD			0x08046AED
|Unknown__2|
		INCBIN		baserom.gba_0x049120_0x055620.extracted
		INCBIN		build\asset_intro.compressed
		INCBIN		baserom.gba_0x0561c4_0x05792c.extracted
	END