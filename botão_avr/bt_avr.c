/*
  Projeto: Botão simples
  
  Sistema: ATMEGA328P Clock: 8Mhz
  
  Autor: Walef M. de Sousa

  Data:

*/

#define bt1 PIND0_bit
#define led PORTB.B0

void main() 
{
   
   bt1 = 1;          //bt1 inicia em nivel logico alto (PINx é o registrado de leitura)
   led = 0;          //led inica em 0
   
   DDRD = 0x00;      //todo o PORTD como entrada
   DDRB.B0 = 1;      //apenas o bit menos significativo do PORTB como saida
   
   while(1)
   {
  
    if(!bt1)led = 1;
    else led = 0;

   }//end while
   
}//end main