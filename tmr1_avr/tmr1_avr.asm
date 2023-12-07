
_TIMER1:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;tmr1_avr.c,22 :: 		void TIMER1() iv IVT_ADDR_TIMER1_OVF ics ICS_AUTO
;tmr1_avr.c,24 :: 		if(!TOV1_bit)               //ocorreu o overflow ?
	IN         R27, TOV1_bit+0
	SBRC       R27, BitPos(TOV1_bit+0)
	JMP        L_TIMER10
;tmr1_avr.c,26 :: 		TOV1_bit = 1;             //limpa a flag
	IN         R27, TOV1_bit+0
	SBR        R27, BitMask(TOV1_bit+0)
	OUT        TOV1_bit+0, R27
;tmr1_avr.c,27 :: 		TCNT1H = 0x13;
	LDI        R27, 19
	STS        TCNT1H+0, R27
;tmr1_avr.c,28 :: 		TCNT1L = 0xAD;            //recarrega os registradores do TMR1
	LDI        R27, 173
	STS        TCNT1L+0, R27
;tmr1_avr.c,32 :: 		contador++;               //incrementa o contador
	LDS        R16, _contador+0
	SUBI       R16, 255
	STS        _contador+0, R16
;tmr1_avr.c,34 :: 		if(contador == 10)       //se o contador for igual a 100
	CPI        R16, 10
	BREQ       L__TIMER15
	JMP        L_TIMER11
L__TIMER15:
;tmr1_avr.c,36 :: 		contador = 0;           //zera o contador
	LDI        R27, 0
	STS        _contador+0, R27
;tmr1_avr.c,37 :: 		led = ~led;             //inverte o estado do led
	IN         R0, PORTB0_bit+0
	LDI        R27, BitMask(PORTB0_bit+0)
	EOR        R0, R27
	OUT        PORTB0_bit+0, R0
;tmr1_avr.c,39 :: 		}//end if
L_TIMER11:
;tmr1_avr.c,41 :: 		}//end if
L_TIMER10:
;tmr1_avr.c,43 :: 		}//end interrupt
L_end_TIMER1:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _TIMER1

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;tmr1_avr.c,45 :: 		void main()
;tmr1_avr.c,47 :: 		DDRB.B0 = 1;                  //pino em PC0 como saida
	IN         R27, DDRB+0
	SBR        R27, 1
	OUT        DDRB+0, R27
;tmr1_avr.c,48 :: 		led     = 0;                  //inicia o pino PC0 em low
	IN         R27, PORTB0_bit+0
	CBR        R27, BitMask(PORTB0_bit+0)
	OUT        PORTB0_bit+0, R27
;tmr1_avr.c,50 :: 		SREG = 0x80;                  //habilita a interrupção global
	LDI        R27, 128
	OUT        SREG+0, R27
;tmr1_avr.c,51 :: 		TOIE1_bit = 1;                //habilita a interrupção por estouro de contagem
	LDS        R27, TOIE1_bit+0
	SBR        R27, BitMask(TOIE1_bit+0)
	STS        TOIE1_bit+0, R27
;tmr1_avr.c,52 :: 		TCCR1A = 0x00;                //Configura o modo de operação normal (timer)
	LDI        R27, 0
	STS        TCCR1A+0, R27
;tmr1_avr.c,53 :: 		TCCR1B = 0x02;                //prescale 1:8
	LDI        R27, 2
	STS        TCCR1B+0, R27
;tmr1_avr.c,55 :: 		TCNT1H = 0x13;
	LDI        R27, 19
	STS        TCNT1H+0, R27
;tmr1_avr.c,56 :: 		TCNT1L = 0xAD;                // TMR1 5037d -> 13ADh
	LDI        R27, 173
	STS        TCNT1L+0, R27
;tmr1_avr.c,58 :: 		while(1);
L_main2:
	JMP        L_main2
;tmr1_avr.c,60 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
