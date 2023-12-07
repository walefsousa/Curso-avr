/*
    Projeto: Contador com TMR1
    
    Sistema: ATMEGA328P Clock:8Mhz

    Autor: Walef M. de Sousa
    
    Data: 05/06/2020

*/

// mapeamento do LCD
sbit LCD_RS at PORTD7_bit;
sbit LCD_EN at PORTD6_bit;
sbit LCD_D4 at PORTB1_bit;
sbit LCD_D5 at PORTB2_bit;
sbit LCD_D6 at PORTB3_bit;
sbit LCD_D7 at PORTB4_bit;

sbit LCD_RS_Direction at DDD7_bit;
sbit LCD_EN_Direction at DDD6_bit;
sbit LCD_D4_Direction at DDB1_bit;
sbit LCD_D5_Direction at DDB2_bit;
sbit LCD_D6_Direction at DDB3_bit;
sbit LCD_D7_Direction at DDB4_bit;
// End LCD module connections

unsigned contador;                //variável para armazenar o valor do contador
char txt[7];                      //matriz para a função de conversão

void main() 
{
 TCCR1B = 0x06;                   //habilita o TMR1 como contador externo

 DDD5_bit = 0;                    //apenas PD5 como entrada
  
 Lcd_init();                      //inicia o LCD
 Lcd_Cmd(_LCD_CLEAR);             //limpa o lcd
 Lcd_Cmd(_LCD_CURSOR_OFF);        //desliga o cursor
 
 Lcd_Out(1,1, "Contador:");       //imprime na linha 1, coluna 1
  
  while(1)
  {
  
   contador = (TCNT1H<<8) | TCNT1L;  //Faz um shift lefth de 8 bits com o registrador mai significativo
                                     //e faz uma OR (soma) com o byte menos significativo
  
   IntToStr(contador, txt);          //converter um inteira para string
  
   Lcd_Out(2,2, txt);                //e imprime no LCD

  }//end while

}//end main