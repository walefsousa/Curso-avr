#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/contador_avr/contador_avr.c"
#line 13 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/contador_avr/contador_avr.c"
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


unsigned contador;
char txt[7];

void main()
{
 TCCR1B = 0x06;

 DDD5_bit = 0;

 Lcd_init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,1, "Contador:");

 while(1)
 {

 contador = (TCNT1H<<8) + TCNT1L;

 IntToStr(contador, txt);

 Lcd_Out(2,2, txt);


 }


}
