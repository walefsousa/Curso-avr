
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;termometro_avr.c,24 :: 		void main()
;termometro_avr.c,26 :: 		DDD0_bit = 0;                      //apenas PC0 como entrada
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, DDD0_bit+0
	CBR        R27, BitMask(DDD0_bit+0)
	OUT        DDD0_bit+0, R27
;termometro_avr.c,28 :: 		Lcd_Init();                        // Inicializa o LCD
	CALL       _Lcd_Init+0
;termometro_avr.c,29 :: 		Lcd_Cmd(_LCD_CLEAR);               // limpa display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;termometro_avr.c,30 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          //desliga o cursor
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;termometro_avr.c,32 :: 		Lcd_Out(1,2,"Termometro");                //impreme no LCD
	LDI        R27, #lo_addr(?lstr1_termometro_avr+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_termometro_avr+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;termometro_avr.c,34 :: 		ADEN_bit = 1;                      //habilita os canais analógicos
	LDS        R27, ADEN_bit+0
	SBR        R27, BitMask(ADEN_bit+0)
	STS        ADEN_bit+0, R27
;termometro_avr.c,36 :: 		while(1)
L_main0:
;termometro_avr.c,38 :: 		valor = media();//ADC_Read(0);              //atribui na variável valor a leitura analógica
	CALL       _media+0
	STS        _valor+0, R16
	STS        _valor+1, R17
;termometro_avr.c,40 :: 		valor = (valor*500)>>10;
	LDI        R20, 244
	LDI        R21, 1
	CALL       _HWMul_16x16+0
	LDI        R27, 10
L__main9:
	ASR        R17
	ROR        R16
	DEC        R27
	BRNE       L__main9
L__main10:
	STS        _valor+0, R16
	STS        _valor+1, R17
;termometro_avr.c,42 :: 		intToStr(valor, txt);             //converte um inteiro para string
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;termometro_avr.c,44 :: 		Lcd_Out(2,2, txt);                //imprime txt no LCD
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;termometro_avr.c,46 :: 		Customchar(2,8);
	LDI        R27, 8
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _CustomChar+0
;termometro_avr.c,47 :: 		Lcd_Chr_cp('C');
	LDI        R27, 67
	MOV        R2, R27
	CALL       _Lcd_Chr_CP+0
;termometro_avr.c,49 :: 		}// end while
	JMP        L_main0
;termometro_avr.c,51 :: 		}//end main
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_CustomChar:

;termometro_avr.c,53 :: 		void CustomChar(char pos_row, char pos_char)
;termometro_avr.c,56 :: 		Lcd_Cmd(64);
	PUSH       R4
	PUSH       R2
	LDI        R27, 64
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
;termometro_avr.c,57 :: 		for (i = 0; i<=10; i++) Lcd_Chr_CP(character[i]);
; i start address is: 18 (R18)
	LDI        R18, 0
; i end address is: 18 (R18)
L_CustomChar2:
; i start address is: 18 (R18)
	LDI        R16, 10
	CP         R16, R18
	BRSH       L__CustomChar13
	JMP        L_CustomChar3
L__CustomChar13:
	LDI        R16, #lo_addr(_character+0)
	LDI        R17, hi_addr(_character+0)
	MOV        R30, R18
	LDI        R31, 0
	ADD        R30, R16
	ADC        R31, R17
	LPM        R16, Z
	PUSH       R18
	PUSH       R2
	MOV        R2, R16
	CALL       _Lcd_Chr_CP+0
	POP        R2
	POP        R18
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
; i end address is: 18 (R18)
	JMP        L_CustomChar2
L_CustomChar3:
;termometro_avr.c,58 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	PUSH       R2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
	POP        R2
;termometro_avr.c,59 :: 		Lcd_Chr(pos_row, pos_char, 0);
	PUSH       R2
	CLR        R4
	CALL       _Lcd_Chr+0
	POP        R2
;termometro_avr.c,61 :: 		}//end custonchar
L_end_CustomChar:
	POP        R4
	RET
; end of _CustomChar

_media:

;termometro_avr.c,63 :: 		int media()
;termometro_avr.c,65 :: 		int temp_rp = 0x00;
	PUSH       R2
; temp_rp start address is: 19 (R19)
	LDI        R19, 0
	LDI        R20, 0
;termometro_avr.c,68 :: 		for(i=0; i<100; i++)
; i start address is: 18 (R18)
	LDI        R18, 0
; temp_rp end address is: 19 (R19)
; i end address is: 18 (R18)
L_media5:
; i start address is: 18 (R18)
; temp_rp start address is: 19 (R19)
	CPI        R18, 100
	BRLO       L__media15
	JMP        L_media6
L__media15:
;termometro_avr.c,71 :: 		temp_rp += ADC_Read(0);
	PUSH       R20
	PUSH       R19
	PUSH       R18
	CLR        R2
	CALL       _ADC_Read+0
	POP        R18
	POP        R19
	POP        R20
	ADD        R16, R19
	ADC        R17, R20
	MOV        R19, R16
	MOV        R20, R17
;termometro_avr.c,68 :: 		for(i=0; i<100; i++)
	MOV        R16, R18
	SUBI       R16, 255
	MOV        R18, R16
;termometro_avr.c,73 :: 		}//end for
; i end address is: 18 (R18)
	JMP        L_media5
L_media6:
;termometro_avr.c,75 :: 		return(temp_rp/100);
	MOV        R16, R19
	MOV        R17, R20
	LDI        R20, 100
	LDI        R21, 0
	CALL       _Div_16x16_S+0
	MOVW       R16, R22
; temp_rp end address is: 19 (R19)
;termometro_avr.c,76 :: 		}
;termometro_avr.c,75 :: 		return(temp_rp/100);
;termometro_avr.c,76 :: 		}
L_end_media:
	POP        R2
	RET
; end of _media
