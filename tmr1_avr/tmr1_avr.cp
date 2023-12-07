#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/tmr1_avr/tmr1_avr.c"
#line 20 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/tmr1_avr/tmr1_avr.c"
char contador;

void TIMER1() iv IVT_ADDR_TIMER1_OVF ics ICS_AUTO
{
 if(!TOV1_bit)
 {
 TOV1_bit = 1;
 TCNT1H = 0x13;
 TCNT1L = 0xAD;



 contador++;

 if(contador == 10)
 {
 contador = 0;
  PORTB0_bit  = ~ PORTB0_bit ;

 }

 }

}

void main()
{
 DDRB.B0 = 1;
  PORTB0_bit  = 0;

 SREG = 0x80;
 TOIE1_bit = 1;
 TCCR1A = 0x00;
 TCCR1B = 0x02;

 TCNT1H = 0x13;
 TCNT1L = 0xAD;

 while(1);

}
