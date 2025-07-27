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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	AREA UnusedGBARam, CODE, READONLY
		CODE32
|GBARam_UnusedFunctionsAndTheirVariables|
		INCBIN		baserom.gba_0x03d740_0x03d784.extracted		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|Unknown__1|
		INCBIN		baserom.gba_0x03d784_0x049114.extracted
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	AREA AfterLibs, CODE, READONLY
		CODE32
|MaybeStart|
		LDR			R12, |FUN_08046aec_PTR|
		BX			R12
|FUN_08046aec_PTR|
		DCD			0x08046AED
|Unknown__2|
		INCBIN		baserom.gba_0x049120_0x055620.extracted
|bmp_intro_jcalg1|
		INCBIN		build\asset_intro.compressed
|PTR_DAT_080561c4|
		DCD			0x03003898
|PTR_DAT_080561c8|
		DCD			0x030038a4
|Region_TitlescreenMenu|
		DCD			0x00000050 ; Region.Min.x
		DCD			0x00000068 ; Region.Min.y
		DCD			0x000000A0 ; Region.Max.x
		DCD			0x00000090 ; Region.Max.y
|PTR_DAT_080561dc|
		DCD			0x03003300
|PTR_DAT_080561e0|
		DCD			0x03003898
|PTR_PTR_080561e4|
		DCD			0x0807012c
|PTR_PTR_080561e8|
		DCD			0x0806e050
|PTR_var_current_character_id_080561ec|
		DCD			0x03001068	; var_current_character_id
|PTR_DAT_080561f0|
		DCD			0x030019a4
|PTR_var_area_info_080561f4|
		DCD			0x0300197c	; var_area_info
|PTR_DAT_080561f8|
		DCD			0x03001c4c
		DCD			0x08080000
		DCD			0x00002000
		DCD			BMP_UNCOMPRESSED_TOP_LEFT_CORNER	; BMP_UNCOMPRESSED_TOP_LEFT_CORNER
		DCD			0x080800F7
		DCD			0x00002000
		DCD			BMP_UNCOMPRESSED_TOP_RIGHT_CORNER	; BMP_UNCOMPRESSED_TOP_RIGHT_CORNER
		DCD			0x0808E800
		DCD			0x00002000
		DCD			BMP_UNCOMPRESSED_BOTTOM_LEFT_CORNER	; BMP_UNCOMPRESSED_BOTTOM_LEFT_CORNER
		DCD			0x0808E8F7
		DCD			0x00002000
		DCD			BMP_UNCOMPRESSED_BOTTOM_RIGHT_CORNER	; BMP_UNCOMPRESSED_BOTTOM_RIGHT_CORNER
|BMP_UNCOMPRESSED_TOP_LEFT_CORNER|
		INCBIN		build\corner_top_left.img.bin
|BMP_UNCOMPRESSED_TOP_RIGHT_CORNER|
		INCBIN		build\corner_top_right.img.bin
|BMP_UNCOMPRESSED_BOTTOM_LEFT_CORNER|
		INCBIN		build\corner_bottom_left.img.bin
|BMP_UNCOMPRESSED_BOTTOM_RIGHT_CORNER|
		INCBIN		build\corner_bottom_right.img.bin
|PALETTES|	
		INCBIN		assets\palettes\bg.pal
		INCBIN		assets\palettes\sprite.pal
	END