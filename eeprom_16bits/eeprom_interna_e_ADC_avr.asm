
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;eeprom_interna_e_ADC_avr.c,38 :: 		void main()
;eeprom_interna_e_ADC_avr.c,41 :: 		DDD0_bit = 0;                      //apenas PC0 como entrada
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, DDD0_bit+0
	CBR        R27, BitMask(DDD0_bit+0)
	OUT        DDD0_bit+0, R27
;eeprom_interna_e_ADC_avr.c,43 :: 		Lcd_Init();                        // Inicializa o LCD
	CALL       _Lcd_Init+0
;eeprom_interna_e_ADC_avr.c,44 :: 		Lcd_Cmd(_LCD_CLEAR);               // limpa display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;eeprom_interna_e_ADC_avr.c,45 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          //desliga o cursor
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;eeprom_interna_e_ADC_avr.c,47 :: 		Lcd_Out(1,6,"ADC");                //impreme no LCD
	LDI        R27, #lo_addr(?lstr1_eeprom_interna_e_ADC_avr+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_eeprom_interna_e_ADC_avr+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;eeprom_interna_e_ADC_avr.c,49 :: 		ADEN_bit = 1;                      //habilita os canais analógicos
	LDS        R27, ADEN_bit+0
	SBR        R27, BitMask(ADEN_bit+0)
	STS        ADEN_bit+0, R27
;eeprom_interna_e_ADC_avr.c,51 :: 		valor2 = rd_eeprom();
	CALL       _rd_eeprom+0
	STS        _valor2+0, R16
	STS        _valor2+1, R17
;eeprom_interna_e_ADC_avr.c,54 :: 		while(1)
L_main0:
;eeprom_interna_e_ADC_avr.c,57 :: 		value_old();
	CALL       _value_old+0
;eeprom_interna_e_ADC_avr.c,59 :: 		valor = ADC_Read(0);              //atribui na variável valor a leitura analógica
	CLR        R2
	CALL       _ADC_Read+0
	STS        _valor+0, R16
	STS        _valor+1, R17
;eeprom_interna_e_ADC_avr.c,61 :: 		IntToStr(valor, txt);             //converte um inteiro para string
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;eeprom_interna_e_ADC_avr.c,63 :: 		Lcd_Out(2,10, txt);               //imprime txt no LCD
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 10
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;eeprom_interna_e_ADC_avr.c,65 :: 		wr_eeprom(valor);                 //salva o valor como parametro
	LDS        R2, _valor+0
	LDS        R3, _valor+1
	CALL       _wr_eeprom+0
;eeprom_interna_e_ADC_avr.c,66 :: 		}
	JMP        L_main0
;eeprom_interna_e_ADC_avr.c,68 :: 		}//end while
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main

_wr_eeprom:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;eeprom_interna_e_ADC_avr.c,69 :: 		void wr_eeprom(int dado1)
;eeprom_interna_e_ADC_avr.c,73 :: 		dataH = dado1>>8;
	PUSH       R2
	PUSH       R3
	PUSH       R4
	MOV        R16, R3
	LDI        R17, 0
	SBRC       R16, 7
	LDI        R17, 255
	STD        Y+0, R16
;eeprom_interna_e_ADC_avr.c,74 :: 		dataL = dado1%256;
	LDI        R20, 0
	LDI        R21, 1
	MOVW       R16, R2
	CALL       _Div_16x16_S+0
	MOVW       R16, R24
	STD        Y+1, R16
;eeprom_interna_e_ADC_avr.c,76 :: 		EEPROM_Write(0x00, dataH);
	LDD        R4, Y+0
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Write+0
;eeprom_interna_e_ADC_avr.c,77 :: 		EEPROM_Write(0x01, dataL);
	LDD        R4, Y+1
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Write+0
;eeprom_interna_e_ADC_avr.c,79 :: 		delay_ms(20);
	LDI        R17, 208
	LDI        R16, 202
L_wr_eeprom2:
	DEC        R16
	BRNE       L_wr_eeprom2
	DEC        R17
	BRNE       L_wr_eeprom2
	NOP
;eeprom_interna_e_ADC_avr.c,81 :: 		}
L_end_wr_eeprom:
	POP        R4
	POP        R3
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _wr_eeprom

_rd_eeprom:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;eeprom_interna_e_ADC_avr.c,83 :: 		int rd_eeprom()
;eeprom_interna_e_ADC_avr.c,88 :: 		dataH = EEPROM_Read(0x00);
	PUSH       R2
	PUSH       R3
	CLR        R2
	CLR        R3
	CALL       _EEPROM_Read+0
	STD        Y+0, R16
;eeprom_interna_e_ADC_avr.c,89 :: 		dataL = EEPROM_Read(0x01);
	LDI        R27, 1
	MOV        R2, R27
	LDI        R27, 0
	MOV        R3, R27
	CALL       _EEPROM_Read+0
;eeprom_interna_e_ADC_avr.c,91 :: 		retorno = (dataH<<8) | dataL;
	LDD        R17, Y+0
	MOV        R19, R17
	CLR        R18
	LDI        R17, 0
	OR         R16, R18
	OR         R17, R19
;eeprom_interna_e_ADC_avr.c,93 :: 		return retorno;
;eeprom_interna_e_ADC_avr.c,97 :: 		}
;eeprom_interna_e_ADC_avr.c,93 :: 		return retorno;
;eeprom_interna_e_ADC_avr.c,97 :: 		}
L_end_rd_eeprom:
	POP        R3
	POP        R2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _rd_eeprom

_value_old:

;eeprom_interna_e_ADC_avr.c,98 :: 		void value_old()
;eeprom_interna_e_ADC_avr.c,101 :: 		IntToStr(valor2, txt1);           //converte um inteiro para string
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	LDI        R27, #lo_addr(_txt1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt1+0)
	MOV        R5, R27
	LDS        R2, _valor2+0
	LDS        R3, _valor2+1
	CALL       _IntToStr+0
;eeprom_interna_e_ADC_avr.c,103 :: 		Lcd_Out(2,2, txt1);               //imprime txt1 no LCD
	LDI        R27, #lo_addr(_txt1+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt1+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;eeprom_interna_e_ADC_avr.c,105 :: 		}
L_end_value_old:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
	RET
; end of _value_old
