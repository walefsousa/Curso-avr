
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;bt_avr.c,16 :: 		void main()
;bt_avr.c,19 :: 		bt1 = 1;          //bt1 inicia em nivel logico alto (PINx é o registrado de leitura)
	IN         R27, PIND0_bit+0
	SBR        R27, BitMask(PIND0_bit+0)
	OUT        PIND0_bit+0, R27
;bt_avr.c,20 :: 		led = 0;
	IN         R27, PORTB+0
	CBR        R27, 1
	OUT        PORTB+0, R27
;bt_avr.c,22 :: 		DDRD = 0x00;      //todo o PORTD como entrada
	LDI        R27, 0
	OUT        DDRD+0, R27
;bt_avr.c,23 :: 		DDRB.B0 = 1;      //apenas o bit menos significativo do PORTB como saida
	IN         R27, DDRB+0
	SBR        R27, 1
	OUT        DDRB+0, R27
;bt_avr.c,25 :: 		while(1)
L_main0:
;bt_avr.c,28 :: 		if(!bt1)led = 1;
	IN         R27, PIND0_bit+0
	SBRC       R27, BitPos(PIND0_bit+0)
	JMP        L_main2
	IN         R27, PORTB+0
	SBR        R27, 1
	OUT        PORTB+0, R27
	JMP        L_main3
L_main2:
;bt_avr.c,29 :: 		else led = 0;
	IN         R27, PORTB+0
	CBR        R27, 1
	OUT        PORTB+0, R27
L_main3:
;bt_avr.c,31 :: 		}//end while
	JMP        L_main0
;bt_avr.c,33 :: 		}//end main
L_end_main:
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
