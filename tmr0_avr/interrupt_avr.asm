
_timer0:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt_avr.c,23 :: 		void timer0() iv IVT_ADDR_TIMER0_OVF ics ICS_AUTO
;interrupt_avr.c,26 :: 		contador++;
	LDS        R16, _contador+0
	LDS        R17, _contador+1
	SUBI       R16, 255
	SBCI       R17, 255
	STS        _contador+0, R16
	STS        _contador+1, R17
;interrupt_avr.c,28 :: 		if(contador == 50)
	CPI        R17, 0
	BRNE       L__timer04
	CPI        R16, 50
L__timer04:
	BREQ       L__timer05
	JMP        L_timer00
L__timer05:
;interrupt_avr.c,30 :: 		contador = 0;
	LDI        R27, 0
	STS        _contador+0, R27
	STS        _contador+1, R27
;interrupt_avr.c,31 :: 		led = ~led;                    //inverte o estado do led
	IN         R0, PORTB+0
	LDI        R27, 1
	EOR        R0, R27
	OUT        PORTB+0, R0
;interrupt_avr.c,33 :: 		}//end if
L_timer00:
;interrupt_avr.c,36 :: 		}//end interrupt
L_end_timer0:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _timer0

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;interrupt_avr.c,39 :: 		void main()
;interrupt_avr.c,42 :: 		DDB0_bit = 1;        //pinos B0 como saida
	IN         R27, DDB0_bit+0
	SBR        R27, BitMask(DDB0_bit+0)
	OUT        DDB0_bit+0, R27
;interrupt_avr.c,43 :: 		led = 0;             //inicia o pino em nivel lógico baixo
	IN         R27, PORTB+0
	CBR        R27, 1
	OUT        PORTB+0, R27
;interrupt_avr.c,45 :: 		SREG = 0x80;         //habilita ainterrupção global
	LDI        R27, 128
	OUT        SREG+0, R27
;interrupt_avr.c,47 :: 		TOIE0_bit = 1;       //habilita a interrupção por estouro do TMR0
	LDS        R27, TOIE0_bit+0
	SBR        R27, BitMask(TOIE0_bit+0)
	STS        TOIE0_bit+0, R27
;interrupt_avr.c,48 :: 		TCCR0A = 0x00;       //habilita o modo de operação para Timer/Counter
	LDI        R27, 0
	OUT        TCCR0A+0, R27
;interrupt_avr.c,49 :: 		TCCR0B = 0x03;       //configura prescale de 1:32
	LDI        R27, 3
	OUT        TCCR0B+0, R27
;interrupt_avr.c,51 :: 		TCNT0 = 0x06;        //inicia TMR0 em 06h
	LDI        R27, 6
	OUT        TCNT0+0, R27
;interrupt_avr.c,53 :: 		while(1);
L_main1:
	JMP        L_main1
;interrupt_avr.c,55 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
