
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;adc_avr.c,33 :: 		void main()
;adc_avr.c,36 :: 		DDD0_bit = 0;                      //apenas PC0 como entrada
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
	IN         R27, DDD0_bit+0
	CBR        R27, BitMask(DDD0_bit+0)
	OUT        DDD0_bit+0, R27
;adc_avr.c,38 :: 		Lcd_Init();                        // Inicializa o LCD
	CALL       _Lcd_Init+0
;adc_avr.c,39 :: 		Lcd_Cmd(_LCD_CLEAR);               // limpa display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;adc_avr.c,40 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          //desliga o cursor
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;adc_avr.c,42 :: 		Lcd_Out(1,6,"ADC");                //impreme no LCD
	LDI        R27, #lo_addr(?lstr1_adc_avr+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_adc_avr+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;adc_avr.c,44 :: 		ADEN_bit = 1;                      //habilita os canais analógicos
	LDS        R27, ADEN_bit+0
	SBR        R27, BitMask(ADEN_bit+0)
	STS        ADEN_bit+0, R27
;adc_avr.c,46 :: 		while(1)
L_main0:
;adc_avr.c,48 :: 		valor = ADC_Read(0);              //atribui na variável valor a leitura analógica
	CLR        R2
	CALL       _ADC_Read+0
	STS        _valor+0, R16
	STS        _valor+1, R17
;adc_avr.c,50 :: 		IntToStr(valor, txt);             //converte um inteiro para string
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	MOVW       R2, R16
	CALL       _IntToStr+0
;adc_avr.c,52 :: 		Lcd_Out(2,2, txt);                //imprime txt no LCD
	LDI        R27, #lo_addr(_txt+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_txt+0)
	MOV        R5, R27
	LDI        R27, 2
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;adc_avr.c,54 :: 		}
	JMP        L_main0
;adc_avr.c,57 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
