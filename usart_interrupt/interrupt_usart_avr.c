

#define led  PORTB.B0
#define led2 PORTB.B1

void REC_USART() iv IVT_ADDR_USART__RX ics ICS_AUTO 
{

   
   if(UDR0 == 'a')led = ~led;


}//fim interrup��o

void main() 
{
 DDRB.B0 = 1;                  //pino em PC0 como saida
 DDRB.B1 = 1;
 led     = 0;                  //inicia o pino PC0 em low
 led2 = 0;
 
 SREG = 0x80;                  //habilita a interrup��o global

 RXCIE0_bit = 1;               //habilita a interru��o por recep��o completa
 RXEN0_bit = 1;                //habilita a recep��o da usart
 UCSR0C = 0x16;                //modo de opera��o ass�crono,
                               //sem paridade, modo de 8-bits de frame
                               
 UART1_Init(9600);             // Initialize UART module at 9600 bps
 
 Delay_ms(100);

 while(1)
 {
     //led2 = ~led2;
     delay_ms(100);
 }

}//end main