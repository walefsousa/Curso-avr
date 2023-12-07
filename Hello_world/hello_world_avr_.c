/*
   Projeto: Hello World

   Sistema: ATMEGA328P Clock8Mhz

   Autor: Walef M. de Sousa

   Data: 11/07/2020

*/

void main()
{

  PORTB0_bit = 0;
  DDRB.B0 = 1;

   while(1)
  {
     PORTB0_bit ^= 1;
     delay_ms(100);
     
  }//end while


}//end main