
_TIMER2:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;timer2_avr.c,16 :: 		void TIMER2() iv IVT_ADDR_TIMER2_OVF ics ICS_AUTO
;timer2_avr.c,19 :: 		control++;
	LDS        R16, _control+0
	SUBI       R16, 255
	STS        _control+0, R16
;timer2_avr.c,21 :: 		if(control == 100)
	LDS        R16, _control+0
	CPI        R16, 100
	BREQ       L__TIMER24
	JMP        L_TIMER20
L__TIMER24:
;timer2_avr.c,23 :: 		control = 0;
	LDI        R27, 0
	STS        _control+0, R27
;timer2_avr.c,24 :: 		PORTB0_bit = ~PORTB0_bit;
	IN         R0, PORTB0_bit+0
	LDI        R27, BitMask(PORTB0_bit+0)
	EOR        R0, R27
	OUT        PORTB0_bit+0, R0
;timer2_avr.c,26 :: 		}//end if
L_TIMER20:
;timer2_avr.c,28 :: 		}//end TMR2
L_end_TIMER2:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _TIMER2

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;timer2_avr.c,30 :: 		void main()
;timer2_avr.c,32 :: 		SREG       = 0x80;     //Habilita a interrupção global
	LDI        R27, 128
	OUT        SREG+0, R27
;timer2_avr.c,33 :: 		TOIE2_bit  = 1;        //habilita o estouro por overflow do TMR2
	LDS        R27, TOIE2_bit+0
	SBR        R27, BitMask(TOIE2_bit+0)
	STS        TOIE2_bit+0, R27
;timer2_avr.c,34 :: 		TCCR2B     = 0x03;     //seleciona o prescale de 1:32
	LDI        R27, 3
	STS        TCCR2B+0, R27
;timer2_avr.c,36 :: 		TCNT2      = 0x06;     //inicia o TMR2 em 00h
	LDI        R27, 6
	STS        TCNT2+0, R27
;timer2_avr.c,38 :: 		DDB0_bit   = 1;        //apenas o PB0 como saida
	IN         R27, DDB0_bit+0
	SBR        R27, BitMask(DDB0_bit+0)
	OUT        DDB0_bit+0, R27
;timer2_avr.c,39 :: 		PORTB0_bit = 0;        //inicia o PB0 em low
	IN         R27, PORTB0_bit+0
	CBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;timer2_avr.c,42 :: 		while(1)
L_main1:
;timer2_avr.c,46 :: 		}//end while
	JMP        L_main1
;timer2_avr.c,48 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
