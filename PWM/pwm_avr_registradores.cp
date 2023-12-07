#line 1 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/PWM/pwm_avr_registradores.c"
#line 18 "C:/Users/walef/OneDrive/Área de Trabalho/Curso AVR/PWM/pwm_avr_registradores.c"
char duty = 0;

void main()
{

 DDB1_bit = 1;

 TCCR1A = 0xA1;

 TCCR1B = 0x09;


 while(1)
 {
 duty += 10;
 delay_ms(100);
 if(duty > 250) duty = 0;

 OCR1AL = duty;


 }

}
