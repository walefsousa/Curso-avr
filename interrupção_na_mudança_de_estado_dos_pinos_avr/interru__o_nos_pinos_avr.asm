
_PIN2:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interru__o_nos_pinos_avr.c,17 :: 		void PIN2() iv IVT_ADDR_PCINT2 ics ICS_AUTO
;interru__o_nos_pinos_avr.c,20 :: 		if(!bt1) led1 = 1;
	IN         R27, PIND2_bit+0
	SBRC       R27, BitPos(PIND2_bit+0)
	JMP        L_PIN20
	IN         R27, PORTB0_bit+0
	SBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
	JMP        L_PIN21
L_PIN20:
;interru__o_nos_pinos_avr.c,21 :: 		else led1 = 0;
	IN         R27, PORTB0_bit+0
	CBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
L_PIN21:
;interru__o_nos_pinos_avr.c,23 :: 		if(!bt2) led2 = 1;
	IN         R27, PIND3_bit+0
	SBRC       R27, BitPos(PIND3_bit+0)
	JMP        L_PIN22
	IN         R27, PORTB1_bit+0
	SBR        R27, BitMask(PORTB1_bit+0)
	OUT        PORTB1_bit+0, R27
	JMP        L_PIN23
L_PIN22:
;interru__o_nos_pinos_avr.c,24 :: 		else led2 = 0;
	IN         R27, PORTB1_bit+0
	CBR        R27, BitMask(PORTB1_bit+0)
	OUT        PORTB1_bit+0, R27
L_PIN23:
;interru__o_nos_pinos_avr.c,26 :: 		}//end interrupt
L_end_PIN2:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _PIN2

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;interru__o_nos_pinos_avr.c,28 :: 		void main()
;interru__o_nos_pinos_avr.c,30 :: 		SREG = 0x80;             //habilita a interrupção global
	LDI        R27, 128
	OUT        SREG+0, R27
;interru__o_nos_pinos_avr.c,32 :: 		PCIE2_bit = 1;           //habilita a interrupção por mudança de estado no PORTD
	LDS        R27, PCIE2_bit+0
	SBR        R27, BitMask(PCIE2_bit+0)
	STS        PCIE2_bit+0, R27
;interru__o_nos_pinos_avr.c,33 :: 		PCMSK2 = 0xFF;           //todos os pinos do PORTD como entrada para a interrupção
	LDI        R27, 255
	STS        PCMSK2+0, R27
;interru__o_nos_pinos_avr.c,35 :: 		DDRB = 0xFF;             //todo o PORTB como saida
	LDI        R27, 255
	OUT        DDRB+0, R27
;interru__o_nos_pinos_avr.c,36 :: 		PORTB = 0x00;            //inicia tudo em low
	LDI        R27, 0
	OUT        PORTB+0, R27
;interru__o_nos_pinos_avr.c,40 :: 		while(1);
L_main4:
	JMP        L_main4
;interru__o_nos_pinos_avr.c,42 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
