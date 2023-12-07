/*
   Projeto; Interrup��o externa
   
   Sistema: ATMEGA328P Clock: 8Mhz
   
   Autor: Walef M. de Sousa
   
   Data:19/07/2020

*/


#define led PORTB0_bit

void INTEXT0() iv IVT_ADDR_INT0 ics ICS_AUTO 
{
   led = 1;             //Houve a interrup��o externa no INT0 ?
                        //sim, seta o led

}//end 

void INTEXT1() iv IVT_ADDR_INT1 ics ICS_AUTO 
{
  led = 0;              //Houve a interrup��o externa no INT1 ?
                        //sim, apaga o led

}//end if

void main() 
{

 SREG = 0x80;           //habilita a interrup��o global
 
 EICRA = 0x0A;          //as duas interrup��es ser�o executadas na descida de borda
 EIMSK = 0x03;          //habilita a interrup��o externa.

 DDRB  = 0xFF;          //Todo o PORTB como saida.

 led = 0;               //led inicia em low
 
 while(1);
 
}//end main