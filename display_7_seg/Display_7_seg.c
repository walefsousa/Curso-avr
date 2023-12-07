/*
    Projeto: Display 7 Seguimento
    
    Sistema: ATMEGA328p Clock: 8Mhz
    
    Autor: Walef M. de Sousa
    
    Data 01/07/2020


*/

const char matriz[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
char i;

void main() 
{
   DDRD = 0xFF;               //Todo
   PORTD = 0x00;

  while(1)
  {
  
       i++;
       
       if(i > 9) i = 0;
       
       PORTD = matriz[i];

       delay_ms(100);
  
  }//end while

}//end main