	INCLUDE		rom_header.s
	AREA Init, CODE, READONLY   		

		mov         r0, #0x92                
											 
		msr         cpsr_c, r0               
											
		ldr         sp, irq_stack_addr       
		mov         r0, #0x1f                
		msr         cpsr_c, r0               
											
		ldr         sp, sys_stack_addr      

		; Initializing display and sound hardware
		mov         r0, #0x4000000          
		ldr         r1, display_control     
		str         r1, [r0, #0x204]        

		mov         r1, #0x0                
		stmdb       sp!, {r1}               

		str         sp, [r0, #0xD4]         
		ldr         r1, sound_control       
		str         r1, [r0, #0xD8]         

		; Additional hardware configurations
		ldr         r1, hardware_conf_1     
		movs        r1, r1, lsr #2          
		orr         r1, r1, #0x85000000     
		strne       r1, [r0, #0xDC]         

		ldr         r1, hardware_conf_2     
		str         r1, [r0, #0xD4]         
		ldr         r1, hardware_conf_3     
		str         r1, [r0, #0xD8]         

		ldr         r1, hardware_conf_4     
		movs        r1, r1, lsr #2          
		orr        r1, r1, #0x84, 8         
		strne       r1, [r0, #0xDC]         

		add         sp, sp, #4              
		ldr         lr, jump_address        
		b           |MaybeStart|           	

irq_stack_addr	    DCD		0x03007FA0  	
sys_stack_addr	    DCD		0x03007E00  	
display_control		DCD		0x00004014  	
sound_control		DCD		0x03001004   	
hardware_conf_1		DCD		0x000042FB   	
hardware_conf_2		DCD		0x087B79A4   	
hardware_conf_3		DCD		0x03000000   	
hardware_conf_4		DCD		0x00001007   	
jump_address		DCD		0x0800419D   	

	END                         