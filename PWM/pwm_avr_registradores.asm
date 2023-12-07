
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;pwm_avr_registradores.c,20 :: 		void main()
;pwm_avr_registradores.c,23 :: 		DDB1_bit = 1;
	IN         R27, DDB1_bit+0
	SBR        R27, BitMask(DDB1_bit+0)
	OUT        DDB1_bit+0, R27
;pwm_avr_registradores.c,25 :: 		TCCR1A =  0xA1;                              //Configura OC1A/OC1B na comparação de saida do pwm,
	LDI        R27, 161
	STS        TCCR1A+0, R27
;pwm_avr_registradores.c,27 :: 		TCCR1B =  0x09;                              //prescale de 1:1, WGM13 e WGM12 ambos igual a 1,
	LDI        R27, 9
	STS        TCCR1B+0, R27
;pwm_avr_registradores.c,30 :: 		while(1)
L_main0:
;pwm_avr_registradores.c,32 :: 		duty += 10;
	LDS        R16, _duty+0
	SUBI       R16, 246
	STS        _duty+0, R16
;pwm_avr_registradores.c,33 :: 		delay_ms(100);
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
;pwm_avr_registradores.c,34 :: 		if(duty > 250) duty = 0;
	LDS        R17, _duty+0
	LDI        R16, 250
	CP         R16, R17
	BRLO       L__main6
	JMP        L_main4
L__main6:
	LDI        R27, 0
	STS        _duty+0, R27
L_main4:
;pwm_avr_registradores.c,36 :: 		OCR1AL = duty;
	LDS        R16, _duty+0
	STS        OCR1AL+0, R16
;pwm_avr_registradores.c,39 :: 		}
	JMP        L_main0
;pwm_avr_registradores.c,41 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
