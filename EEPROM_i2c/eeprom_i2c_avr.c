/*
   Projeto: EEPROM i2c

   Sistema: ATMEGA16 Clock: 8Mhz

   Autor: Walef M. de Sousa
   
   Data:21/07/2020

*/

void main()
{

  DDRD = 0xFF;              //Todo o PORTD como saida

  TWI_Init(100000);         // Inicializa a comunicação TWI
  TWI_Start();              // da o Start na escrita
  TWI_Write(0xA2);          // inicia o dispositivo para escrita
  TWI_Write(2);             // Salva no endereço de memoria 2
  TWI_Write(0xAA);          // escreve o dado
  TWI_Stop();               // para a comunicação TWI

  delay_ms(100);

  TWI_Start();              // da o Start para a leitura
  TWI_Write(0xA2);          // seta o endereço do dipositivo para leitura
  TWI_Write(2);             // le a posição de memória 2
  TWI_Start();              // repete o start
  TWI_Write(0xA3);          // muda o endereço do barramento para leitura
  PORTD = TWI_Read(0u);     // armazena no PORTD o valor lido
  TWI_Stop();               // para novamente a comunicação

  while(1);

}//end main