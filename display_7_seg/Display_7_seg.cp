#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/display_7_seg/Display_7_seg.c"
#line 13 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/display_7_seg/Display_7_seg.c"
const char matriz[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
char i;

void main()
{
 DDRD = 0xFF;
 PORTD = 0x00;

 while(1)
 {

 i++;

 if(i > 9) i = 0;

 PORTD = matriz[i];

 delay_ms(100);

 }

}
