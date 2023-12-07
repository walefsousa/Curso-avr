
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;Display_7_seg.c,16 :: 		void main()
;Display_7_seg.c,18 :: 		DDRD = 0xFF;               //Todo
	LDI        R27, 255
	OUT        DDRD+0, R27
;Display_7_seg.c,19 :: 		PORTD = 0x00;
	LDI        R27, 0
	OUT        PORTD+0, R27
;Display_7_seg.c,21 :: 		while(1)
L_main0:
;Display_7_seg.c,24 :: 		i++;
	LDS        R16, _i+0
	MOV        R17, R16
	SUBI       R17, 255
	STS        _i+0, R17
;Display_7_seg.c,26 :: 		if(i > 9) i = 0;
	LDI        R16, 9
	CP         R16, R17
	BRLO       L__main6
	JMP        L_main2
L__main6:
	LDI        R27, 0
	STS        _i+0, R27
L_main2:
;Display_7_seg.c,28 :: 		PORTD = matriz[i];
	LDI        R17, #lo_addr(_matriz+0)
	LDI        R18, hi_addr(_matriz+0)
	LDS        R16, _i+0
	MOV        R30, R16
	LDI        R31, 0
	ADD        R30, R17
	ADC        R31, R18
	LPM        R16, Z
	OUT        PORTD+0, R16
;Display_7_seg.c,30 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main3:
	DEC        R16
	BRNE       L_main3
	DEC        R17
	BRNE       L_main3
	DEC        R18
	BRNE       L_main3
;Display_7_seg.c,32 :: 		}//end while
	JMP        L_main0
;Display_7_seg.c,34 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
