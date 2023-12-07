#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/usart_interrupt/interrupt_usart_avr.c"





void REC_USART() iv IVT_ADDR_USART__RX ics ICS_AUTO
{


 if(UDR0 == 'a') PORTB.B0  = ~ PORTB.B0 ;


}

void main()
{
 DDRB.B0 = 1;
 DDRB.B1 = 1;
  PORTB.B0  = 0;
  PORTB.B1  = 0;

 SREG = 0x80;

 RXCIE0_bit = 1;
 RXEN0_bit = 1;
 UCSR0C = 0x16;


 UART1_Init(9600);

 Delay_ms(100);

 while(1)
 {

 delay_ms(100);
 }

}
