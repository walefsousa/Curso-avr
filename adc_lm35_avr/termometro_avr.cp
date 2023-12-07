#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/adc_lm35_avr/termometro_avr.c"

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


int valor = 0;
char txt[10];
const char character[] = {0,7,5,7,0,0,0,0,0,0,0};

void CustomChar(char pos_row, char pos_char);
int media();

void main()
{
 DDD0_bit = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,2,"Termometro");

 ADEN_bit = 1;

 while(1)
 {
 valor = media();

 valor = (valor*500)>>10;

 intToStr(valor, txt);

 Lcd_Out(2,2, txt);

 Customchar(2,8);
 Lcd_Chr_cp('C');

 }

}

void CustomChar(char pos_row, char pos_char)
{
 char i;
 Lcd_Cmd(64);
 for (i = 0; i<=10; i++) Lcd_Chr_CP(character[i]);
 Lcd_Cmd(_LCD_RETURN_HOME);
 Lcd_Chr(pos_row, pos_char, 0);

}

int media()
{
 int temp_rp = 0x00;
 char i;

 for(i=0; i<100; i++)
 {

 temp_rp += ADC_Read(0);

 }

 return(temp_rp/100);
}
