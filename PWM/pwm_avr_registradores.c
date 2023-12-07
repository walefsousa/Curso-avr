/*
  Projeto: PWM
  
  Sistema: ATMEGA328P Clock: 8Hz
  
  Autor: Walef M. de Sousa
  
  Data: 04/06/2020

  Fpwm = Fosc/2*prescale*TOP
  
  Fpwm = 8e6/(2*1*255)
  
  Fpwm = 15,625KHz

*/

char duty = 0;

void main() 
{

 DDB1_bit = 1;

 TCCR1A =  0xA1;                              //Configura OC1A/OC1B na comparação de saida do pwm,
                                              //e WGM12 = 1, no modo de operação.
 TCCR1B =  0x09;                              //prescale de 1:1, WGM13 e WGM12 ambos igual a 1,
                                              //configurados no modo de operação 8bits

    while(1)
   {
     duty += 10;
     delay_ms(100);
     if(duty > 250) duty = 0;
    
     OCR1AL = duty;


   }//end while
 
}//end main