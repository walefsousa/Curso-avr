
_INTEXT0:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt_externa_avr.c,15 :: 		void INTEXT0() iv IVT_ADDR_INT0 ics ICS_AUTO
;interrupt_externa_avr.c,17 :: 		led = 1;                                  //Houve a interrupção externa no INT0 ?
	IN         R27, PORTB0_bit+0
	SBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;interrupt_externa_avr.c,20 :: 		}//end
L_end_INTEXT0:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _INTEXT0

_INTEXT1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt_externa_avr.c,22 :: 		void INTEXT1() iv IVT_ADDR_INT1 ics ICS_AUTO
;interrupt_externa_avr.c,24 :: 		led = 0;                                   //Houve a interrupção externa no INT1 ?
	IN         R27, PORTB0_bit+0
	CBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;interrupt_externa_avr.c,27 :: 		}//end if
L_end_INTEXT1:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _INTEXT1

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;interrupt_externa_avr.c,29 :: 		void main()
;interrupt_externa_avr.c,32 :: 		SREG = 0x80;           //habilita a interrupção global
	LDI        R27, 128
	OUT        SREG+0, R27
;interrupt_externa_avr.c,34 :: 		EICRA = 0x0A;          //as duas interrupções serão executadas na descida de borda
	LDI        R27, 10
	STS        EICRA+0, R27
;interrupt_externa_avr.c,35 :: 		EIMSK = 0x03;          //habilita a interrupção externa.
	LDI        R27, 3
	OUT        EIMSK+0, R27
;interrupt_externa_avr.c,37 :: 		DDRB  = 0xFF;          //Todo o PORTB como saida.
	LDI        R27, 255
	OUT        DDRB+0, R27
;interrupt_externa_avr.c,41 :: 		led = 0;
	IN         R27, PORTB0_bit+0
	CBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;interrupt_externa_avr.c,43 :: 		while(1);
L_main0:
	JMP        L_main0
;interrupt_externa_avr.c,45 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
