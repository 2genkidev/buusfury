	CODE16
	AREA GBARam, CODE, READONLY
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; tcpp -S -c -cpu ARM7TDMI -O1 src/GBARam.c
; For now, just assembly because of alignment issues.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void GBARam_Init(void);
GBARam_Init__Fv PROC
		LDR      r0,|GBARam_LocalVars|
		LDR      r1,|GBARam_LocalVars| + 4
		LDR      r2,|GBARam_LocalVars| + 8
		STR      r0,[r1,#0]
		MOV      r1,#0
		STRH     r1,[r0,#0]
		STRH     r2,[r0,#2]
		STRH     r1,[r0,#4]
		STRB     r1,[r0,#6]
		STRH     r1,[r0,#8]
		STRH     r1,[r0,#0xa]
		BX       lr
	ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void GBARam_UpdateBlockLinks(MallocHeader* block);
GBARam_UpdateBlockLinks__FP19struct_MallocHeader PROC
        MOV      r1,#1
        STRB     r1,[r0,#6]
        LDRH     r2,[r0,#0xa]
        LSL      r3,r1,#25
        LDRH     r1,[r0,#8]
        CMP      r2,#0
        BEQ      |L1.46|
        LSL      r2,r2,#2
        ADD      r2,r2,r3
        STRH     r1,[r2,#8]
        B        |L1.64|
|L1.46|
        LDR      r2,|GBARam_LocalVars| + 4
        CMP      r1,#0
        BEQ      |L1.60|
        LSL      r1,r1,#2
        ADD      r1,r1,r3
        STR      r1,[r2,#0]
        B        |L1.64|
|L1.60|
        MOV      r1,#0
        STR      r1,[r2,#0]
|L1.64|
        LDRH     r1,[r0,#8]
        CMP      r1,#0
        BEQ      |L1.78|
        LDRH     r0,[r0,#0xa]
        LSL      r1,r1,#2
        ADD      r1,r1,r3
        STRH     r0,[r1,#0xa]
|L1.78|
        BX       lr
	ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void GBARam_FreeBlock(MallocHeader* block);
; Hand-made
GBARam_FreeBlock__FP19struct_MallocHeader PROC
		LDR      r3, |GBARam_LocalVars| + 4
		PUSH	 {r4,r5}
		LDR		 r1,[r3,#0]
		MOV		 r4,#0
		CMP		 r1,#0
		BEQ		 |GBARam_FreeBlock_NULLBRANCH|
		MOV		 r5,#0x7f
		LSL		 r5,r5,#0x19
		ADD		 r2,r1,r5
		ASR		 r2,r2,#2
		STRH	 r2,[r0,#8]
		ADD		 r2,r0,r5
		ASR		 r2,r2,#2
		STRH	 r2,[r1,#0xa]
		B		 |GBARam_FreeBlock_END|
|GBARam_FreeBlock_NULLBRANCH|
		STRH	 r4,[r0,#0x8]
|GBARam_FreeBlock_END|
		STRH	 r4,[r0,#0xa]
		STR		 r0,[r3,#0]
		POP		 {r4,r5}
		BX		 lr
	ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|GBARam_MergeBlocks|
		INCBIN		baserom.gba_0x03d548_0x03d5b8.extracted
|GBARam_Malloc|
		INCBIN		baserom.gba_0x03d5b8_0x03d63c.extracted		
|GBARam_Free|
		INCBIN		baserom.gba_0x03d63c_0x03d730.extracted	
|GBARam_LocalVars| DATA
        DCD      0x02000800
        DCD      0x03003488
        DCD      0x0000fdfe
		DCD      0x7fffffff
	END