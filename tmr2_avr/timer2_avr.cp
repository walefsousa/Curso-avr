#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/tmr2_avr/timer2_avr.c"
#line 14 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/tmr2_avr/timer2_avr.c"
volatile char control = 0;

void TIMER2() iv IVT_ADDR_TIMER2_OVF ics ICS_AUTO
{

 control++;

 if(control == 100)
 {
 control = 0;
 PORTB0_bit = ~PORTB0_bit;

 }

}

void main()
{
 SREG = 0x80;
 TOIE2_bit = 1;
 TCCR2B = 0x03;

 TCNT2 = 0x06;

 DDB0_bit = 1;
 PORTB0_bit = 0;


 while(1)
 {


 }

}
