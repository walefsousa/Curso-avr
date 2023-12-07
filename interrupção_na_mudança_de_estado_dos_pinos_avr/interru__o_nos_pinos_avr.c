/*
  Projeto: Interrupção por mudança no PORT

  Sistema: ATMEGA328P Clock: 8Mhz
  
  Autor: Walef M. de Sousa
  
  Data:19/07/2020
  
*/

#define bt1  PIND2_bit                //mapeamento do hardware
#define bt2  PIND3_bit
#define led1 PORTB0_bit
#define led2 PORTB1_bit

void PIN2() iv IVT_ADDR_PCINT2 ics ICS_AUTO
{

 if(!bt1) led1 = 1;
 else led1 = 0;
 
 if(!bt2) led2 = 1;
 else led2 = 0;

}//end interrupt

void main()
{
 SREG = 0x80;             //habilita a interrupção global
 
 PCIE2_bit = 1;           //habilita a interrupção por mudança de estado no PORTD
 PCMSK2 = 0xFF;           //todos os pinos do PORTD habilitados para a interrupção
 
 led1 = 0;
 led2 = 0;                //os leds inicia em low


 while(1);

}//end main