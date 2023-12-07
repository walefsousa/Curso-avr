
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;contador_avr.c,31 :: 		void main()
;contador_avr.c,33 :: 		TCCR1B = 0x06;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 6
	STS        TCCR1B+0, R27
;contador_avr.c,35 :: 		DDD5_bit = 0;
	IN         R27, DDD5_bit+0
	CBR        R27, BitMask(DDD5_bit+0)
	OUT        DDD5_bit+0, R27
;contador_avr.c,37 :: 		Lcd_init();
	CALL       _Lcd_Init+0
;contador_avr.c,38 :: 		Lcd_Cmd(_LCD_CLEAR);
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;contador_avr.c,39 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;contador_avr.c,41 :: 		Lcd_Out(1,1, "Contador:");
	LDI        R27, #lo_addr(?lstr1_contador_avr+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_contador_avr+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;contador_avr.c,43 :: 		while(1)
L_main0:
;contador_avr.c,46 :: 		contador = (TCNT1H<<8) + TCNT1L;
	LDS        R16, TCNT1H+0
	MOV        R19, R16
	CLR        R18
	LDS        R16, TCNT1L+0
	LDI        R17, 0
	ADD        R16, R18
	ADC        R17, R19
	STS        _contador+0, R16
	STS        _contador+1, R17
;contador_avr.c,48 :: 		IntToStr(contador, txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;contador_avr.c,50 :: 		Lcd_Out(2,2, txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;contador_avr.c,53 :: 		}//end while
	JMP        L_main0
;contador_avr.c,56 :: 		}//end main
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
