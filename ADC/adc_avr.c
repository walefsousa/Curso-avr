/*
   Projeto: Conversor ADC
   
   Sistema: ATMEGA328P Clock:8Mhz
   
   Autor: Walef M. de Sousa
   
   DAta: 05/06/2020



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

 int valor;
 char txt[7];

void main() 
{

  DDD0_bit = 0;                      //apenas PC0 como entrada
  
  Lcd_Init();                        // Inicializa o LCD
  Lcd_Cmd(_LCD_CLEAR);               // limpa display
  Lcd_Cmd(_LCD_CURSOR_OFF);          //desliga o cursor

  Lcd_Out(1,6,"ADC");                //impreme no LCD
 
  ADEN_bit = 1;                      //habilita os canais analógicos

  while(1)
  {
   valor = ADC_Read(0);              //atribui na variável valor a leitura analógica
   
   IntToStr(valor, txt);             //converte um inteiro para string
   
   Lcd_Out(2,2, txt);                //imprime txt no LCD
  
  }


}