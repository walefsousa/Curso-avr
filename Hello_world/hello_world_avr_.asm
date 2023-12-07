
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;hello_world_avr_.c,12 :: 		void main()
;hello_world_avr_.c,15 :: 		PORTB0_bit = 0;
	IN         R27, PORTB0_bit+0
	CBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;hello_world_avr_.c,16 :: 		DDRB.B0 = 1;
	IN         R27, DDRB+0
	SBR        R27, 1
	OUT        DDRB+0, R27
;hello_world_avr_.c,18 :: 		while(1)
L_main0:
;hello_world_avr_.c,20 :: 		PORTB0_bit ^= 1;
	IN         R0, PORTB0_bit+0
	LDI        R27, BitMask(PORTB0_bit+0)
	EOR        R0, R27
	OUT        PORTB0_bit+0, R0
;hello_world_avr_.c,21 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main2:
	DEC        R16
	BRNE       L_main2
	DEC        R17
	BRNE       L_main2
	DEC        R18
	BRNE       L_main2
;hello_world_avr_.c,23 :: 		}//end while
	JMP        L_main0
;hello_world_avr_.c,26 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
