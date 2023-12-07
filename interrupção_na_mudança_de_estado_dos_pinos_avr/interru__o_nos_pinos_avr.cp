#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/interrupção_na_mudança_de_estado_dos_pinos_avr/interru__o_nos_pinos_avr.c"
#line 17 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/interrupção_na_mudança_de_estado_dos_pinos_avr/interru__o_nos_pinos_avr.c"
void PIN2() iv IVT_ADDR_PCINT2 ics ICS_AUTO
{

 if(! PIND2_bit )  PORTB0_bit  = 1;
 else  PORTB0_bit  = 0;

 if(! PIND3_bit )  PORTB1_bit  = 1;
 else  PORTB1_bit  = 0;

}

void main()
{
 SREG = 0x80;

 PCIE2_bit = 1;
 PCMSK2 = 0xFF;

 DDRB = 0xFF;
 PORTB = 0x00;



 while(1);

}
