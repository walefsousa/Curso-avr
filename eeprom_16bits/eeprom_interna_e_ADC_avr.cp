#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/eeprom_16bits/eeprom_interna_e_ADC_avr.c"
#line 14 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/eeprom_16bits/eeprom_interna_e_ADC_avr.c"
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



void wr_eeprom(int);
int rd_eeprom();
void value_old();

int valor, valor2;

char txt[7], txt1[7];

void main()
{

 DDD0_bit = 0;

 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);

 Lcd_Out(1,6,"ADC");

 ADEN_bit = 1;

 valor2 = rd_eeprom();


 while(1)
 {

 value_old();

 valor = ADC_Read(0);

 IntToStr(valor, txt);

 Lcd_Out(2,10, txt);

 wr_eeprom(valor);
 }

}
void wr_eeprom(int dado1)
{
 char dataH, dataL;

 dataH = dado1>>8;
 dataL = dado1%256;

 EEPROM_Write(0x00, dataH);
 EEPROM_Write(0x01, dataL);

 delay_ms(20);

}

int rd_eeprom()
{
 int retorno;
 char dataH, dataL;

 dataH = EEPROM_Read(0x00);
 dataL = EEPROM_Read(0x01);

 retorno = (dataH<<8) | dataL;

 return retorno;

 delay_ms(20);

}
void value_old()
{

 IntToStr(valor2, txt1);

 Lcd_Out(2,2, txt1);

}
