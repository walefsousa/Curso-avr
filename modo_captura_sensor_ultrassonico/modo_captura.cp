#line 1 "C:/Users/Walef/Desktop/modo_captura_sensor_ultrassonico/modo_captura.c"
#line 8 "C:/Users/Walef/Desktop/modo_captura_sensor_ultrassonico/modo_captura.c"
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









void pulso();
int media();

char txt[7];

unsigned int valor1 = 0,
 valor2 = 0,
 x1[16],
 y1,
 distancia,
 resultado;

void CAPTURA() iv IVT_ADDR_TIMER1_CAPT ics ICS_AUTO
{

 ICES1_bit = ~ICES1_bit;

 if(ICES1_bit)
 {
 valor1 = (ICR1H<<8) + ICR1L;

 }

 else
 {
 valor2 = (ICR1H<<8) + ICR1L;

 distancia = abs(valor2 - valor1)/58;

 resultado = media();

 }


}

void main()
{

 DDRB = 0xFE;
 DDRD = 0xFF;

  PORTD.B4  = 0;

 SREG = 0x80;

 ICES1_bit = 1;
 CS10_bit = 1;
 ICIE1_bit = 1;

 Lcd_Init();

 Lcd_cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,4,"Distancia");
 Lcd_Out(2,13,"Cm");

 while(1)
 {
 pulso();

 IntToStr(resultado, txt);

 Lcd_out(2,2, txt);

 }

}
 void pulso()
{
  PORTD.B4  = 1;
 delay_us(1);
  PORTD.B4  = 0;
}

int media(){

 unsigned char i = 15;

 do{
 x1[i] = x1[i-1];
 y1 += x1[i];
 i--;
 }
 while (i!=0);

 x1[0] = distancia;
 return y1 = (y1 + x1[0])/16;
}
