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
; void GBARam_MarkAsUsed(MallocHeader* block);
GBARam_MarkAsUsed__FP19struct_MallocHeader PROC
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
; void GBARam_AddToFreeList(MallocHeader* block);
; Hand-made
GBARam_AddToFreeList__FP19struct_MallocHeader PROC
        LDR      r3, |GBARam_LocalVars| + 4
        PUSH	 {r4,r5}
        LDR		 r1,[r3,#0]
        MOV		 r4,#0
        CMP		 r1,#0
        BEQ		 |GBARam_AddToFreeList_NULLBRANCH|
        MOV		 r5,#0x7f
        LSL		 r5,r5,#0x19
        ADD		 r2,r1,r5
        ASR		 r2,r2,#2
        STRH	 r2,[r0,#8]
        ADD		 r2,r0,r5
        ASR		 r2,r2,#2
        STRH	 r2,[r1,#0xa]
        B		 |GBARam_AddToFreeList_END|
|GBARam_AddToFreeList_NULLBRANCH|
        STRH	 r4,[r0,#0x8]
|GBARam_AddToFreeList_END|
        STRH	 r4,[r0,#0xa]
        STR		 r0,[r3,#0]
        POP		 {r4,r5}
        BX		 lr
    ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void GBARam_MergeWithNext(MallocHeader* dst, MallocHeader* src);
; Hand-made
GBARam_MergeWithNext__FP19struct_MallocHeader PROC
        LDRH	 r2,[r0,#0x2]
        LDRH	 r3,[r1,#0x2]
        ADD		 r2,r2,r3
        ADD		 r2,#0x2
        STRH	 r2,[r0,#0x2]
        LDRH	 r2,[r1,#0x0]
        STRH	 r2,[r0,#0x0]
        LDRH	 r0,[r1,#0x0]
        CMP		 r0,#0x0
        BEQ		 |GBARam_MergeWithNext_END|
        MOV		 r2,#0x1
        LDRH	 r1,[r1,#0x4]
        LSL		 r2,r2,#0x19
        LSL		 r0,r0,#0x2
        ADD		 r0,r0,r2
        STRH	 r1,[r0,#0x4]
|GBARam_MergeWithNext_END|
        BX		 lr
    ENDP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; void GBARam_MergeWithNextFree(MallocHeader* dst, MallocHeader* src);
; Hand-made
GBARam_MergeWithNextFree__FP19struct_MallocHeader PROC
        PUSH	 {r4,r5}
        LDRH	 r3,[r0,#0x2]
        LDRH	 r4,[r1,#0x2]
        LDRH	 r2,[r1,#0x4]
        ADD		 r3,r3,r4
        ADD		 r3,#0x2
        STRH	 r3,[r0,#0x2]
        LDRH	 r3,[r1,#0x0]
        MOV		 r4,#0x1
        LSL		 r4,r4,#0x19
        STRH	 r3,[r0,#0x0]
        LDRH	 r3,[r1,#0x0]
        CMP		 r3,#0x0
        BEQ		 |GBARam_MergeWithNextFree_HAS_NEXT|
        LDRH	 r5,[r1,#0x4]
        LSL		 r3,r3,#0x2
        ADD		 r3,r3,r4
        STRH	 r5,[r3,#0x4]
|GBARam_MergeWithNextFree_HAS_NEXT|
        LDRH	 r3,[r1,#0xa]
        STRH	 r3,[r0,#0xa]
        LDRH	 r3,[r1,#0xa]
        CMP		 r3,#0x0
        BEQ		 |GBARam_MergeWithNextFree_LAST_FREE_EXISTS|
        LSL		 r3,r3,#0x2
        ADD		 r3,r3,r4
        STRH	 r2,[r3,#0x8]
        B		 |GBARam_MergeWithNextFree_UPDATE_NEXT_FREE|
|GBARam_MergeWithNextFree_LAST_FREE_EXISTS|
        LDR      r3, |GBARam_LocalVars| + 4
        STR      r0, [r3,#0x0]
|GBARam_MergeWithNextFree_UPDATE_NEXT_FREE|
        LDRH	 r3,[r1,#0x8]
        STRH	 r3,[r0,#0x8]
        LDRH	 r0,[r1,#0x8]
        CMP		 r0,#0x0
        BEQ		 |GBARam_MergeWithNextFree_END|
        LSL		 r0,r0,#0x2
        ADD		 r0,r0,r4
        STRH	 r2,[r0,#0xa]
|GBARam_MergeWithNextFree_END|
        POP		 {r4,r5}
        BX		 lr
    ENDP
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