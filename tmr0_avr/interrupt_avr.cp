#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/tmr0_avr/interrupt_avr.c"
#line 21 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/tmr0_avr/interrupt_avr.c"
int contador;

void timer0() iv IVT_ADDR_TIMER0_OVF ics ICS_AUTO
{

 contador++;

 if(contador == 50)
 {
 contador = 0;
  PORTB.B0  = ~ PORTB.B0 ;

 }


}


void main()
{

 DDB0_bit = 1;
  PORTB.B0  = 0;

 SREG = 0x80;

 TOIE0_bit = 1;
 TCCR0A = 0x00;
 TCCR0B = 0x03;

 TCNT0 = 0x06;

 while(1);

}
