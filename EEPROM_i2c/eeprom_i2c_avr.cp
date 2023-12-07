#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/EEPROM_i2c/eeprom_i2c_avr.c"
#line 12 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/EEPROM_i2c/eeprom_i2c_avr.c"
void main()
{

 DDRD = 0xFF;

 TWI_Init(100000);
 TWI_Start();
 TWI_Write(0xA2);
 TWI_Write(2);
 TWI_Write(0xAA);
 TWI_Stop();

 delay_ms(100);

 TWI_Start();
 TWI_Write(0xA2);
 TWI_Write(2);
 TWI_Start();
 TWI_Write(0xA3);
 PORTD = TWI_Read(0u);
 TWI_Stop();

 while(1);

}
