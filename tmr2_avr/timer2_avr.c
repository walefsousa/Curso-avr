/*
   Projeto: TMR2


   TMR2 = 1/F_osc*prescale(valor do registrador - valor de carga)


   Testouro = ((TOP+1)*prescale)/Fosc
   
   Testouro = 256*32/8Mhz

 */

volatile char control = 0;

void TIMER2() iv IVT_ADDR_TIMER2_OVF ics ICS_AUTO 
{

     control++;
     
      if(control == 100)
      {
       control = 0;
       PORTB0_bit = ~PORTB0_bit;
      
      }//end if

}//end TMR2

void main() 
{
  SREG       = 0x80;     //Habilita a interrupção global
  TOIE2_bit  = 1;        //habilita o estouro por overflow do TMR2
  TCCR2B     = 0x03;     //seleciona o prescale de 1:32
  
  TCNT2      = 0x06;     //inicia o TMR2 em 00h

  DDB0_bit   = 1;        //apenas o PB0 como saida
  PORTB0_bit = 0;        //inicia o PB0 em low


   while(1)
   {
      //aguarda a interrupção
   
   }//end while

}//end main