/*
   Projeto: Interrupção TMR0

   Sistema: ATMEGA328p Clock: 8MHz

   Autor: Walef M. de Sousa

   Data: 28/05/2020

   T_estouro = ((TOP+1)*prescale)/Fosc

   T_estouro = (250*64)/8Mhz
  
   T_estouro = 1ms


*/

#define led  PORTB.B0

int contador;

void timer0() iv IVT_ADDR_TIMER0_OVF ics ICS_AUTO
{

     contador++;

      if(contador == 50)
      {
        contador = 0;
        led = ~led;                    //inverte o estado do led
  
      }//end if


}//end interrupt


void main()
{

 DDB0_bit = 1;        //pinos B0 como saida
 led = 0;             //inicia o pino em nivel lógico baixo

 SREG = 0x80;         //habilita ainterrupção global

 TOIE0_bit = 1;       //habilita a interrupção por estouro do TMR0
 TCCR0A = 0x00;       //habilita o modo de operação para Timer/Counter
 TCCR0B = 0x03;       //configura prescale de 1:32

 TCNT0 = 0x06;        //inicia TMR0 em 06h

  while(1);

}//end main