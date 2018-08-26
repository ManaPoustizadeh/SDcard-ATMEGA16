/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 6/12/2017
Author  : 
Company : 
Comments: 


Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*******************************************************/

#include <mega32a.h>
#include <alcd.h>
#include <ff.h>
#include <delay.h>
#include <stdlib.h>

#define ENTER 1000
#define WRITE 1100
#define READ 1200

void error(int res);
void write_to_file();
void seek_in_file(unsigned long addr);
void read_from_file();
void error(int res);
void readNumber();
int readKey();

interrupt [TIM0_OVF] void timer0_ovf_isr(void){
	TCNT0=0xB2;
	disk_timerproc();
}

FRESULT res;
unsigned int nbytes;
FATFS fat;
FIL file;
FILINFO finfo;
DRESULT dres;
char path[]="0:/file4.txt";
char text1[52]="some text";
char text2[]="Here's some more text...";
char buffer[256];


void main(void){
	int result = 0, n = 0, state = 0, cnt = 0;
	char numStr[6];
	DSTATUS disk_status;
	unsigned int sector_size;
	unsigned long int sector_count;
	
	DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

	DDRB=(0<<DDB7) | (0<<DDB6) | (1<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

	DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

	DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);

	// Timer/Counter 0 initialization
	// Clock source: System Clock
	// Clock value: 7.813 kHz
	// Mode: Normal top=0xFF
	// OC0 output: Disconnected
	// Timer Period: 9.984 ms
	TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (1<<CS00);
	TCNT0=0xB2;
	OCR0=0x00;

	// Timer/Counter 1 initialization
	// Clock source: System Clock
	// Clock value: Timer1 Stopped
	// Mode: Normal top=0xFFFF
	// OC1A output: Disconnected
	// OC1B output: Disconnected
	// Noise Canceler: Off
	// Input Capture on Falling Edge
	// Timer1 Overflow Interrupt: Off
	// Input Capture Interrupt: Off
	// Compare A Match Interrupt: Off
	// Compare B Match Interrupt: Off
	TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	TCNT1H=0x00;
	TCNT1L=0x00;
	ICR1H=0x00;
	ICR1L=0x00;
	OCR1AH=0x00;
	OCR1AL=0x00;
	OCR1BH=0x00;
	OCR1BL=0x00;

	// Timer/Counter 2 initialization
	// Clock source: System Clock
	// Clock value: Timer2 Stopped
	// Mode: Normal top=0xFF
	// OC2 output: Disconnected
	ASSR=0<<AS2;
	TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	TCNT2=0x00;
	OCR2=0x00;

	// Timer(s)/Counter(s) Interrupt(s) initialization
	TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);

	// External Interrupt(s) initialization
	// INT0: Off
	// INT1: Off
	// INT2: Off
	MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	MCUCSR=(0<<ISC2);

	// USART initialization
	// USART disabled
	UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);

	// Analog Comparator initialization
	// Analog Comparator: Off
	// The Analog Comparator's positive input is
	// connected to the AIN0 pin
	// The Analog Comparator's negative input is
	// connected to the AIN1 pin
	ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	SFIOR=(0<<ACME);

	// ADC initialization
	// ADC disabled
	ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);

	// SPI initialization
	// SPI disabled
	SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);

	// TWI initialization
	// TWI disabled
	TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);

	// Alphanumeric LCD initialization
	lcd_init(16);

	// Global enable interrupts
	#asm("sei")
	if ((res=f_mount(0,&fat))!=FR_OK){
		error(1);                      
	}
	   
	if ((res=f_open(&file,path,FA_OPEN_EXISTING | FA_WRITE | FA_READ))!=FR_OK){
		if ((res=f_open(&file,path,FA_CREATE_NEW | FA_WRITE | FA_READ))!=FR_OK){
			error(res);
		}   
	}
	   

	   
	   
	   
		
	   
			 
	while (1){
		int key;
		key= readKey();	
		if(key != -1 && key < 1000 && (state > 1 || cnt == 1)){
			delay_ms(100);
			result*=10;
			result+=key;
			n++;
			itoa(key, numStr );
			lcd_puts(numStr);
			delay_ms(150); 
			state = 100;       
		}  
		   
		else if(state == 100 && key == ENTER){
			lcd_puts(" Enter");
			delay_ms(400);
			lcd_clear();
			state = 1;
			cnt++;
			
			if(cnt == 1 ){
				seek_in_file((unsigned long)result);
				result = 0;
			}
			
			if(cnt == 2){					
				text1[0] = result;
				 write_to_file(); 
				 result = 0;
			}   
			
			if(cnt == 0){
				itoa(result  , numStr);
				lcd_puts("seek : ");
				lcd_puts(numStr);
				delay_ms(200);
				lcd_clear();
				seek_in_file((unsigned long)result);
				result = 0;
				read_from_file();
				itoa(text2[0], numStr);
				lcd_puts(numStr);
				delay_ms(400);				
			}		
		}
		else if(key == READ && cnt == 2){
			lcd_puts("Read");
			delay_ms(400);
			lcd_clear();
			state = 2;
			cnt = -1;
		}
		else if(key == WRITE && (state == 0 || state == 1) && cnt != 1){
				lcd_puts("Write");
				delay_ms(400);
				lcd_clear();
				
				state = 3;
		}
	}
}
void error (int res){
    DDRD=0xFF;
    PORTD=res;
    while(1){}
} 


void read_from_file(){
    if ((res=f_read(&file,text2,1,&nbytes))!=FR_OK){
        error(res);        
    } 
}

void write_to_file(){
if ((res=f_write(&file,text1,1,&nbytes))!=FR_OK)
   error(res);
f_sync(&file);   
}



void seek_in_file(unsigned long addr){
    unsigned long i;
    if ((res=f_lseek(&file, addr))!=FR_OK){
        error(res);
    } 
}



int readKey(){
	int col =-1 ;
	int row;
	DDRC = 0x0F;  
	PORTC.0 = 0;
	PORTC.1 = 0;
	PORTC.2 = 0;
	PORTC.3 = 0;
	PORTC.4 = 1;
	PORTC.5 = 1;
	PORTC.6 = 1;
	PORTC.7 = 1;
	delay_ms (2);
    if(PINC.4 == 0)
        col = 0;
    else if(PINC.5 == 0)
        col = 1;
    else if(PINC.6 == 0)
        col = 2;
    else if(PINC.7 == 0)
        col = 3;       
    DDRC = 0xF0;
    PORTC.0 = 1;
    PORTC.1 = 1;                                                        
    PORTC.2 = 1;
    PORTC.3 = 1;
    PORTC.4 = 0;
    PORTC.5 = 0;
    PORTC.6 = 0;
    PORTC.7 = 0;

    delay_ms(2);

    if(PINC.0 == 0)
        row = 0;
    else if(PINC.1 == 0)
        row = 1;
    else if(PINC.2 == 0)
        row = 2;
    else if(PINC.3 == 0)
        row = 3;
                                                                     
                    
    if(col == 3){
        if(row == 3)
            return ENTER;
        if(row == 2)
            return WRITE;
        if(row == 1)
            return READ;
            
    }              
    
    if(row == 0)
        if(col != 0)
            return -1;
            
    if(col==-1)
        return col;
        
    return col*3+row ;
    
}
void readNumber(){
    readKey();
}
