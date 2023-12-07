#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/interrupt_externa_avr/interrupt_externa_avr.c"
#line 15 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/interrupt_externa_avr/interrupt_externa_avr.c"
void INTEXT0() iv IVT_ADDR_INT0 ics ICS_AUTO
{
  PORTB0_bit  = 1;


}

void INTEXT1() iv IVT_ADDR_INT1 ics ICS_AUTO
{
  PORTB0_bit  = 0;


}

void main()
{

 SREG = 0x80;

 EICRA = 0x0A;
 EIMSK = 0x03;

 DDRB = 0xFF;



  PORTB0_bit  = 0;

 while(1);

}
