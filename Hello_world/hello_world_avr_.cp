#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/Hello_world/hello_world_avr_.c"
#line 12 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/Hello_world/hello_world_avr_.c"
void main()
{

 PORTB0_bit = 0;
 DDRB.B0 = 1;

 while(1)
 {
 PORTB0_bit ^= 1;
 delay_ms(100);

 }


}
