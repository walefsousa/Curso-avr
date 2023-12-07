
_CAPTURA:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;modo_captura.c,42 :: 		void CAPTURA() iv IVT_ADDR_TIMER1_CAPT ics ICS_AUTO
;modo_captura.c,45 :: 		ICES1_bit = ~ICES1_bit;
	PUSH       R2
	PUSH       R3
	LDS        R0, ICES1_bit+0
	LDI        R27, BitMask(ICES1_bit+0)
	EOR        R0, R27
	STS        ICES1_bit+0, R0
;modo_captura.c,47 :: 		if(ICES1_bit)
	LDS        R27, ICES1_bit+0
	SBRS       R27, BitPos(ICES1_bit+0)
	JMP        L_CAPTURA0
;modo_captura.c,49 :: 		valor1 = (ICR1H<<8) + ICR1L;
	LDS        R16, ICR1H+0
	MOV        R19, R16
	CLR        R18
	LDS        R16, ICR1L+0
	LDI        R17, 0
	ADD        R16, R18
	ADC        R17, R19
	STS        _valor1+0, R16
	STS        _valor1+1, R17
;modo_captura.c,51 :: 		}//end if
	JMP        L_CAPTURA1
L_CAPTURA0:
;modo_captura.c,55 :: 		valor2 = (ICR1H<<8) + ICR1L;
	LDS        R16, ICR1H+0
	MOV        R19, R16
	CLR        R18
	LDS        R16, ICR1L+0
	LDI        R17, 0
	ADD        R16, R18
	ADC        R17, R19
	STS        _valor2+0, R16
	STS        _valor2+1, R17
;modo_captura.c,57 :: 		distancia = abs(valor2 - valor1)/58;
	LDS        R0, _valor1+0
	LDS        R1, _valor1+1
	SUB        R16, R0
	SBC        R17, R1
	MOVW       R2, R16
	CALL       _abs+0
	LDI        R20, 58
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
	STS        _distancia+0, R16
	STS        _distancia+1, R17
;modo_captura.c,59 :: 		resultado = media();
	CALL       _media+0
	STS        _resultado+0, R16
	STS        _resultado+1, R17
;modo_captura.c,61 :: 		}//end else
L_CAPTURA1:
;modo_captura.c,64 :: 		}//end captura
L_end_CAPTURA:
	POP        R3
	POP        R2
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _CAPTURA

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;modo_captura.c,66 :: 		void main()
;modo_captura.c,69 :: 		DDRB = 0xFE;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, 254
	OUT        DDRB+0, R27
;modo_captura.c,70 :: 		DDRD = 0xFF;
	LDI        R27, 255
	OUT        DDRD+0, R27
;modo_captura.c,72 :: 		led = 0;
	IN         R27, PORTD+0
	CBR        R27, 16
	OUT        PORTD+0, R27
;modo_captura.c,74 :: 		SREG = 0x80;
	LDI        R27, 128
	OUT        SREG+0, R27
;modo_captura.c,76 :: 		ICES1_bit = 1;
	LDS        R27, ICES1_bit+0
	SBR        R27, BitMask(ICES1_bit+0)
	STS        ICES1_bit+0, R27
;modo_captura.c,77 :: 		CS10_bit = 1;
	LDS        R27, CS10_bit+0
	SBR        R27, BitMask(CS10_bit+0)
	STS        CS10_bit+0, R27
;modo_captura.c,78 :: 		ICIE1_bit = 1;
	LDS        R27, ICIE1_bit+0
	SBR        R27, BitMask(ICIE1_bit+0)
	STS        ICIE1_bit+0, R27
;modo_captura.c,80 :: 		Lcd_Init();
	CALL       _Lcd_Init+0
;modo_captura.c,82 :: 		Lcd_cmd(_LCD_CURSOR_OFF);
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;modo_captura.c,84 :: 		Lcd_Out(1,4,"Distancia");
	LDI        R27, #lo_addr(?lstr1_modo_captura+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_modo_captura+0)
	MOV        R5, R27
	LDI        R27, 4
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;modo_captura.c,85 :: 		Lcd_Out(2,13,"Cm");
	LDI        R27, #lo_addr(?lstr2_modo_captura+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_modo_captura+0)
	MOV        R5, R27
	LDI        R27, 13
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;modo_captura.c,87 :: 		while(1)
L_main2:
;modo_captura.c,89 :: 		pulso();
	CALL       _pulso+0
