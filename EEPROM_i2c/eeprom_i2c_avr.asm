
_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27

;eeprom_i2c_avr.c,12 :: 		void main()
;eeprom_i2c_avr.c,15 :: 		DDRD = 0xFF;              //Todo o PORTD como saida
	PUSH       R2
	LDI        R27, 255
	OUT        DDRD+0, R27
;eeprom_i2c_avr.c,17 :: 		TWI_Init(100000);         // Inicializa a comunicação TWI
	IN         R27, TWPS0_bit+0
	CBR        R27, BitMask(TWPS0_bit+0)
	OUT        TWPS0_bit+0, R27
	IN         R27, TWPS1_bit+0
	CBR        R27, BitMask(TWPS1_bit+0)
	OUT        TWPS1_bit+0, R27
	LDI        R27, 32
	OUT        TWBR+0, R27
	CALL       _TWI_Init+0
;eeprom_i2c_avr.c,18 :: 		TWI_Start();              // da o Start na escrita
	CALL       _TWI_Start+0
;eeprom_i2c_avr.c,19 :: 		TWI_Write(0xA2);          //  endereço do dispositivo no barramento de comunicação
	LDI        R27, 162
	MOV        R2, R27
	CALL       _TWI_Write+0
;eeprom_i2c_avr.c,20 :: 		TWI_Write(2);             // Salva no endereço de memoria 2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _TWI_Write+0
;eeprom_i2c_avr.c,21 :: 		TWI_Write(0xAA);          // escreve o dado
	LDI        R27, 170
	MOV        R2, R27
	CALL       _TWI_Write+0
;eeprom_i2c_avr.c,22 :: 		TWI_Stop();               // para a comunicação TWI
	CALL       _TWI_Stop+0
;eeprom_i2c_avr.c,24 :: 		delay_ms(100);
	LDI        R18, 5
	LDI        R17, 15
	LDI        R16, 242
L_main0:
	DEC        R16
	BRNE       L_main0
	DEC        R17
	BRNE       L_main0
	DEC        R18
	BRNE       L_main0
;eeprom_i2c_avr.c,26 :: 		TWI_Start();              // da o Start para a leitura
	CALL       _TWI_Start+0
;eeprom_i2c_avr.c,27 :: 		TWI_Write(0xA2);          // seta o endereço do dipositivo para leitura
	LDI        R27, 162
	MOV        R2, R27
	CALL       _TWI_Write+0
;eeprom_i2c_avr.c,28 :: 		TWI_Write(2);             // le a posição de memória 2
	LDI        R27, 2
	MOV        R2, R27
	CALL       _TWI_Write+0
;eeprom_i2c_avr.c,29 :: 		TWI_Start();              // repete o start
	CALL       _TWI_Start+0
;eeprom_i2c_avr.c,30 :: 		TWI_Write(0xA3);          // muda o endereço do barramento para leitura
	LDI        R27, 163
	MOV        R2, R27
	CALL       _TWI_Write+0
;eeprom_i2c_avr.c,31 :: 		PORTD = TWI_Read(0u);     //armazena no PORTD o valor da leitura
	CLR        R2
	CALL       _TWI_Read+0
	OUT        PORTD+0, R16
;eeprom_i2c_avr.c,32 :: 		TWI_Stop();               // para a comunicação
	CALL       _TWI_Stop+0
;eeprom_i2c_avr.c,34 :: 		while(1);
L_main2:
	JMP        L_main2
;eeprom_i2c_avr.c,36 :: 		}//end main
L_end_main:
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
