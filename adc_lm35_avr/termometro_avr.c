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

int valor = 0;
char txt[10];
const char character[] = {0,7,5,7,0,0,0,0,0,0,0};

void CustomChar(char pos_row, char pos_char);
int media();

void main()
{
  DDD0_bit = 0;                      //apenas PC0 como entrada

  Lcd_Init();                        // Inicializa o LCD
  Lcd_Cmd(_LCD_CLEAR);               // limpa display
  Lcd_Cmd(_LCD_CURSOR_OFF);          //desliga o cursor

  Lcd_Out(1,2,"Termometro");                //impreme no LCD

  ADEN_bit = 1;                      //habilita os canais analógicos

  while(1)
  {
   valor = media();//ADC_Read(0);              //atribui na variável valor a leitura analógica

   valor = (valor*500)>>10;

   intToStr(valor, txt);             //converte um inteiro para string

   Lcd_Out(2,2, txt);                //imprime txt no LCD
   
   Customchar(2,8);
   Lcd_Chr_cp('C');

  }// end while

}//end main

void CustomChar(char pos_row, char pos_char) 
{
  char i;
    Lcd_Cmd(64);
    for (i = 0; i<=10; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);

}//end custonchar

int media()
{
  int temp_rp = 0x00;
  char i;
   
  for(i=0; i<100; i++)
  {

   temp_rp += ADC_Read(0);

  }//end for

   return(temp_rp/100);

}//end media