;modo_captura.c,91 :: 		IntToStr(resultado, txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDS        R2, _resultado+0
	LDS        R3, _resultado+1
	CALL       _IntToStr+0
;modo_captura.c,93 :: 		Lcd_out(2,2, txt);
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;modo_captura.c,95 :: 		}//end while
	JMP        L_main2
;modo_captura.c,97 :: 		}//end main
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_pulso:

;modo_captura.c,98 :: 		void pulso()
;modo_captura.c,100 :: 		led = 1;
	IN         R27, PORTD+0
	SBR        R27, 16
	OUT        PORTD+0, R27
;modo_captura.c,101 :: 		delay_us(1);
	LDI        R16, 2
L_pulso4:
	DEC        R16
	BRNE       L_pulso4
	NOP
	NOP
;modo_captura.c,102 :: 		led = 0;
	IN         R27, PORTD+0
	CBR        R27, 16
	OUT        PORTD+0, R27
;modo_captura.c,103 :: 		}
L_end_pulso:
	RET
; end of _pulso

_media:

;modo_captura.c,105 :: 		int media(){
;modo_captura.c,107 :: 		unsigned char i = 15;
; i start address is: 22 (R22)
; i start address is: 22 (R22)
	LDI        R22, 15
; i end address is: 22 (R22)
;modo_captura.c,109 :: 		do{
	JMP        L_media6
L__media9:
;modo_captura.c,114 :: 		while (i!=0);
;modo_captura.c,109 :: 		do{
L_media6:
;modo_captura.c,110 :: 		x1[i] = x1[i-1];
; i start address is: 22 (R22)
	MOV        R18, R22
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDI        R16, #lo_addr(_x1+0)
	LDI        R17, hi_addr(_x1+0)
	MOVW       R20, R18
	ADD        R20, R16
	ADC        R21, R17
	MOV        R16, R22
	LDI        R17, 0
	SUBI       R16, 1
	SBCI       R17, 0
	MOVW       R18, R16
	LSL        R18
	ROL        R19
	LDI        R16, #lo_addr(_x1+0)
	LDI        R17, hi_addr(_x1+0)
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LD         R16, Z+
	LD         R17, Z+
	MOVW       R30, R20
	ST         Z+, R16
	ST         Z+, R17
;modo_captura.c,111 :: 		y1 += x1[i];
	MOV        R18, R22
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDI        R16, #lo_addr(_x1+0)
	LDI        R17, hi_addr(_x1+0)
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LD         R18, Z+
	LD         R19, Z+
	LDS        R16, _y1+0
	LDS        R17, _y1+1
	ADD        R16, R18
	ADC        R17, R19
	STS        _y1+0, R16
	STS        _y1+1, R17
;modo_captura.c,112 :: 		i--;
	MOV        R16, R22
	SUBI       R16, 1
	MOV        R22, R16
; i end address is: 22 (R22)
;modo_captura.c,114 :: 		while (i!=0);
	CPI        R16, 0
	BREQ       L__media17
	JMP        L__media9
L__media17:
; i end address is: 22 (R22)
;modo_captura.c,116 :: 		x1[0] = distancia;
	LDS        R18, _distancia+0
	LDS        R19, _distancia+1
	STS        _x1+0, R18
	STS        _x1+1, R19
;modo_captura.c,117 :: 		return y1 = (y1 + x1[0])/16;
	LDS        R16, _y1+0
	LDS        R17, _y1+1
	ADD        R16, R18
	ADC        R17, R19
	LSR        R17
	ROR        R16
	LSR        R17
	ROR        R16
	LSR        R17
	ROR        R16
	LSR        R17
	ROR        R16
	STS        _y1+0, R16
	STS        _y1+1, R17
;modo_captura.c,118 :: 		}//end media
L_end_media:
	RET
; end of _media
