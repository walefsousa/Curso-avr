
_REC_USART:
	PUSH       R30
	PUSH       R31
	PUSH       R27
	IN         R27, SREG+0
	PUSH       R27

;interrupt_usart_avr.c,6 :: 		void REC_USART() iv IVT_ADDR_USART__RX ics ICS_AUTO
;interrupt_usart_avr.c,10 :: 		if(UDR0 == 'a')led = ~led;
	LDS        R16, UDR0+0
	CPI        R16, 97
	BREQ       L__REC_USART8
	JMP        L_REC_USART0
L__REC_USART8:
	IN         R0, PORTB+0
	LDI        R27, 1
	EOR        R0, R27
	OUT        PORTB+0, R0
L_REC_USART0:
;interrupt_usart_avr.c,13 :: 		}//fim interrupção
L_end_REC_USART:
	POP        R27
	OUT        SREG+0, R27
	POP        R27
	POP        R31
	POP        R30
	RETI
; end of _REC_USART

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;interrupt_usart_avr.c,15 :: 		void main()
;interrupt_usart_avr.c,17 :: 		DDRB.B0 = 1;                  //pino em PC0 como saida
	IN         R27, DDRB+0
	SBR        R27, 1
	OUT        DDRB+0, R27
;interrupt_usart_avr.c,18 :: 		DDRB.B1 = 1;
	IN         R27, DDRB+0
	SBR        R27, 2
	OUT        DDRB+0, R27
;interrupt_usart_avr.c,19 :: 		led     = 0;                  //inicia o pino PC0 em low
	IN         R27, PORTB+0
	CBR        R27, 1
	OUT        PORTB+0, R27
;interrupt_usart_avr.c,20 :: 		led2 = 0;
	IN         R27, PORTB+0
	CBR        R27, 2
	OUT        PORTB+0, R27
;interrupt_usart_avr.c,22 :: 		SREG = 0x80;                  //habilita a interrupção global
	LDI        R27, 128
	OUT        SREG+0, R27
;interrupt_usart_avr.c,24 :: 		RXCIE0_bit = 1;               //habilita a interrução por recepção completa
	LDS        R27, RXCIE0_bit+0
	SBR        R27, BitMask(RXCIE0_bit+0)
	STS        RXCIE0_bit+0, R27
;interrupt_usart_avr.c,25 :: 		RXEN0_bit = 1;                //habilita a recepção da usart
	LDS        R27, RXEN0_bit+0
	SBR        R27, BitMask(RXEN0_bit+0)
	STS        RXEN0_bit+0, R27
;interrupt_usart_avr.c,26 :: 		UCSR0C = 0x16;                //modo de operação assícrono,
	LDI        R27, 22
	STS        UCSR0C+0, R27
;interrupt_usart_avr.c,29 :: 		UART1_Init(9600);             // Initialize UART module at 9600 bps
	LDI        R27, 51
	STS        UBRR0L+0, R27
	LDI        R27, 0
	STS        UBRR0H+0, R27
	CALL       _UART1_Init+0
;interrupt_usart_avr.c,31 :: 		Delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main1:
	DEC        R16
	BRNE       L_main1
	DEC        R17
	BRNE       L_main1
	DEC        R18
	BRNE       L_main1
;interrupt_usart_avr.c,33 :: 		while(1)
L_main3:
;interrupt_usart_avr.c,36 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main5:
	DEC        R16
	BRNE       L_main5
	DEC        R17
	BRNE       L_main5
	DEC        R18
	BRNE       L_main5
;interrupt_usart_avr.c,37 :: 		}
	JMP        L_main3
;interrupt_usart_avr.c,39 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
