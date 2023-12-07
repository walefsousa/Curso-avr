#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/botão_avr/bt_avr.c"
#line 16 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/botão_avr/bt_avr.c"
void main()
{

  PIND0_bit  = 1;
  PORTB.B0  = 0;

 DDRD = 0x00;
 DDRB.B0 = 1;

 while(1)
 {

 if(! PIND0_bit ) PORTB.B0  = 1;
 else  PORTB.B0  = 0;

 }

}
