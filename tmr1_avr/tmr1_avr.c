/*
   Projeto: TMR1
   
   Sistema: ATMEGA328P Clock: 8MHz
   
   Autor: Walef Manoel de Sousa
   
   Data:02/06/2020
   
   overflor = 1/Fosc*prescale(timer1 - valor de carga)
   
   overflow = 1/8Mhz(8(65536 - 60526))
   
   overflow = 5ms
   
*/

#define led PORTB0_bit

char contador;
 
void TIMER1() iv IVT_ADDR_TIMER1_OVF ics ICS_AUTO 
{
   if(!TOV1_bit)               //ocorreu o overflow ?
   {                           //sim...
     TOV1_bit = 1;             //limpa a flag
     TCNT1H = 0x13;
     TCNT1L = 0xAD;            //recarrega os registradores do TMR1
     
     //base de tempo de 5ms
     //recalcular a base de tempo, está esta errada.
     //consultar as formulas do TMR1
     
     contador++;               //incrementa o contador
     
     if(contador == 10)       //se o contador for igual a 100
     {                         //então...
       contador = 0;           //zera o contador
       led = ~led;             //inverte o estado do led

     }//end if

   }//end if

}//end interrupt

void main()
{
 DDRB.B0 = 1;                  //pino em PC0 como saida
 led     = 0;                  //inicia o pino PC0 em low
 
 SREG = 0x80;                  //habilita a interrupção global
 TOIE1_bit = 1;                //habilita a interrupção por estouro de contagem
 TCCR1A = 0x00;                //Configura o modo de operação normal (timer)
 TCCR1B = 0x02;                //prescale 1:8
 
 TCNT1H = 0x13;
 TCNT1L = 0xAD;                // TMR1 5037d -> 13ADh

  while(1);

}//end main