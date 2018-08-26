
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _res=R5
	.DEF _nbytes=R6
	.DEF _nbytes_msb=R7
	.DEF _dres=R4
	.DEF __lcd_x=R9
	.DEF __lcd_y=R8
	.DEF __lcd_maxx=R11

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_k1:
	.DB  0x20,0x22,0x2A,0x2B,0x2C,0x5B,0x3D,0x5D
	.DB  0x7C,0x7F,0x0
_vst_G102:
	.DB  0x0,0x4,0x0,0x2,0x0,0x1,0x80,0x0
	.DB  0x40,0x0,0x20,0x0,0x10,0x0,0x8,0x0
	.DB  0x4,0x0,0x2,0x0,0x0,0x0
_cst_G102:
	.DB  0x0,0x80,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x40,0x0,0x20,0x0,0x10
	.DB  0x0,0x8,0x0,0x4,0x0,0x2

_0x3:
	.DB  0x30,0x3A,0x2F,0x66,0x69,0x6C,0x65,0x34
	.DB  0x2E,0x74,0x78,0x74
_0x4:
	.DB  0x73,0x6F,0x6D,0x65,0x20,0x74,0x65,0x78
	.DB  0x74
_0x5:
	.DB  0x48,0x65,0x72,0x65,0x27,0x73,0x20,0x73
	.DB  0x6F,0x6D,0x65,0x20,0x6D,0x6F,0x72,0x65
	.DB  0x20,0x74,0x65,0x78,0x74,0x2E,0x2E,0x2E
_0x0:
	.DB  0x20,0x45,0x6E,0x74,0x65,0x72,0x0,0x73
	.DB  0x65,0x65,0x6B,0x20,0x3A,0x20,0x0,0x52
	.DB  0x65,0x61,0x64,0x0,0x57,0x72,0x69,0x74
	.DB  0x65,0x0
_0x2000003:
	.DB  0x80,0xC0
_0x2020003:
	.DB  0x1
_0x2040000:
	.DB  0xEB,0xFE,0x90,0x4D,0x53,0x44,0x4F,0x53
	.DB  0x35,0x2E,0x30,0x0,0x4E,0x4F,0x20,0x4E
	.DB  0x41,0x4D,0x45,0x20,0x20,0x20,0x20,0x46
	.DB  0x41,0x54,0x33,0x32,0x20,0x20,0x20,0x0
	.DB  0x4E,0x4F,0x20,0x4E,0x41,0x4D,0x45,0x20
	.DB  0x20,0x20,0x20,0x46,0x41,0x54,0x20,0x20
	.DB  0x20,0x20,0x20,0x0
_0x2060060:
	.DB  0x1
_0x2060000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0C
	.DW  _path
	.DW  _0x3*2

	.DW  0x09
	.DW  _text1
	.DW  _0x4*2

	.DW  0x18
	.DW  _text2
	.DW  _0x5*2

	.DW  0x07
	.DW  _0x15
	.DW  _0x0*2

	.DW  0x08
	.DW  _0x15+7
	.DW  _0x0*2+7

	.DW  0x05
	.DW  _0x15+15
	.DW  _0x0*2+15

	.DW  0x06
	.DW  _0x15+20
	.DW  _0x0*2+20

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

	.DW  0x01
	.DW  _status_G101
	.DW  _0x2020003*2

	.DW  0x01
	.DW  __seed_G103
	.DW  _0x2060060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************************************************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 6/12/2017
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <ff.h>
;#include <delay.h>
;#include <stdlib.h>
;
;#define ENTER 1000
;#define WRITE 1100
;#define READ 1200
;
;void error(int res);
;void write_to_file();
;void seek_in_file(unsigned long addr);
;void read_from_file();
;void error(int res);
;void readNumber();
;int readKey();
;
;interrupt [TIM0_OVF] void timer0_ovf_isr(void){
; 0000 002A interrupt [12] void timer0_ovf_isr(void){

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 002B 	TCNT0=0xB2;
	LDI  R30,LOW(178)
	OUT  0x32,R30
; 0000 002C 	disk_timerproc();
	CALL _disk_timerproc
; 0000 002D }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;FRESULT res;
;unsigned int nbytes;
;FATFS fat;
;FIL file;
;FILINFO finfo;
;DRESULT dres;
;char path[]="0:/file4.txt";

	.DSEG
;char text1[52]="some text";
;char text2[]="Here's some more text...";
;char buffer[256];
;
;
;void main(void){
; 0000 003B void main(void){

	.CSEG
_main:
; .FSTART _main
; 0000 003C 	int result = 0, n = 0, state = 0, cnt = 0;
; 0000 003D 	char numStr[6];
; 0000 003E 	DSTATUS disk_status;
; 0000 003F 	unsigned int sector_size;
; 0000 0040 	unsigned long int sector_count;
; 0000 0041 
; 0000 0042 	DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	SBIW R28,15
	LDI  R30,LOW(0)
	STD  Y+13,R30
	STD  Y+14,R30
;	result -> R16,R17
;	n -> R18,R19
;	state -> R20,R21
;	cnt -> Y+13
;	numStr -> Y+7
;	disk_status -> Y+6
;	sector_size -> Y+4
;	sector_count -> Y+0
	__GETWRN 16,17,0
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	OUT  0x1A,R30
; 0000 0043 	PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0044 
; 0000 0045 	DDRB=(0<<DDB7) | (0<<DDB6) | (1<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(32)
	OUT  0x17,R30
; 0000 0046 	PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0047 
; 0000 0048 	DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 0049 	PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 004A 
; 0000 004B 	DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 004C 	PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0x12,R30
; 0000 004D 
; 0000 004E 	// Timer/Counter 0 initialization
; 0000 004F 	// Clock source: System Clock
; 0000 0050 	// Clock value: 7.813 kHz
; 0000 0051 	// Mode: Normal top=0xFF
; 0000 0052 	// OC0 output: Disconnected
; 0000 0053 	// Timer Period: 9.984 ms
; 0000 0054 	TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (1<<CS00);
	LDI  R30,LOW(5)
	OUT  0x33,R30
; 0000 0055 	TCNT0=0xB2;
	LDI  R30,LOW(178)
	OUT  0x32,R30
; 0000 0056 	OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x3C,R30
; 0000 0057 
; 0000 0058 	// Timer/Counter 1 initialization
; 0000 0059 	// Clock source: System Clock
; 0000 005A 	// Clock value: Timer1 Stopped
; 0000 005B 	// Mode: Normal top=0xFFFF
; 0000 005C 	// OC1A output: Disconnected
; 0000 005D 	// OC1B output: Disconnected
; 0000 005E 	// Noise Canceler: Off
; 0000 005F 	// Input Capture on Falling Edge
; 0000 0060 	// Timer1 Overflow Interrupt: Off
; 0000 0061 	// Input Capture Interrupt: Off
; 0000 0062 	// Compare A Match Interrupt: Off
; 0000 0063 	// Compare B Match Interrupt: Off
; 0000 0064 	TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0065 	TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0066 	TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0067 	TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0068 	ICR1H=0x00;
	OUT  0x27,R30
; 0000 0069 	ICR1L=0x00;
	OUT  0x26,R30
; 0000 006A 	OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 006B 	OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 006C 	OCR1BH=0x00;
	OUT  0x29,R30
; 0000 006D 	OCR1BL=0x00;
	OUT  0x28,R30
; 0000 006E 
; 0000 006F 	// Timer/Counter 2 initialization
; 0000 0070 	// Clock source: System Clock
; 0000 0071 	// Clock value: Timer2 Stopped
; 0000 0072 	// Mode: Normal top=0xFF
; 0000 0073 	// OC2 output: Disconnected
; 0000 0074 	ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0075 	TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0076 	TCNT2=0x00;
	OUT  0x24,R30
; 0000 0077 	OCR2=0x00;
	OUT  0x23,R30
; 0000 0078 
; 0000 0079 	// Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 007A 	TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (1<<TOIE0);
	LDI  R30,LOW(1)
	OUT  0x39,R30
; 0000 007B 
; 0000 007C 	// External Interrupt(s) initialization
; 0000 007D 	// INT0: Off
; 0000 007E 	// INT1: Off
; 0000 007F 	// INT2: Off
; 0000 0080 	MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(0)
	OUT  0x35,R30
; 0000 0081 	MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0082 
; 0000 0083 	// USART initialization
; 0000 0084 	// USART disabled
; 0000 0085 	UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0086 
; 0000 0087 	// Analog Comparator initialization
; 0000 0088 	// Analog Comparator: Off
; 0000 0089 	// The Analog Comparator's positive input is
; 0000 008A 	// connected to the AIN0 pin
; 0000 008B 	// The Analog Comparator's negative input is
; 0000 008C 	// connected to the AIN1 pin
; 0000 008D 	ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 008E 	SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 008F 
; 0000 0090 	// ADC initialization
; 0000 0091 	// ADC disabled
; 0000 0092 	ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 0093 
; 0000 0094 	// SPI initialization
; 0000 0095 	// SPI disabled
; 0000 0096 	SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 0097 
; 0000 0098 	// TWI initialization
; 0000 0099 	// TWI disabled
; 0000 009A 	TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 009B 
; 0000 009C 	// Alphanumeric LCD initialization
; 0000 009D 	lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
; 0000 009E 
; 0000 009F 	// Global enable interrupts
; 0000 00A0 	#asm("sei")
	sei
; 0000 00A1 	if ((res=f_mount(0,&fat))!=FR_OK){
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(_fat)
	LDI  R27,HIGH(_fat)
	CALL _f_mount
	MOV  R5,R30
	CPI  R30,0
	BREQ _0x6
; 0000 00A2 		error(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _error
; 0000 00A3 	}
; 0000 00A4 
; 0000 00A5 	if ((res=f_open(&file,path,FA_OPEN_EXISTING | FA_WRITE | FA_READ))!=FR_OK){
_0x6:
	CALL SUBOPT_0x0
	LDI  R26,LOW(3)
	CALL _f_open
	MOV  R5,R30
	CPI  R30,0
	BREQ _0x7
; 0000 00A6 		if ((res=f_open(&file,path,FA_CREATE_NEW | FA_WRITE | FA_READ))!=FR_OK){
	CALL SUBOPT_0x0
	LDI  R26,LOW(7)
	CALL _f_open
	MOV  R5,R30
	CPI  R30,0
	BREQ _0x8
; 0000 00A7 			error(res);
	CALL SUBOPT_0x1
; 0000 00A8 		}
; 0000 00A9 	}
_0x8:
; 0000 00AA 
; 0000 00AB 	   //writing at specified addr in file
; 0000 00AC 	   seek_in_file(10);
_0x7:
	__GETD2N 0xA
	RCALL _seek_in_file
; 0000 00AD 	   text1[0]=20;
	LDI  R30,LOW(20)
	CALL SUBOPT_0x2
; 0000 00AE 	   write_to_file();
; 0000 00AF 
; 0000 00B0 	   seek_in_file(20);
	__GETD2N 0x14
	RCALL _seek_in_file
; 0000 00B1 	   text1[0]=40;
	LDI  R30,LOW(40)
	CALL SUBOPT_0x2
; 0000 00B2 	   write_to_file();
; 0000 00B3 
; 0000 00B4 	   seek_in_file(22);
	__GETD2N 0x16
	RCALL _seek_in_file
; 0000 00B5 	   text1[0]=43;
	LDI  R30,LOW(43)
	CALL SUBOPT_0x2
; 0000 00B6 	   write_to_file();
; 0000 00B7 
; 0000 00B8 
; 0000 00B9 
; 0000 00BA 
; 0000 00BB 
; 0000 00BC 
; 0000 00BD 	while (1){
_0x9:
; 0000 00BE 		int key;
; 0000 00BF 		key= readKey();
	SBIW R28,2
;	cnt -> Y+15
;	numStr -> Y+9
;	disk_status -> Y+8
;	sector_size -> Y+6
;	sector_count -> Y+2
;	key -> Y+0
	RCALL _readKey
	ST   Y,R30
	STD  Y+1,R31
; 0000 00C0 		if(key != -1 && key < 1000 && (state > 1 || cnt == 1)){
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0xFFFF)
	LDI  R30,HIGH(0xFFFF)
	CPC  R27,R30
	BREQ _0xD
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0xD
	__CPWRN 20,21,2
	BRGE _0xE
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	SBIW R26,1
	BRNE _0xD
_0xE:
	RJMP _0x10
_0xD:
	RJMP _0xC
_0x10:
; 0000 00C1 			delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0000 00C2 			result*=10;
	MOVW R30,R16
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	MOVW R16,R30
; 0000 00C3 			result+=key;
	LD   R30,Y
	LDD  R31,Y+1
	__ADDWRR 16,17,30,31
; 0000 00C4 			n++;
	__ADDWRN 18,19,1
; 0000 00C5 			itoa(key, numStr );
	CALL SUBOPT_0x3
; 0000 00C6 			lcd_puts(numStr);
; 0000 00C7 			delay_ms(150);
	LDI  R26,LOW(150)
	LDI  R27,0
	CALL _delay_ms
; 0000 00C8 			state = 100;
	__GETWRN 20,21,100
; 0000 00C9 		}
; 0000 00CA 
; 0000 00CB 		else if(state == 100 && key == ENTER){
	RJMP _0x11
_0xC:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x13
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BREQ _0x14
_0x13:
	RJMP _0x12
_0x14:
; 0000 00CC 			lcd_puts(" Enter");
	__POINTW2MN _0x15,0
	CALL SUBOPT_0x4
; 0000 00CD 			delay_ms(400);
; 0000 00CE 			lcd_clear();
; 0000 00CF 			state = 1;
	__GETWRN 20,21,1
; 0000 00D0 			cnt++;
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ADIW R30,1
	STD  Y+15,R30
	STD  Y+15+1,R31
; 0000 00D1 
; 0000 00D2 			if(cnt == 1 ){
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	SBIW R26,1
	BRNE _0x16
; 0000 00D3 				seek_in_file((unsigned long)result);
	CALL SUBOPT_0x5
; 0000 00D4 				result = 0;
; 0000 00D5 			}
; 0000 00D6 
; 0000 00D7 			if(cnt == 2){
_0x16:
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	SBIW R26,2
	BRNE _0x17
; 0000 00D8 				text1[0] = result;
	STS  _text1,R16
; 0000 00D9 				 write_to_file();
	RCALL _write_to_file
; 0000 00DA 				 result = 0;
	__GETWRN 16,17,0
; 0000 00DB 			}
; 0000 00DC 
; 0000 00DD 			if(cnt == 0){
_0x17:
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	SBIW R30,0
	BRNE _0x18
; 0000 00DE 				itoa(result  , numStr);
	ST   -Y,R17
	ST   -Y,R16
	MOVW R26,R28
	ADIW R26,11
	CALL _itoa
; 0000 00DF 				lcd_puts("seek : ");
	__POINTW2MN _0x15,7
	RCALL _lcd_puts
; 0000 00E0 				lcd_puts(numStr);
	MOVW R26,R28
	ADIW R26,9
	RCALL _lcd_puts
; 0000 00E1 				delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
; 0000 00E2 				lcd_clear();
	RCALL _lcd_clear
; 0000 00E3 				seek_in_file((unsigned long)result);
	CALL SUBOPT_0x5
; 0000 00E4 				result = 0;
; 0000 00E5 				read_from_file();
	RCALL _read_from_file
; 0000 00E6 				itoa(text2[0], numStr);
	LDS  R30,_text2
	LDI  R31,0
	CALL SUBOPT_0x3
; 0000 00E7 				lcd_puts(numStr);
; 0000 00E8 				delay_ms(400);
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
; 0000 00E9 			}
; 0000 00EA 		}
_0x18:
; 0000 00EB 		else if(key == READ && cnt == 2){
	RJMP _0x19
_0x12:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x4B0)
	LDI  R30,HIGH(0x4B0)
	CPC  R27,R30
	BRNE _0x1B
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	SBIW R26,2
	BREQ _0x1C
_0x1B:
	RJMP _0x1A
_0x1C:
; 0000 00EC 			lcd_puts("Read");
	__POINTW2MN _0x15,15
	CALL SUBOPT_0x4
; 0000 00ED 			delay_ms(400);
; 0000 00EE 			lcd_clear();
; 0000 00EF 			state = 2;
	__GETWRN 20,21,2
; 0000 00F0 			cnt = -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STD  Y+15,R30
	STD  Y+15+1,R31
; 0000 00F1 		}
; 0000 00F2 		else if(key == WRITE && (state == 0 || state == 1) && cnt != 1){
	RJMP _0x1D
_0x1A:
	LD   R26,Y
	LDD  R27,Y+1
	CPI  R26,LOW(0x44C)
	LDI  R30,HIGH(0x44C)
	CPC  R27,R30
	BRNE _0x1F
	CLR  R0
	CP   R0,R20
	CPC  R0,R21
	BREQ _0x20
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R20
	CPC  R31,R21
	BRNE _0x1F
_0x20:
	LDD  R26,Y+15
	LDD  R27,Y+15+1
	SBIW R26,1
	BRNE _0x22
_0x1F:
	RJMP _0x1E
_0x22:
; 0000 00F3 				lcd_puts("Write");
	__POINTW2MN _0x15,20
	CALL SUBOPT_0x4
; 0000 00F4 				delay_ms(400);
; 0000 00F5 				lcd_clear();
; 0000 00F6 
; 0000 00F7 				state = 3;
	__GETWRN 20,21,3
; 0000 00F8 		}
; 0000 00F9 	}
_0x1E:
_0x1D:
_0x19:
_0x11:
	ADIW R28,2
	RJMP _0x9
; 0000 00FA }
_0x23:
	RJMP _0x23
; .FEND

	.DSEG
_0x15:
	.BYTE 0x1A
;void error (int res){
; 0000 00FB void error (int res){

	.CSEG
_error:
; .FSTART _error
; 0000 00FC     DDRD=0xFF;
	ST   -Y,R27
	ST   -Y,R26
;	res -> Y+0
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 00FD     PORTD=res;
	LD   R30,Y
	OUT  0x12,R30
; 0000 00FE     while(1){}
_0x24:
	RJMP _0x24
; 0000 00FF }
; .FEND
;
;
;void read_from_file(){
; 0000 0102 void read_from_file(){
_read_from_file:
; .FSTART _read_from_file
; 0000 0103     if ((res=f_read(&file,text2,1,&nbytes))!=FR_OK){
	CALL SUBOPT_0x6
	LDI  R30,LOW(_text2)
	LDI  R31,HIGH(_text2)
	CALL SUBOPT_0x7
	CALL _f_read
	MOV  R5,R30
	CPI  R30,0
	BREQ _0x27
; 0000 0104         error(res);
	CALL SUBOPT_0x1
; 0000 0105     }
; 0000 0106 }
_0x27:
	RET
; .FEND
;
;void write_to_file(){
; 0000 0108 void write_to_file(){
_write_to_file:
; .FSTART _write_to_file
; 0000 0109 if ((res=f_write(&file,text1,1,&nbytes))!=FR_OK)
	CALL SUBOPT_0x6
	LDI  R30,LOW(_text1)
	LDI  R31,HIGH(_text1)
	CALL SUBOPT_0x7
	CALL _f_write
	MOV  R5,R30
	CPI  R30,0
	BREQ _0x28
; 0000 010A    error(res);
	CALL SUBOPT_0x1
; 0000 010B f_sync(&file);
_0x28:
	LDI  R26,LOW(_file)
	LDI  R27,HIGH(_file)
	CALL _f_sync
; 0000 010C }
	RET
; .FEND
;
;
;
;void seek_in_file(unsigned long addr){
; 0000 0110 void seek_in_file(unsigned long addr){
_seek_in_file:
; .FSTART _seek_in_file
; 0000 0111     unsigned long i;
; 0000 0112     if ((res=f_lseek(&file, addr))!=FR_OK){
	CALL __PUTPARD2
	SBIW R28,4
;	addr -> Y+4
;	i -> Y+0
	CALL SUBOPT_0x6
	CALL SUBOPT_0x8
	CALL _f_lseek
	MOV  R5,R30
	CPI  R30,0
	BREQ _0x29
; 0000 0113         error(res);
	CALL SUBOPT_0x1
; 0000 0114     }
; 0000 0115 }
_0x29:
	JMP  _0x20E0019
; .FEND
;
;
;
;int readKey(){
; 0000 0119 int readKey(){
_readKey:
; .FSTART _readKey
; 0000 011A 	int col =-1 ;
; 0000 011B 	int row;
; 0000 011C 	DDRC = 0x0F;
	CALL __SAVELOCR4
;	col -> R16,R17
;	row -> R18,R19
	__GETWRN 16,17,-1
	LDI  R30,LOW(15)
	OUT  0x14,R30
; 0000 011D 	PORTC.0 = 0;
	CBI  0x15,0
; 0000 011E 	PORTC.1 = 0;
	CBI  0x15,1
; 0000 011F 	PORTC.2 = 0;
	CBI  0x15,2
; 0000 0120 	PORTC.3 = 0;
	CBI  0x15,3
; 0000 0121 	PORTC.4 = 1;
	SBI  0x15,4
; 0000 0122 	PORTC.5 = 1;
	SBI  0x15,5
; 0000 0123 	PORTC.6 = 1;
	SBI  0x15,6
; 0000 0124 	PORTC.7 = 1;
	SBI  0x15,7
; 0000 0125 	delay_ms (2);
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
; 0000 0126     if(PINC.4 == 0)
	SBIC 0x13,4
	RJMP _0x3A
; 0000 0127         col = 0;
	__GETWRN 16,17,0
; 0000 0128     else if(PINC.5 == 0)
	RJMP _0x3B
_0x3A:
	SBIC 0x13,5
	RJMP _0x3C
; 0000 0129         col = 1;
	__GETWRN 16,17,1
; 0000 012A     else if(PINC.6 == 0)
	RJMP _0x3D
_0x3C:
	SBIC 0x13,6
	RJMP _0x3E
; 0000 012B         col = 2;
	__GETWRN 16,17,2
; 0000 012C     else if(PINC.7 == 0)
	RJMP _0x3F
_0x3E:
	SBIC 0x13,7
	RJMP _0x40
; 0000 012D         col = 3;
	__GETWRN 16,17,3
; 0000 012E     DDRC = 0xF0;
_0x40:
_0x3F:
_0x3D:
_0x3B:
	LDI  R30,LOW(240)
	OUT  0x14,R30
; 0000 012F     PORTC.0 = 1;
	SBI  0x15,0
; 0000 0130     PORTC.1 = 1;
	SBI  0x15,1
; 0000 0131     PORTC.2 = 1;
	SBI  0x15,2
; 0000 0132     PORTC.3 = 1;
	SBI  0x15,3
; 0000 0133     PORTC.4 = 0;
	CBI  0x15,4
; 0000 0134     PORTC.5 = 0;
	CBI  0x15,5
; 0000 0135     PORTC.6 = 0;
	CBI  0x15,6
; 0000 0136     PORTC.7 = 0;
	CBI  0x15,7
; 0000 0137 
; 0000 0138     delay_ms(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
; 0000 0139 
; 0000 013A     if(PINC.0 == 0)
	SBIC 0x13,0
	RJMP _0x51
; 0000 013B         row = 0;
	__GETWRN 18,19,0
; 0000 013C     else if(PINC.1 == 0)
	RJMP _0x52
_0x51:
	SBIC 0x13,1
	RJMP _0x53
; 0000 013D         row = 1;
	__GETWRN 18,19,1
; 0000 013E     else if(PINC.2 == 0)
	RJMP _0x54
_0x53:
	SBIC 0x13,2
	RJMP _0x55
; 0000 013F         row = 2;
	__GETWRN 18,19,2
; 0000 0140     else if(PINC.3 == 0)
	RJMP _0x56
_0x55:
	SBIC 0x13,3
	RJMP _0x57
; 0000 0141         row = 3;
	__GETWRN 18,19,3
; 0000 0142 
; 0000 0143 
; 0000 0144     if(col == 3){
_0x57:
_0x56:
_0x54:
_0x52:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x58
; 0000 0145         if(row == 3)
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x59
; 0000 0146             return ENTER;
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL __LOADLOCR4
	JMP  _0x20E0015
; 0000 0147         if(row == 2)
_0x59:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x5A
; 0000 0148             return WRITE;
	LDI  R30,LOW(1100)
	LDI  R31,HIGH(1100)
	CALL __LOADLOCR4
	JMP  _0x20E0015
; 0000 0149         if(row == 1)
_0x5A:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R18
	CPC  R31,R19
	BRNE _0x5B
; 0000 014A             return READ;
	LDI  R30,LOW(1200)
	LDI  R31,HIGH(1200)
	CALL __LOADLOCR4
	JMP  _0x20E0015
; 0000 014B 
; 0000 014C     }
_0x5B:
; 0000 014D 
; 0000 014E     if(row == 0)
_0x58:
	MOV  R0,R18
	OR   R0,R19
	BRNE _0x5C
; 0000 014F         if(col != 0)
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x5D
; 0000 0150             return -1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CALL __LOADLOCR4
	JMP  _0x20E0015
; 0000 0151 
; 0000 0152     if(col==-1)
_0x5D:
_0x5C:
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x5E
; 0000 0153         return col;
	MOVW R30,R16
	CALL __LOADLOCR4
	JMP  _0x20E0015
; 0000 0154 
; 0000 0155     return col*3+row ;
_0x5E:
	MOVW R30,R16
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12
	ADD  R30,R18
	ADC  R31,R19
	CALL __LOADLOCR4
	JMP  _0x20E0015
; 0000 0156 
; 0000 0157 }
; .FEND
;void readNumber(){
; 0000 0158 void readNumber(){
; 0000 0159     readKey();
; 0000 015A }
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x1B,R30
	__DELAY_USB 13
	SBI  0x1B,3
	__DELAY_USB 13
	CBI  0x1B,3
	__DELAY_USB 13
	JMP  _0x20E001A
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x20E001A
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R9,Y+1
	LDD  R8,Y+0
_0x20E001D:
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x9
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x9
	LDI  R30,LOW(0)
	MOV  R8,R30
	MOV  R9,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	CP   R9,R11
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R8
	MOV  R26,R8
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x20E001A
_0x2000007:
_0x2000004:
	INC  R9
	SBI  0x1B,1
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,1
	RJMP _0x20E001A
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
	SBI  0x1A,3
	SBI  0x1A,1
	SBI  0x1A,2
	CBI  0x1B,3
	CBI  0x1B,1
	CBI  0x1B,2
	LDD  R11,Y+0
	LD   R30,Y
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xA
	CALL SUBOPT_0xA
	CALL SUBOPT_0xA
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
	RJMP _0x20E001A
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
_crc7_G101:
; .FSTART _crc7_G101
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R18,LOW(0)
	LDD  R16,Y+4
_0x2020005:
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LD   R19,X+
	STD  Y+5,R26
	STD  Y+5+1,R27
	LDI  R17,LOW(8)
_0x2020008:
	LSL  R18
	MOV  R30,R18
	EOR  R30,R19
	ANDI R30,LOW(0x80)
	BREQ _0x202000A
	LDI  R30,LOW(9)
	EOR  R18,R30
_0x202000A:
	LSL  R19
	SUBI R17,LOW(1)
	BRNE _0x2020008
	SUBI R16,LOW(1)
	BRNE _0x2020005
	MOV  R30,R18
	LSL  R30
	ORI  R30,1
	CALL __LOADLOCR4
	RJMP _0x20E0016
; .FEND
_wait_ready_G101:
; .FSTART _wait_ready_G101
	ST   -Y,R17
	LDI  R30,LOW(50)
	STS  _timer2_G101,R30
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x202000B:
	SBIS 0xE,7
	RJMP _0x202000B
_0x202000F:
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020011:
	SBIS 0xE,7
	RJMP _0x2020011
	IN   R17,15
	CPI  R17,255
	BREQ _0x2020014
	LDS  R30,_timer2_G101
	CPI  R30,0
	BRNE _0x2020015
_0x2020014:
	RJMP _0x2020010
_0x2020015:
	RJMP _0x202000F
_0x2020010:
	MOV  R30,R17
	RJMP _0x20E0017
; .FEND
_deselect_card_G101:
; .FSTART _deselect_card_G101
	SBI  0x18,4
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020016:
	SBIS 0xE,7
	RJMP _0x2020016
	RET
; .FEND
_rx_datablock_G101:
; .FSTART _rx_datablock_G101
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R30,LOW(20)
	STS  _timer1_G101,R30
_0x202001A:
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x202001C:
	SBIS 0xE,7
	RJMP _0x202001C
	IN   R17,15
	CPI  R17,255
	BRNE _0x202001F
	LDS  R30,_timer1_G101
	CPI  R30,0
	BRNE _0x2020020
_0x202001F:
	RJMP _0x202001B
_0x2020020:
	RJMP _0x202001A
_0x202001B:
	CPI  R17,254
	BREQ _0x2020021
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20E0019
_0x2020021:
	__GETWRS 18,19,6
_0x2020023:
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020025:
	SBIS 0xE,7
	RJMP _0x2020025
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0xF
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020028:
	SBIS 0xE,7
	RJMP _0x2020028
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0xF
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x202002B:
	SBIS 0xE,7
	RJMP _0x202002B
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0xF
	POP  R26
	POP  R27
	ST   X,R30
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x202002E:
	SBIS 0xE,7
	RJMP _0x202002E
	PUSH R19
	PUSH R18
	__ADDWRN 18,19,1
	IN   R30,0xF
	POP  R26
	POP  R27
	ST   X,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	SBIW R30,4
	STD  Y+4,R30
	STD  Y+4+1,R31
	BRNE _0x2020023
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020031:
	SBIS 0xE,7
	RJMP _0x2020031
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020034:
	SBIS 0xE,7
	RJMP _0x2020034
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x20E0019
; .FEND
_tx_datablock_G101:
; .FSTART _tx_datablock_G101
	ST   -Y,R26
	CALL __SAVELOCR4
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BREQ _0x2020037
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20E0016
_0x2020037:
	LDD  R30,Y+4
	OUT  0xF,R30
_0x2020038:
	SBIS 0xE,7
	RJMP _0x2020038
	LDD  R26,Y+4
	CPI  R26,LOW(0xFD)
	BREQ _0x202003B
	LDI  R16,LOW(0)
	__GETWRS 18,19,5
_0x202003D:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	OUT  0xF,R30
_0x202003F:
	SBIS 0xE,7
	RJMP _0x202003F
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	OUT  0xF,R30
_0x2020042:
	SBIS 0xE,7
	RJMP _0x2020042
	SUBI R16,LOW(1)
	BRNE _0x202003D
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020045:
	SBIS 0xE,7
	RJMP _0x2020045
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020048:
	SBIS 0xE,7
	RJMP _0x2020048
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x202004B:
	SBIS 0xE,7
	RJMP _0x202004B
	IN   R17,15
	MOV  R30,R17
	ANDI R30,LOW(0x1F)
	CPI  R30,LOW(0x5)
	BREQ _0x202004E
	LDI  R30,LOW(0)
	CALL __LOADLOCR4
	RJMP _0x20E0016
_0x202004E:
_0x202003B:
	LDI  R30,LOW(1)
	CALL __LOADLOCR4
	RJMP _0x20E0016
; .FEND
_send_cmd_G101:
; .FSTART _send_cmd_G101
	CALL __PUTPARD2
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	ANDI R30,LOW(0x80)
	BREQ _0x202004F
	LDD  R30,Y+6
	ANDI R30,0x7F
	STD  Y+6,R30
	LDI  R30,LOW(119)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	MOV  R16,R30
	CPI  R16,2
	BRLO _0x2020050
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0016
_0x2020050:
_0x202004F:
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BREQ _0x2020051
	RCALL _deselect_card_G101
	CBI  0x18,4
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BREQ _0x2020052
	LDI  R30,LOW(255)
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0016
_0x2020052:
_0x2020051:
	LDD  R30,Y+6
	OUT  0xF,R30
_0x2020053:
	SBIS 0xE,7
	RJMP _0x2020053
	LDD  R30,Y+5
	OUT  0xF,R30
_0x2020056:
	SBIS 0xE,7
	RJMP _0x2020056
	LDD  R30,Y+4
	OUT  0xF,R30
_0x2020059:
	SBIS 0xE,7
	RJMP _0x2020059
	LDD  R30,Y+3
	OUT  0xF,R30
_0x202005C:
	SBIS 0xE,7
	RJMP _0x202005C
	LDD  R30,Y+2
	OUT  0xF,R30
_0x202005F:
	SBIS 0xE,7
	RJMP _0x202005F
	LDI  R17,LOW(1)
	LDD  R26,Y+6
	CPI  R26,LOW(0x40)
	BRNE _0x2020062
	LDI  R17,LOW(149)
	RJMP _0x2020063
_0x2020062:
	LDD  R26,Y+6
	CPI  R26,LOW(0x48)
	BRNE _0x2020064
	LDI  R17,LOW(135)
_0x2020064:
_0x2020063:
	OUT  0xF,R17
_0x2020065:
	SBIS 0xE,7
	RJMP _0x2020065
	LDD  R26,Y+6
	CPI  R26,LOW(0x4C)
	BRNE _0x2020068
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020069:
	SBIS 0xE,7
	RJMP _0x2020069
_0x2020068:
	LDI  R17,LOW(255)
_0x202006D:
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x202006F:
	SBIS 0xE,7
	RJMP _0x202006F
	IN   R16,15
	SBRS R16,7
	RJMP _0x2020072
	SUBI R17,LOW(1)
	BRNE _0x2020073
_0x2020072:
	RJMP _0x202006E
_0x2020073:
	RJMP _0x202006D
_0x202006E:
	MOV  R30,R16
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20E0016
; .FEND
_rx_spi4_G101:
; .FSTART _rx_spi4_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDI  R17,4
_0x2020075:
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020077:
	SBIS 0xE,7
	RJMP _0x2020077
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,1
	STD  Y+1,R26
	STD  Y+1+1,R27
	SBIW R26,1
	IN   R30,0xF
	ST   X,R30
	SUBI R17,LOW(1)
	BRNE _0x2020075
	RJMP _0x20E0013
; .FEND
_disk_initialize:
; .FSTART _disk_initialize
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	LDD  R30,Y+8
	CPI  R30,0
	BREQ _0x202007A
	LDI  R30,LOW(1)
	RJMP _0x20E001C
_0x202007A:
	LDI  R30,LOW(10)
	STS  _timer1_G101,R30
_0x202007B:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BRNE _0x202007B
	LDS  R30,_status_G101
	ANDI R30,LOW(0x2)
	BREQ _0x202007E
	RJMP _0x20E001B
_0x202007E:
	SBI  0x17,4
	SBI  0x18,4
	IN   R30,0x18
	ANDI R30,LOW(0x5F)
	OUT  0x18,R30
	SBI  0x18,6
	CBI  0x17,6
	IN   R30,0x17
	ORI  R30,LOW(0xB0)
	OUT  0x17,R30
	LDI  R30,LOW(82)
	OUT  0xD,R30
	LDI  R30,LOW(0)
	OUT  0xE,R30
	LDI  R19,LOW(5)
_0x2020080:
	LDI  R17,LOW(10)
_0x2020083:
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x2020085:
	SBIS 0xE,7
	RJMP _0x2020085
	SUBI R17,LOW(1)
	BRNE _0x2020083
	LDI  R30,LOW(64)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	MOV  R16,R30
	SUBI R19,LOW(1)
	CPI  R16,1
	BREQ _0x2020088
	CPI  R19,0
	BRNE _0x2020089
_0x2020088:
	RJMP _0x2020081
_0x2020089:
	RJMP _0x2020080
_0x2020081:
	LDI  R19,LOW(0)
	CPI  R16,1
	BREQ PC+2
	RJMP _0x202008A
	LDI  R30,LOW(100)
	STS  _timer1_G101,R30
	LDI  R30,LOW(72)
	ST   -Y,R30
	__GETD2N 0x1AA
	RCALL _send_cmd_G101
	CPI  R30,LOW(0x1)
	BRNE _0x202008B
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G101
	LDD  R26,Y+6
	CPI  R26,LOW(0x1)
	BRNE _0x202008D
	LDD  R26,Y+7
	CPI  R26,LOW(0xAA)
	BREQ _0x202008E
_0x202008D:
	RJMP _0x202008C
_0x202008E:
_0x202008F:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x2020092
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x40000000
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x2020093
_0x2020092:
	RJMP _0x2020091
_0x2020093:
	RJMP _0x202008F
_0x2020091:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x2020095
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BREQ _0x2020096
_0x2020095:
	RJMP _0x2020094
_0x2020096:
	MOVW R26,R28
	ADIW R26,4
	RCALL _rx_spi4_G101
	LDD  R30,Y+4
	ANDI R30,LOW(0x40)
	BREQ _0x2020097
	LDI  R30,LOW(12)
	RJMP _0x2020098
_0x2020097:
	LDI  R30,LOW(4)
_0x2020098:
	MOV  R19,R30
_0x2020094:
_0x202008C:
	RJMP _0x202009A
_0x202008B:
	LDI  R30,LOW(233)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,LOW(0x2)
	BRSH _0x202009B
	LDI  R19,LOW(2)
	LDI  R16,LOW(233)
	RJMP _0x202009C
_0x202009B:
	LDI  R19,LOW(1)
	LDI  R16,LOW(65)
_0x202009C:
_0x202009D:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x20200A0
	ST   -Y,R16
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200A1
_0x20200A0:
	RJMP _0x202009F
_0x20200A1:
	RJMP _0x202009D
_0x202009F:
	LDS  R30,_timer1_G101
	CPI  R30,0
	BREQ _0x20200A3
	LDI  R30,LOW(80)
	ST   -Y,R30
	__GETD2N 0x200
	RCALL _send_cmd_G101
	CPI  R30,0
	BREQ _0x20200A2
_0x20200A3:
	LDI  R19,LOW(0)
_0x20200A2:
_0x202009A:
_0x202008A:
	STS  _card_type_G101,R19
	RCALL _deselect_card_G101
	CPI  R19,0
	BREQ _0x20200A5
	LDS  R30,_status_G101
	ANDI R30,0xFE
	STS  _status_G101,R30
	LDI  R30,LOW(80)
	OUT  0xD,R30
	LDI  R30,LOW(1)
	OUT  0xE,R30
	RJMP _0x20200A6
_0x20200A5:
	CBI  0x18,4
	RCALL _wait_ready_G101
	RCALL _deselect_card_G101
	LDI  R30,LOW(0)
	OUT  0xD,R30
	IN   R30,0x17
	ANDI R30,LOW(0xF)
	OUT  0x17,R30
	IN   R30,0x18
	ANDI R30,LOW(0xF)
	OUT  0x18,R30
	CBI  0x17,4
	LDS  R30,_status_G101
	ORI  R30,1
	STS  _status_G101,R30
_0x20200A6:
_0x20E001B:
	LDS  R30,_status_G101
_0x20E001C:
	CALL __LOADLOCR4
	ADIW R28,9
	RET
; .FEND
_disk_status:
; .FSTART _disk_status
	ST   -Y,R26
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20200A7
	LDI  R30,LOW(1)
	RJMP _0x20E001A
_0x20200A7:
	LDS  R30,_status_G101
_0x20E001A:
	ADIW R28,1
	RET
; .FEND
_disk_read:
; .FSTART _disk_read
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20200A9
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20200A8
_0x20200A9:
	LDI  R30,LOW(4)
	RJMP _0x20E0019
_0x20200A8:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x20200AB
	LDI  R30,LOW(3)
	RJMP _0x20E0019
_0x20200AB:
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x8)
	BRNE _0x20200AC
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20200AC:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20200AD
	LDI  R30,LOW(81)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200AE
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200AF
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20200AF:
_0x20200AE:
	RJMP _0x20200B0
_0x20200AD:
	LDI  R30,LOW(82)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200B1
_0x20200B3:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200B4
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20200B3
_0x20200B4:
	LDI  R30,LOW(76)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
_0x20200B1:
_0x20200B0:
	RCALL _deselect_card_G101
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20200B6
	LDI  R30,LOW(1)
	RJMP _0x20200B7
_0x20200B6:
	LDI  R30,LOW(0)
_0x20200B7:
	RJMP _0x20E0019
; .FEND
_disk_write:
; .FSTART _disk_write
	ST   -Y,R26
	LDD  R30,Y+7
	CPI  R30,0
	BRNE _0x20200BA
	LD   R30,Y
	CPI  R30,0
	BRNE _0x20200B9
_0x20200BA:
	LDI  R30,LOW(4)
	RJMP _0x20E0019
_0x20200B9:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x20200BC
	LDI  R30,LOW(3)
	RJMP _0x20E0019
_0x20200BC:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x4)
	BREQ _0x20200BD
	LDI  R30,LOW(2)
	RJMP _0x20E0019
_0x20200BD:
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x8)
	BRNE _0x20200BE
	__GETD1S 1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 1
_0x20200BE:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x20200BF
	LDI  R30,LOW(88)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200C0
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(254)
	RCALL _tx_datablock_G101
	CPI  R30,0
	BREQ _0x20200C1
	LDI  R30,LOW(0)
	ST   Y,R30
_0x20200C1:
_0x20200C0:
	RJMP _0x20200C2
_0x20200BF:
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x6)
	BREQ _0x20200C3
	LDI  R30,LOW(215)
	ST   -Y,R30
	LDD  R26,Y+1
	CLR  R27
	CLR  R24
	CLR  R25
	RCALL _send_cmd_G101
_0x20200C3:
	LDI  R30,LOW(89)
	ST   -Y,R30
	__GETD2S 2
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200C4
_0x20200C6:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(252)
	RCALL _tx_datablock_G101
	CPI  R30,0
	BREQ _0x20200C7
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SUBI R30,LOW(-512)
	SBCI R31,HIGH(-512)
	STD  Y+5,R30
	STD  Y+5+1,R31
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	BRNE _0x20200C6
_0x20200C7:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(253)
	RCALL _tx_datablock_G101
	CPI  R30,0
	BRNE _0x20200C9
	LDI  R30,LOW(1)
	ST   Y,R30
_0x20200C9:
_0x20200C4:
_0x20200C2:
	RCALL _deselect_card_G101
	LD   R30,Y
	CPI  R30,0
	BREQ _0x20200CA
	LDI  R30,LOW(1)
	RJMP _0x20200CB
_0x20200CA:
	LDI  R30,LOW(0)
_0x20200CB:
_0x20E0019:
	ADIW R28,8
	RET
; .FEND
_disk_ioctl:
; .FSTART _disk_ioctl
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,16
	CALL __SAVELOCR4
	LDD  R30,Y+23
	CPI  R30,0
	BREQ _0x20200CD
	LDI  R30,LOW(4)
	RJMP _0x20E0018
_0x20200CD:
	LDS  R30,_status_G101
	ANDI R30,LOW(0x1)
	BREQ _0x20200CE
	LDI  R30,LOW(3)
	RJMP _0x20E0018
_0x20200CE:
	LDI  R17,LOW(1)
	LDD  R30,Y+22
	CPI  R30,0
	BRNE _0x20200D2
	CBI  0x18,4
	RCALL _wait_ready_G101
	CPI  R30,LOW(0xFF)
	BRNE _0x20200D3
	LDI  R17,LOW(0)
_0x20200D3:
	RJMP _0x20200D1
_0x20200D2:
	CPI  R30,LOW(0x1)
	BREQ PC+2
	RJMP _0x20200D4
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200D6
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BRNE _0x20200D7
_0x20200D6:
	RJMP _0x20200D5
_0x20200D7:
	LDD  R30,Y+4
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	CPI  R30,LOW(0x1)
	BRNE _0x20200D8
	LDI  R30,0
	LDD  R31,Y+12
	LDD  R26,Y+13
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	MOVW R18,R30
	MOVW R26,R18
	CLR  R24
	CLR  R25
	LDI  R30,LOW(10)
	RJMP _0x2020104
_0x20200D8:
	LDD  R30,Y+9
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+14
	ANDI R30,LOW(0x80)
	ROL  R30
	LDI  R30,0
	ROL  R30
	ADD  R26,R30
	LDD  R30,Y+13
	ANDI R30,LOW(0x3)
	LSL  R30
	ADD  R30,R26
	SUBI R30,-LOW(2)
	MOV  R16,R30
	LDD  R30,Y+12
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	MOV  R26,R30
	LDD  R30,Y+11
	LDI  R31,0
	CALL __LSLW2
	LDI  R27,0
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+10
	ANDI R30,LOW(0x3)
	LDI  R31,0
	CALL __LSLW2
	MOV  R31,R30
	LDI  R30,0
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	MOVW R18,R30
	MOVW R26,R18
	CLR  R24
	CLR  R25
	MOV  R30,R16
	SUBI R30,LOW(9)
_0x2020104:
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20200D5:
	RJMP _0x20200D1
_0x20200D4:
	CPI  R30,LOW(0x2)
	BRNE _0x20200DA
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	ST   X+,R30
	ST   X,R31
	LDI  R17,LOW(0)
	RJMP _0x20200D1
_0x20200DA:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x20200DB
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x4)
	BREQ _0x20200DC
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200DD
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x20200DE:
	SBIS 0xE,7
	RJMP _0x20200DE
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200E1
	LDI  R16,LOW(48)
_0x20200E3:
	CPI  R16,0
	BREQ _0x20200E4
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x20200E5:
	SBIS 0xE,7
	RJMP _0x20200E5
	SUBI R16,1
	RJMP _0x20200E3
_0x20200E4:
	LDD  R30,Y+14
	SWAP R30
	ANDI R30,0xF
	__GETD2N 0x10
	CALL __LSLD12
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20200E1:
_0x20200DD:
	RJMP _0x20200E8
_0x20200DC:
	LDI  R30,LOW(73)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BREQ PC+2
	RJMP _0x20200E9
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BRNE PC+2
	RJMP _0x20200EA
	LDS  R30,_card_type_G101
	ANDI R30,LOW(0x2)
	BREQ _0x20200EB
	LDD  R30,Y+14
	ANDI R30,LOW(0x3F)
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __LSLD1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+15
	ANDI R30,LOW(0x80)
	CLR  R31
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(7)
	CALL __LSRD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	__ADDD1N 1
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+17
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LSR  R30
	SUBI R30,LOW(1)
	CALL __LSLD12
	RJMP _0x2020105
_0x20200EB:
	LDD  R30,Y+14
	ANDI R30,LOW(0x7C)
	LSR  R30
	LSR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	__ADDD1N 1
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+15
	ANDI R30,LOW(0x3)
	CLR  R31
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(3)
	CALL __LSLD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+15
	ANDI R30,LOW(0xE0)
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ADDD12
	__ADDD1N 1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __MULD12U
_0x2020105:
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL __PUTDP1
	LDI  R17,LOW(0)
_0x20200EA:
_0x20200E9:
_0x20200E8:
	RJMP _0x20200D1
_0x20200DB:
	CPI  R30,LOW(0xA)
	BRNE _0x20200ED
	LDS  R30,_card_type_G101
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ST   X,R30
	LDI  R17,LOW(0)
	RJMP _0x20200D1
_0x20200ED:
	CPI  R30,LOW(0xB)
	BRNE _0x20200EE
	LDI  R16,LOW(73)
	RJMP _0x20200EF
_0x20200EE:
	CPI  R30,LOW(0xC)
	BRNE _0x20200F1
	LDI  R16,LOW(74)
_0x20200EF:
	ST   -Y,R16
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200F2
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(16)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200F3
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(15)
	RCALL _crc7_G101
	MOV  R26,R30
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	LDD  R30,Z+15
	CP   R30,R26
	BRNE _0x20200F4
	LDI  R17,LOW(0)
_0x20200F4:
_0x20200F3:
_0x20200F2:
	RJMP _0x20200D1
_0x20200F1:
	CPI  R30,LOW(0xD)
	BRNE _0x20200F5
	LDI  R30,LOW(122)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200F6
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL _rx_spi4_G101
	LDI  R17,LOW(0)
_0x20200F6:
	RJMP _0x20200D1
_0x20200F5:
	CPI  R30,LOW(0xE)
	BRNE _0x20200FD
	LDI  R30,LOW(205)
	ST   -Y,R30
	__GETD2N 0x0
	RCALL _send_cmd_G101
	CPI  R30,0
	BRNE _0x20200F8
	LDI  R30,LOW(255)
	OUT  0xF,R30
_0x20200F9:
	SBIS 0xE,7
	RJMP _0x20200F9
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(64)
	LDI  R27,0
	RCALL _rx_datablock_G101
	CPI  R30,0
	BREQ _0x20200FC
	LDI  R17,LOW(0)
_0x20200FC:
_0x20200F8:
	RJMP _0x20200D1
_0x20200FD:
	LDI  R17,LOW(4)
_0x20200D1:
	RCALL _deselect_card_G101
	MOV  R30,R17
_0x20E0018:
	CALL __LOADLOCR4
	ADIW R28,24
	RET
; .FEND
_disk_timerproc:
; .FSTART _disk_timerproc
	ST   -Y,R17
	LDS  R17,_timer1_G101
	CPI  R17,0
	BREQ _0x20200FE
	SUBI R17,LOW(1)
	STS  _timer1_G101,R17
_0x20200FE:
	LDS  R17,_timer2_G101
	CPI  R17,0
	BREQ _0x20200FF
	SUBI R17,LOW(1)
	STS  _timer2_G101,R17
_0x20200FF:
	LDS  R30,_status_G101
	ANDI R30,0xFB
	STS  _status_G101,R30
_0x20E0017:
	LD   R17,Y+
	RET
; .FEND

	.CSEG
_get_fattime:
; .FSTART _get_fattime
	SBIW R28,7
	LDS  R26,_prtc_get_time
	LDS  R27,_prtc_get_time+1
	SBIW R26,0
	BREQ _0x2040004
	LDS  R26,_prtc_get_date
	LDS  R27,_prtc_get_date+1
	SBIW R26,0
	BRNE _0x2040003
_0x2040004:
	__GETD1N 0x3A210000
	RJMP _0x20E0016
_0x2040003:
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,7
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,8
	__CALL1MN _prtc_get_time,0
	MOVW R30,R28
	ADIW R30,3
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,4
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,4
	__CALL1MN _prtc_get_date,0
	LD   R30,Y
	LDD  R31,Y+1
	SUBI R30,LOW(1980)
	SBCI R31,HIGH(1980)
	CLR  R22
	CLR  R23
	MOVW R26,R30
	MOVW R24,R22
	LDI  R30,LOW(25)
	CALL __LSLD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+2
	CALL SUBOPT_0xB
	LDI  R30,LOW(21)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+3
	LDI  R31,0
	CALL __CWD1
	CALL __LSLD16
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+6
	CALL SUBOPT_0xB
	LDI  R30,LOW(11)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R30,Y+5
	CALL SUBOPT_0xB
	LDI  R30,LOW(5)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+4
	LDI  R31,0
	ASR  R31
	ROR  R30
	CALL __CWD1
	CALL __ORD12
_0x20E0016:
	ADIW R28,7
	RET
; .FEND
_chk_chrf_G102:
; .FSTART _chk_chrf_G102
	ST   -Y,R26
	ST   -Y,R17
_0x2040006:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2040009
	LDD  R30,Y+1
	CP   R30,R17
	BRNE _0x204000A
_0x2040009:
	RJMP _0x2040008
_0x204000A:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
	RJMP _0x2040006
_0x2040008:
	MOV  R30,R17
	LDI  R31,0
	LDD  R17,Y+0
_0x20E0015:
	ADIW R28,4
	RET
; .FEND
_move_window_G102:
; .FSTART _move_window_G102
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,46
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	CALL SUBOPT_0xE
	CALL __CPD12
	BRNE PC+2
	RJMP _0x204000B
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x204000C
	CALL SUBOPT_0xF
	CPI  R30,0
	BRNE _0x20E0014
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x10
	MOVW R0,R26
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	MOVW R26,R0
	CALL __ADDD12
	CALL SUBOPT_0xE
	CALL __CPD21
	BRSH _0x204000E
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R17,Z+3
_0x2040010:
	CPI  R17,2
	BRLO _0x2040011
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,26
	CALL __GETD1P
	CALL SUBOPT_0xE
	CALL __ADDD12
	__PUTD1S 1
	CALL SUBOPT_0xF
	SUBI R17,1
	RJMP _0x2040010
_0x2040011:
_0x204000E:
_0x204000C:
	CALL SUBOPT_0xD
	CALL __CPD10
	BREQ _0x2040012
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	CALL SUBOPT_0x11
	BREQ _0x2040013
_0x20E0014:
	LDI  R30,LOW(1)
	LDD  R17,Y+0
	ADIW R28,11
	RET
_0x2040013:
	CALL SUBOPT_0xD
	__PUTD1SNS 9,46
_0x2040012:
_0x204000B:
	LDI  R30,LOW(0)
	LDD  R17,Y+0
	RJMP _0x20E000F
; .FEND
_sync_G102:
; .FSTART _sync_G102
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x12
	MOV  R17,R30
	CPI  R17,0
	BREQ PC+2
	RJMP _0x2040014
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R26,X
	CPI  R26,LOW(0x3)
	BRNE _0x2040016
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R30,Z+5
	CPI  R30,0
	BRNE _0x2040017
_0x2040016:
	RJMP _0x2040015
_0x2040017:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CALL SUBOPT_0x13
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	CALL SUBOPT_0x14
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	SUBI R30,LOW(-510)
	SBCI R31,HIGH(-510)
	LDI  R26,LOW(43605)
	LDI  R27,HIGH(43605)
	STD  Z+0,R26
	STD  Z+1,R27
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	__GETD2N 0x41615252
	CALL SUBOPT_0x15
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	__GETD2N 0x61417272
	CALL SUBOPT_0x15
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,14
	CALL SUBOPT_0x16
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R0,R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,10
	CALL SUBOPT_0x16
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x17
	RCALL _disk_write
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040015:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	RCALL _disk_ioctl
	CPI  R30,0
	BREQ _0x2040018
	LDI  R17,LOW(1)
_0x2040018:
_0x2040014:
	MOV  R30,R17
_0x20E0013:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_get_fat:
; .FSTART _get_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0x18
	CALL SUBOPT_0x19
	BRLO _0x204001A
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x18
	CALL __CPD21
	BRLO _0x2040019
_0x204001A:
	CALL SUBOPT_0x1A
	RJMP _0x20E0012
_0x2040019:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,34
	CALL SUBOPT_0x1B
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x204001F
	__GETWRS 18,19,8
	MOVW R30,R18
	LSR  R31
	ROR  R30
	__ADDWRR 18,19,30,31
	CALL SUBOPT_0x1C
	BREQ _0x2040020
	RJMP _0x204001E
_0x2040020:
	CALL SUBOPT_0x1D
	LD   R16,X
	CLR  R17
	__ADDWRN 18,19,1
	CALL SUBOPT_0x1C
	BRNE _0x204001E
	CALL SUBOPT_0x1D
	LD   R30,X
	MOV  R31,R30
	LDI  R30,0
	__ORWRR 16,17,30,31
	LDD  R30,Y+8
	ANDI R30,LOW(0x1)
	BREQ _0x2040022
	MOVW R30,R16
	CALL __LSRW4
	RJMP _0x204027A
_0x2040022:
	MOVW R30,R16
	ANDI R31,HIGH(0xFFF)
_0x204027A:
	CLR  R22
	CLR  R23
	RJMP _0x20E0012
_0x204001F:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2040025
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x20
	BRNE _0x204001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x21
	CALL SUBOPT_0x22
	RJMP _0x20E0012
_0x2040025:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x204001E
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x23
	CALL SUBOPT_0x20
	BRNE _0x204001E
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x21
	CALL __GETD1P
	__ANDD1N 0xFFFFFFF
	RJMP _0x20E0012
_0x204001E:
	CALL SUBOPT_0x24
_0x20E0012:
	CALL __LOADLOCR4
	ADIW R28,14
	RET
; .FEND
_put_fat:
; .FSTART _put_fat
	CALL __PUTPARD2
	SBIW R28,4
	CALL __SAVELOCR6
	CALL SUBOPT_0x25
	CALL SUBOPT_0x19
	BRLO _0x204002A
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x25
	CALL __CPD21
	BRLO _0x2040029
_0x204002A:
	LDI  R21,LOW(2)
	RJMP _0x204002C
_0x2040029:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,34
	CALL __GETD1P
	__PUTD1S 6
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	LD   R30,X
	LDI  R31,0
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0x2040030
	__GETWRS 16,17,14
	MOVW R30,R16
	LSR  R31
	ROR  R30
	__ADDWRR 16,17,30,31
	CALL SUBOPT_0x26
	BREQ _0x2040031
	RJMP _0x204002F
_0x2040031:
	CALL SUBOPT_0x27
	BREQ _0x2040032
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LDD  R30,Y+10
	LDI  R31,0
	CALL __LSLW4
	OR   R30,R26
	RJMP _0x2040033
_0x2040032:
	LDD  R30,Y+10
_0x2040033:
	MOVW R26,R18
	ST   X,R30
	__ADDWRN 16,17,1
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	CALL SUBOPT_0x26
	BREQ _0x2040035
	RJMP _0x204002F
_0x2040035:
	CALL SUBOPT_0x27
	BREQ _0x2040036
	CALL SUBOPT_0x28
	LDI  R30,LOW(4)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	RJMP _0x2040037
_0x2040036:
	MOVW R26,R18
	LD   R30,X
	ANDI R30,LOW(0xF0)
	MOV  R1,R30
	CALL SUBOPT_0x28
	LDI  R30,LOW(8)
	CALL __LSRD12
	CLR  R31
	CLR  R22
	CLR  R23
	ANDI R30,LOW(0xF)
	OR   R30,R1
_0x2040037:
	MOVW R26,R18
	ST   X,R30
	RJMP _0x204002F
_0x2040030:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x2040039
	CALL SUBOPT_0x29
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x2A
	BRNE _0x204002F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R30,LOW(2)
	CALL SUBOPT_0x2B
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	STD  Z+0,R26
	STD  Z+1,R27
	RJMP _0x204002F
_0x2040039:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x204003D
	CALL SUBOPT_0x29
	CALL SUBOPT_0x23
	CALL SUBOPT_0x2A
	BRNE _0x204002F
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LDI  R30,LOW(4)
	CALL SUBOPT_0x2B
	CALL SUBOPT_0x28
	CALL __PUTDZ20
	RJMP _0x204002F
_0x204003D:
	LDI  R21,LOW(2)
_0x204002F:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
_0x204002C:
	MOV  R30,R21
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_remove_chain_G102:
; .FSTART _remove_chain_G102
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x19
	BRLO _0x204003F
	CALL SUBOPT_0x2D
	BRLO _0x204003E
_0x204003F:
	LDI  R17,LOW(2)
	RJMP _0x2040041
_0x204003E:
	LDI  R17,LOW(0)
_0x2040042:
	CALL SUBOPT_0x2D
	BRLO PC+2
	RJMP _0x2040044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 7
	RCALL _get_fat
	__PUTD1S 1
	CALL SUBOPT_0x2E
	CALL __CPD10
	BREQ _0x2040044
	CALL SUBOPT_0xE
	CALL SUBOPT_0x2F
	BRNE _0x2040046
	LDI  R17,LOW(2)
	RJMP _0x2040044
_0x2040046:
	CALL SUBOPT_0xE
	CALL SUBOPT_0x30
	BRNE _0x2040047
	LDI  R17,LOW(1)
	RJMP _0x2040044
_0x2040047:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 7
	CALL __PUTPARD1
	CALL SUBOPT_0x31
	RCALL _put_fat
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x2040044
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x32
	BREQ _0x2040049
	CALL SUBOPT_0x33
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x2040049:
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x34
	RJMP _0x2040042
_0x2040044:
_0x2040041:
	MOV  R30,R17
	LDD  R17,Y+0
	RJMP _0x20E000F
; .FEND
_create_chain_G102:
; .FSTART _create_chain_G102
	CALL __PUTPARD2
	SBIW R28,16
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,30
	CALL __GETD1P
	CALL SUBOPT_0x35
	CALL SUBOPT_0x36
	CALL __CPD10
	BRNE _0x204004A
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,10
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x37
	CALL __CPD02
	BREQ _0x204004C
	CALL SUBOPT_0x38
	CALL SUBOPT_0x37
	CALL __CPD21
	BRLO _0x204004B
_0x204004C:
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x39
_0x204004B:
	RJMP _0x204004E
_0x204004A:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x3B
	CALL SUBOPT_0x3C
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x19
	BRSH _0x204004F
	CALL SUBOPT_0x1A
	RJMP _0x20E0011
_0x204004F:
	CALL SUBOPT_0x38
	CALL SUBOPT_0x3D
	CALL __CPD21
	BRSH _0x2040050
	CALL SUBOPT_0x3E
	RJMP _0x20E0011
_0x2040050:
	CALL SUBOPT_0x36
	CALL SUBOPT_0x39
_0x204004E:
	CALL SUBOPT_0x3F
	CALL SUBOPT_0x40
_0x2040052:
	CALL SUBOPT_0x41
	__SUBD1N -1
	CALL SUBOPT_0x40
	CALL SUBOPT_0x38
	CALL SUBOPT_0x18
	CALL __CPD21
	BRLO _0x2040054
	__GETD1N 0x2
	CALL SUBOPT_0x40
	CALL SUBOPT_0x42
	BRSH _0x2040055
	CALL SUBOPT_0x43
	RJMP _0x20E0011
_0x2040055:
_0x2040054:
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x28
	CALL SUBOPT_0x3C
	CALL SUBOPT_0x44
	BREQ _0x2040053
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x30
	BREQ _0x2040058
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x2F
	BRNE _0x2040057
_0x2040058:
	CALL SUBOPT_0x3E
	RJMP _0x20E0011
_0x2040057:
	CALL SUBOPT_0x42
	BRNE _0x204005A
	CALL SUBOPT_0x43
	RJMP _0x20E0011
_0x204005A:
	RJMP _0x2040052
_0x2040053:
	CALL SUBOPT_0x3A
	__GETD1S 10
	CALL __PUTPARD1
	__GETD2N 0xFFFFFFF
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x204005B
	CALL SUBOPT_0x24
	RJMP _0x20E0011
_0x204005B:
	CALL SUBOPT_0x36
	CALL __CPD10
	BREQ _0x204005C
	CALL SUBOPT_0x3A
	CALL SUBOPT_0x45
	CALL __PUTPARD1
	CALL SUBOPT_0x25
	RCALL _put_fat
	CPI  R30,0
	BREQ _0x204005D
	CALL SUBOPT_0x24
	RJMP _0x20E0011
_0x204005D:
_0x204005C:
	CALL SUBOPT_0x41
	__PUTD1SNS 20,10
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	CALL SUBOPT_0x32
	BREQ _0x204005E
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,14
	CALL __GETD1P_INC
	SBIW R30,1
	SBCI R22,0
	SBCI R23,0
	CALL __PUTDP1_DEC
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	ADIW R26,5
	LDI  R30,LOW(1)
	ST   X,R30
_0x204005E:
	CALL SUBOPT_0x41
_0x20E0011:
	ADIW R28,22
	RET
; .FEND
_clust2sect:
; .FSTART _clust2sect
	CALL __PUTPARD2
	CALL SUBOPT_0x38
	__SUBD1N 2
	CALL SUBOPT_0x35
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	__GETD2Z 30
	__GETD1N 0x2
	CALL SUBOPT_0x46
	CALL __GETD2S0
	CALL __CPD21
	BRLO _0x204005F
	CALL SUBOPT_0x43
	RJMP _0x20E000B
_0x204005F:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL __GETD2S0
	CALL __CWD1
	CALL __MULD12U
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,42
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	RJMP _0x20E000B
; .FEND
_dir_seek_G102:
; .FSTART _dir_seek_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__PUTW1SNS 8,4
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,6
	CALL SUBOPT_0x47
	CALL SUBOPT_0x48
	CALL SUBOPT_0x2F
	BREQ _0x2040061
	CALL SUBOPT_0x49
	CALL SUBOPT_0x4A
	BRLO _0x2040060
_0x2040061:
	LDI  R30,LOW(2)
	RJMP _0x20E0010
_0x2040060:
	CALL SUBOPT_0x4B
	BRNE _0x2040064
	CALL SUBOPT_0x49
	LD   R26,Z
	CPI  R26,LOW(0x3)
	BREQ _0x2040065
_0x2040064:
	RJMP _0x2040063
_0x2040065:
	CALL SUBOPT_0x49
	ADIW R30,38
	MOVW R26,R30
	CALL SUBOPT_0x47
_0x2040063:
	CALL SUBOPT_0x4B
	BRNE _0x2040066
	CALL SUBOPT_0x4C
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x2040067
	LDI  R30,LOW(2)
	RJMP _0x20E0010
_0x2040067:
	CALL SUBOPT_0x49
	ADIW R30,38
	MOVW R26,R30
	CALL __GETD1P
	RJMP _0x204027B
_0x2040066:
	CALL SUBOPT_0x49
	LDD  R30,Z+2
	LDI  R26,LOW(16)
	MUL  R30,R26
	MOVW R16,R0
_0x2040069:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CP   R26,R16
	CPC  R27,R17
	BRLO _0x204006B
	CALL SUBOPT_0x49
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x37
	RCALL _get_fat
	__PUTD1S 2
	CALL SUBOPT_0x48
	CALL SUBOPT_0x30
	BRNE _0x204006C
	LDI  R30,LOW(1)
	RJMP _0x20E0010
_0x204006C:
	CALL SUBOPT_0x48
	CALL SUBOPT_0x19
	BRLO _0x204006E
	CALL SUBOPT_0x49
	CALL SUBOPT_0x4A
	BRLO _0x204006D
_0x204006E:
	LDI  R30,LOW(2)
	RJMP _0x20E0010
_0x204006D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUB  R30,R16
	SBC  R31,R17
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2040069
_0x204006B:
	CALL SUBOPT_0x4C
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x37
	RCALL _clust2sect
_0x204027B:
	MOVW R26,R30
	MOVW R24,R22
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __LSRW4
	CALL SUBOPT_0x4D
	__PUTD1SNS 8,14
	CALL SUBOPT_0x49
	ADIW R30,50
	MOVW R26,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x4E
	__PUTW1SNS 8,18
	LDI  R30,LOW(0)
_0x20E0010:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
_dir_next_G102:
; .FSTART _dir_next_G102
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,4
	CALL __GETW1P
	ADIW R30,1
	MOVW R16,R30
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2040071
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,14
	CALL SUBOPT_0x4F
	BRNE _0x2040070
_0x2040071:
	LDI  R30,LOW(4)
	RJMP _0x20E000E
_0x2040070:
	MOVW R30,R16
	ANDI R30,LOW(0xF)
	BREQ PC+2
	RJMP _0x2040073
	CALL SUBOPT_0x33
	ADIW R26,10
	CALL SUBOPT_0x4F
	BRNE _0x2040074
	CALL SUBOPT_0x50
	ADIW R30,8
	MOVW R26,R30
	CALL __GETW1P
	CP   R16,R30
	CPC  R17,R31
	BRLO _0x2040075
	LDI  R30,LOW(4)
	RJMP _0x20E000E
_0x2040075:
	RJMP _0x2040076
_0x2040074:
	MOVW R30,R16
	CALL __LSRW4
	MOVW R0,R30
	CALL SUBOPT_0x50
	LDD  R30,Z+2
	LDI  R31,0
	SBIW R30,1
	AND  R30,R0
	AND  R31,R1
	SBIW R30,0
	BREQ PC+2
	RJMP _0x2040077
	CALL SUBOPT_0x50
	CALL SUBOPT_0x51
	RCALL _get_fat
	CALL SUBOPT_0x39
	CALL SUBOPT_0x37
	CALL SUBOPT_0x19
	BRSH _0x2040078
	LDI  R30,LOW(2)
	RJMP _0x20E000E
_0x2040078:
	CALL SUBOPT_0x37
	CALL SUBOPT_0x30
	BRNE _0x2040079
	LDI  R30,LOW(1)
	RJMP _0x20E000E
_0x2040079:
	CALL SUBOPT_0x50
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x37
	CALL __CPD21
	BRSH PC+2
	RJMP _0x204007A
	LDD  R30,Y+8
	CPI  R30,0
	BRNE _0x204007B
	LDI  R30,LOW(4)
	RJMP _0x20E000E
_0x204007B:
	CALL SUBOPT_0x50
	CALL SUBOPT_0x51
	RCALL _create_chain_G102
	CALL SUBOPT_0x52
	CALL __CPD10
	BRNE _0x204007C
	LDI  R30,LOW(7)
	RJMP _0x20E000E
_0x204007C:
	CALL SUBOPT_0x37
	CALL SUBOPT_0x2F
	BRNE _0x204007D
	LDI  R30,LOW(2)
	RJMP _0x20E000E
_0x204007D:
	CALL SUBOPT_0x37
	CALL SUBOPT_0x30
	BRNE _0x204007E
	LDI  R30,LOW(1)
	RJMP _0x20E000E
_0x204007E:
	CALL SUBOPT_0x50
	CALL SUBOPT_0x12
	CPI  R30,0
	BREQ _0x204007F
	LDI  R30,LOW(1)
	RJMP _0x20E000E
_0x204007F:
	CALL SUBOPT_0x50
	CALL SUBOPT_0x14
	CALL SUBOPT_0x50
	MOVW R26,R30
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R30,R26
	CALL SUBOPT_0x53
	POP  R26
	POP  R27
	CALL __PUTDP1
	LDI  R19,LOW(0)
_0x2040081:
	CALL SUBOPT_0x50
	LDD  R30,Z+2
	CP   R19,R30
	BRSH _0x2040082
	CALL SUBOPT_0x50
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0x50
	CALL SUBOPT_0x12
	CPI  R30,0
	BREQ _0x2040083
	LDI  R30,LOW(1)
	RJMP _0x20E000E
_0x2040083:
	CALL SUBOPT_0x50
	ADIW R30,46
	MOVW R26,R30
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
	SUBI R19,-1
	RJMP _0x2040081
_0x2040082:
	CALL SUBOPT_0x50
	ADIW R30,46
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R19
	LDI  R31,0
	CALL __CWD1
	CALL SUBOPT_0x46
	POP  R26
	POP  R27
	CALL __PUTDP1
_0x204007A:
	CALL SUBOPT_0x3F
	__PUTD1SNS 9,10
	CALL SUBOPT_0x50
	CALL SUBOPT_0x53
	__PUTD1SNS 9,14
_0x2040077:
_0x2040076:
_0x2040073:
	MOVW R30,R16
	__PUTW1SNS 9,4
	CALL SUBOPT_0x50
	ADIW R30,50
	MOVW R26,R30
	MOVW R30,R16
	CALL SUBOPT_0x4E
	__PUTW1SNS 9,18
	LDI  R30,LOW(0)
_0x20E000E:
	CALL __LOADLOCR4
_0x20E000F:
	ADIW R28,11
	RET
; .FEND
_dir_find_G102:
; .FSTART _dir_find_G102
	CALL SUBOPT_0x54
	BREQ _0x2040084
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x20E000B
_0x2040084:
_0x2040086:
	CALL SUBOPT_0x55
	BRNE _0x2040087
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	LD   R16,X
	CPI  R16,0
	BRNE _0x2040089
	LDI  R17,LOW(4)
	RJMP _0x2040087
_0x2040089:
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x8)
	BRNE _0x204008B
	CALL SUBOPT_0x56
	CALL _memcmp
	CPI  R30,0
	BREQ _0x204008C
_0x204008B:
	RJMP _0x204008A
_0x204008C:
	RJMP _0x2040087
_0x204008A:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _dir_next_G102
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2040086
_0x2040087:
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x20E000B
; .FEND
_dir_register_G102:
; .FSTART _dir_register_G102
	CALL SUBOPT_0x54
	BRNE _0x2040099
_0x204009B:
	CALL SUBOPT_0x55
	BRNE _0x204009C
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+18
	LDD  R27,Z+19
	LD   R16,X
	CPI  R16,229
	BREQ _0x204009F
	CPI  R16,0
	BRNE _0x204009E
_0x204009F:
	RJMP _0x204009C
_0x204009E:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _dir_next_G102
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x204009B
_0x204009C:
_0x2040099:
	CPI  R17,0
	BRNE _0x20400A1
	CALL SUBOPT_0x55
	BRNE _0x20400A2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	ST   -Y,R19
	ST   -Y,R18
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(32)
	LDI  R27,0
	CALL _memset
	CALL SUBOPT_0x56
	CALL _memcpy
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x18)
	__PUTB1RNS 18,12
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
_0x20400A2:
_0x20400A1:
	MOV  R30,R17
	CALL __LOADLOCR4
	RJMP _0x20E000B
; .FEND
_create_name_G102:
; .FSTART _create_name_G102
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,5
	CALL __SAVELOCR6
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	ADIW R26,20
	LD   R20,X+
	LD   R21,X
	ST   -Y,R21
	ST   -Y,R20
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R26,LOW(11)
	LDI  R27,0
	CALL _memset
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOV  R17,R30
	MOV  R18,R30
	LDI  R30,LOW(8)
	STD  Y+10,R30
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	CALL SUBOPT_0x57
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x2E)
	BRNE _0x20400A5
_0x20400A7:
	CALL SUBOPT_0x58
	CPI  R16,46
	BRNE _0x20400AA
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,3
	BRLT _0x20400A9
_0x20400AA:
	RJMP _0x20400A8
_0x20400A9:
	CALL SUBOPT_0x59
	RJMP _0x20400A7
_0x20400A8:
	CPI  R16,47
	BREQ _0x20400AD
	CPI  R16,92
	BREQ _0x20400AD
	CPI  R16,33
	BRSH _0x20400AE
_0x20400AD:
	RJMP _0x20400AC
_0x20400AE:
	LDI  R30,LOW(6)
	RJMP _0x20E000C
_0x20400AC:
	CALL SUBOPT_0x57
	CALL SUBOPT_0x5A
	BRSH _0x20400AF
	LDI  R30,LOW(36)
	RJMP _0x20400B0
_0x20400AF:
	LDI  R30,LOW(32)
_0x20400B0:
	__PUTB1RNS 20,11
	RJMP _0x20E000D
_0x20400A5:
_0x20400B3:
	CALL SUBOPT_0x58
	CPI  R16,33
	BRLO _0x20400B6
	CPI  R16,47
	BREQ _0x20400B6
	CPI  R16,92
	BRNE _0x20400B5
_0x20400B6:
	RJMP _0x20400B4
_0x20400B5:
	CPI  R16,46
	BREQ _0x20400B9
	LDD  R30,Y+10
	CP   R18,R30
	BRLO _0x20400B8
_0x20400B9:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20400BC
	CPI  R16,46
	BREQ _0x20400BB
_0x20400BC:
	LDI  R30,LOW(6)
	RJMP _0x20E000C
_0x20400BB:
	LDI  R18,LOW(8)
	LDI  R30,LOW(11)
	STD  Y+10,R30
	LSL  R17
	LSL  R17
	RJMP _0x20400B2
_0x20400B8:
	CPI  R16,128
	BRLO _0x20400BE
	ORI  R17,LOW(3)
	LDI  R30,LOW(6)
	RJMP _0x20E000C
_0x20400BE:
	LDI  R30,LOW(_k1*2)
	LDI  R31,HIGH(_k1*2)
	ST   -Y,R31
	ST   -Y,R30
	MOV  R26,R16
	RCALL _chk_chrf_G102
	SBIW R30,0
	BREQ _0x20400C4
	LDI  R30,LOW(6)
	RJMP _0x20E000C
_0x20400C4:
	CPI  R16,65
	BRLO _0x20400C6
	CPI  R16,91
	BRLO _0x20400C7
_0x20400C6:
	RJMP _0x20400C5
_0x20400C7:
	ORI  R17,LOW(2)
	RJMP _0x20400C8
_0x20400C5:
	CPI  R16,97
	BRLO _0x20400CA
	CPI  R16,123
	BRLO _0x20400CB
_0x20400CA:
	RJMP _0x20400C9
_0x20400CB:
	ORI  R17,LOW(1)
	SUBI R16,LOW(32)
_0x20400C9:
_0x20400C8:
	CALL SUBOPT_0x59
_0x20400B2:
	RJMP _0x20400B3
_0x20400B4:
	CALL SUBOPT_0x57
	CALL SUBOPT_0x5A
	BRSH _0x20400CC
	LDI  R30,LOW(4)
	RJMP _0x20400CD
_0x20400CC:
	LDI  R30,LOW(0)
_0x20400CD:
	MOV  R16,R30
	CPI  R18,0
	BRNE _0x20400CF
	LDI  R30,LOW(6)
	RJMP _0x20E000C
_0x20400CF:
	MOVW R26,R20
	LD   R26,X
	CPI  R26,LOW(0xE5)
	BRNE _0x20400D0
	MOVW R26,R20
	LDI  R30,LOW(5)
	ST   X,R30
_0x20400D0:
	LDD  R26,Y+10
	CPI  R26,LOW(0x8)
	BRNE _0x20400D1
	LSL  R17
	LSL  R17
_0x20400D1:
	MOV  R30,R17
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x1)
	BRNE _0x20400D2
	ORI  R16,LOW(16)
_0x20400D2:
	MOV  R30,R17
	ANDI R30,LOW(0xC)
	CPI  R30,LOW(0x4)
	BRNE _0x20400D3
	ORI  R16,LOW(8)
_0x20400D3:
	MOVW R30,R20
	__PUTBZR 16,11
_0x20E000D:
	LDI  R30,LOW(0)
_0x20E000C:
	CALL __LOADLOCR6
	ADIW R28,15
	RET
; .FEND
_follow_path_G102:
; .FSTART _follow_path_G102
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
_0x20400E9:
	LDI  R30,LOW(1)
	CPI  R30,0
	BREQ _0x20400EC
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x20)
	BREQ _0x20400ED
_0x20400EC:
	RJMP _0x20400EB
_0x20400ED:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	RJMP _0x20400E9
_0x20400EB:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x2F)
	BREQ _0x20400EF
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CPI  R26,LOW(0x5C)
	BRNE _0x20400EE
_0x20400EF:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,6
	CALL SUBOPT_0x5B
	RJMP _0x20400F1
_0x20400EE:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL __GETW1P
	ADIW R30,22
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x5C
_0x20400F1:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R26,X
	CLR  R27
	SBIW R26,32
	BRSH _0x20400F2
	CALL SUBOPT_0x5D
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _dir_seek_G102
	MOV  R17,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	CALL SUBOPT_0x5E
	RJMP _0x20400F3
_0x20400F2:
_0x20400F5:
	CALL SUBOPT_0x5D
	MOVW R26,R28
	ADIW R26,6
	RCALL _create_name_G102
	MOV  R17,R30
	CPI  R17,0
	BRNE _0x20400F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL _dir_find_G102
	MOV  R17,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,20
	CALL __GETW1P
	LDD  R30,Z+11
	ANDI R30,LOW(0x4)
	MOV  R16,R30
	CPI  R17,0
	BREQ _0x20400F8
	CPI  R17,4
	BRNE _0x20400FA
	CPI  R16,0
	BREQ _0x20400FB
_0x20400FA:
	RJMP _0x20400F9
_0x20400FB:
	LDI  R17,LOW(5)
_0x20400F9:
	RJMP _0x20400F6
_0x20400F8:
	CPI  R16,0
	BRNE _0x20400F6
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,18
	LD   R18,X+
	LD   R19,X
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BRNE _0x20400FD
	LDI  R17,LOW(5)
	RJMP _0x20400F6
_0x20400FD:
	CALL SUBOPT_0x5F
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x60
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x61
	CALL SUBOPT_0x5C
	RJMP _0x20400F5
_0x20400F6:
_0x20400F3:
	MOV  R30,R17
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; .FEND
_check_fs_G102:
; .FSTART _check_fs_G102
	CALL __PUTPARD2
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 3
	CALL SUBOPT_0x62
	BREQ _0x20400FE
	LDI  R30,LOW(3)
	RJMP _0x20E000B
_0x20400FE:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CALL SUBOPT_0x63
	BREQ _0x20400FF
	LDI  R30,LOW(2)
	RJMP _0x20E000B
_0x20400FF:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SUBI R26,LOW(-104)
	SBCI R27,HIGH(-104)
	CALL SUBOPT_0x64
	BRNE _0x2040100
	LDI  R30,LOW(0)
	RJMP _0x20E000B
_0x2040100:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,50
	SUBI R30,LOW(-82)
	SBCI R31,HIGH(-82)
	MOVW R26,R30
	CALL SUBOPT_0x64
	BRNE _0x2040101
	LDI  R30,LOW(0)
	RJMP _0x20E000B
_0x2040101:
	LDI  R30,LOW(1)
_0x20E000B:
	ADIW R28,6
	RET
; .FEND
_chk_mounted:
; .FSTART _chk_mounted
	ST   -Y,R26
	SBIW R28,20
	CALL __SAVELOCR6
	LDD  R26,Y+29
	LDD  R27,Y+29+1
	CALL __GETW1P
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LD   R30,X
	SUBI R30,LOW(48)
	MOV  R16,R30
	CPI  R16,10
	BRSH _0x2040103
	ADIW R26,1
	LD   R26,X
	CPI  R26,LOW(0x3A)
	BREQ _0x2040104
_0x2040103:
	RJMP _0x2040102
_0x2040104:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,2
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R26,Y+29
	LDD  R27,Y+29+1
	ST   X+,R30
	ST   X,R31
	RJMP _0x2040105
_0x2040102:
	LDS  R16,_Drive_G102
_0x2040105:
	CPI  R16,1
	BRLO _0x2040106
	LDI  R30,LOW(11)
	RJMP _0x20E0009
_0x2040106:
	MOV  R30,R16
	CALL SUBOPT_0x65
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+27
	LDD  R27,Y+27+1
	ST   X+,R30
	ST   X,R31
	SBIW R30,0
	BRNE _0x2040107
	LDI  R30,LOW(12)
	RJMP _0x20E0009
_0x2040107:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2040108
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	CALL _disk_status
	MOV  R21,R30
	SBRC R21,0
	RJMP _0x2040109
	LDD  R30,Y+26
	CPI  R30,0
	BREQ _0x204010B
	SBRC R21,2
	RJMP _0x204010C
_0x204010B:
	RJMP _0x204010A
_0x204010C:
	LDI  R30,LOW(10)
	RJMP _0x20E0009
_0x204010A:
	RJMP _0x20E000A
_0x2040109:
_0x2040108:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOV  R30,R16
	__PUTB1SNS 6,1
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	CALL _disk_initialize
	MOV  R21,R30
	SBRS R21,0
	RJMP _0x204010D
	LDI  R30,LOW(3)
	RJMP _0x20E0009
_0x204010D:
	LDD  R30,Y+26
	CPI  R30,0
	BREQ _0x204010F
	SBRC R21,2
	RJMP _0x2040110
_0x204010F:
	RJMP _0x204010E
_0x2040110:
	LDI  R30,LOW(10)
	RJMP _0x20E0009
_0x204010E:
	CALL SUBOPT_0x5D
	CALL SUBOPT_0x43
	__PUTD1S 24
	MOVW R26,R30
	MOVW R24,R22
	RCALL _check_fs_G102
	MOV  R17,R30
	CPI  R17,1
	BRNE _0x2040111
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-446)
	SBCI R31,HIGH(-446)
	MOVW R18,R30
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x2040112
	MOVW R26,R18
	ADIW R26,8
	CALL __GETD1P
	__PUTD1S 22
	CALL SUBOPT_0x5D
	__GETD2S 24
	RCALL _check_fs_G102
	MOV  R17,R30
_0x2040112:
_0x2040111:
	CPI  R17,3
	BRNE _0x2040113
	LDI  R30,LOW(1)
	RJMP _0x20E0009
_0x2040113:
	CPI  R17,0
	BRNE _0x2040115
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,61
	CALL __GETW1P
	CPI  R30,LOW(0x200)
	LDI  R26,HIGH(0x200)
	CPC  R31,R26
	BREQ _0x2040114
_0x2040115:
	LDI  R30,LOW(13)
	RJMP _0x20E0009
_0x2040114:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-72)
	SBCI R27,HIGH(-72)
	CALL SUBOPT_0x22
	CALL SUBOPT_0x66
	CALL SUBOPT_0x45
	CALL __CPD10
	BRNE _0x2040117
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-86)
	SBCI R27,HIGH(-86)
	CALL __GETD1P
	CALL SUBOPT_0x66
_0x2040117:
	CALL SUBOPT_0x45
	__PUTD1SNS 6,26
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	SUBI R30,LOW(-66)
	SBCI R31,HIGH(-66)
	LD   R30,Z
	__PUTB1SNS 6,3
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+3
	LDI  R31,0
	CALL SUBOPT_0x3B
	CALL __CWD1
	CALL __MULD12U
	CALL SUBOPT_0x66
	CALL SUBOPT_0x67
	CALL SUBOPT_0x68
	__PUTD1SNS 6,34
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+63
	__PUTB1SNS 6,2
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-67)
	SBCI R27,HIGH(-67)
	CALL __GETW1P
	__PUTW1SNS 6,8
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-69)
	SBCI R27,HIGH(-69)
	CALL SUBOPT_0x22
	__PUTD1S 14
	CALL __CPD10
	BRNE _0x2040118
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-82)
	SBCI R27,HIGH(-82)
	CALL __GETD1P
	__PUTD1S 14
_0x2040118:
	CALL SUBOPT_0x67
	CALL SUBOPT_0x25
	CLR  R22
	CLR  R23
	CALL SUBOPT_0x46
	CALL SUBOPT_0x3B
	CALL __SUBD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x69
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CLR  R22
	CLR  R23
	CALL __SUBD21
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	CALL __DIVD21U
	__ADDD1N 2
	__PUTD1S 10
	__PUTD1SNS 6,30
	LDI  R17,LOW(1)
	CALL SUBOPT_0x28
	__CPD2N 0xFF7
	BRLO _0x2040119
	LDI  R17,LOW(2)
_0x2040119:
	CALL SUBOPT_0x28
	__CPD2N 0xFFF7
	BRLO _0x204011A
	LDI  R17,LOW(3)
_0x204011A:
	CPI  R17,3
	BRNE _0x204011B
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-94)
	SBCI R27,HIGH(-94)
	CALL __GETD1P
	RJMP _0x204027C
_0x204011B:
	CALL SUBOPT_0x6A
_0x204027C:
	__PUTD1SNS 6,38
	CALL SUBOPT_0x6A
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x69
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x4D
	__PUTD1SNS 6,42
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,14
	CALL SUBOPT_0x24
	CALL __PUTDP1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,4
	LDI  R30,LOW(0)
	ST   X,R30
	CPI  R17,3
	BREQ PC+2
	RJMP _0x204011D
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,5
	ST   X,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-98)
	SBCI R27,HIGH(-98)
	CALL __GETW1P
	CALL SUBOPT_0x68
	__PUTD1SNS 6,18
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	CALL SUBOPT_0x17
	CALL _disk_read
	CPI  R30,0
	BRNE _0x204011F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x63
	BRNE _0x204011F
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,50
	CALL __GETD1P
	__CPD1N 0x41615252
	BRNE _0x204011F
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-484)
	SBCI R31,HIGH(-484)
	MOVW R26,R30
	CALL __GETD1P
	__CPD1N 0x61417272
	BREQ _0x2040120
_0x204011F:
	RJMP _0x204011E
_0x2040120:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-492)
	SBCI R31,HIGH(-492)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 6,10
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,50
	SUBI R30,LOW(-488)
	SBCI R31,HIGH(-488)
	MOVW R26,R30
	CALL __GETD1P
	__PUTD1SNS 6,14
_0x204011E:
_0x204011D:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ST   X,R17
	CALL SUBOPT_0x13
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,22
	CALL SUBOPT_0x5B
	LDI  R26,LOW(_Fsid_G102)
	LDI  R27,HIGH(_Fsid_G102)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	__PUTW1SNS 6,6
_0x20E000A:
	LDI  R30,LOW(0)
_0x20E0009:
	CALL __LOADLOCR6
	ADIW R28,31
	RET
; .FEND
_validate_G102:
; .FSTART _validate_G102
	ST   -Y,R27
	ST   -Y,R26
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2040122
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R30,X
	CPI  R30,0
	BREQ _0x2040122
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+6
	LDD  R27,Z+7
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x2040121
_0x2040122:
	LDI  R30,LOW(9)
	RJMP _0x20E0008
_0x2040121:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Z+1
	CALL _disk_status
	ANDI R30,LOW(0x1)
	BREQ _0x2040124
	LDI  R30,LOW(3)
	RJMP _0x20E0008
_0x2040124:
	LDI  R30,LOW(0)
_0x20E0008:
	ADIW R28,4
	RET
; .FEND
_f_mount:
; .FSTART _f_mount
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+4
	CPI  R26,LOW(0x1)
	BRLO _0x2040125
	LDI  R30,LOW(11)
	RJMP _0x20E0007
_0x2040125:
	LDD  R30,Y+4
	CALL SUBOPT_0x65
	LD   R16,X+
	LD   R17,X
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x2040126
	MOVW R26,R16
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040126:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	SBIW R30,0
	BREQ _0x2040127
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040127:
	LDD  R30,Y+4
	LDI  R26,LOW(_FatFs_G102)
	LDI  R27,HIGH(_FatFs_G102)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	STD  Z+0,R26
	STD  Z+1,R27
	LDI  R30,LOW(0)
_0x20E0007:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
_f_open:
; .FSTART _f_open
	ST   -Y,R26
	SBIW R28,34
	CALL __SAVELOCR4
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	CALL SUBOPT_0x5E
	LDD  R30,Y+38
	ANDI R30,LOW(0x1F)
	STD  Y+38,R30
	MOVW R30,R28
	ADIW R30,39
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,18
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+42
	ANDI R30,LOW(0x1E)
	MOV  R26,R30
	RCALL _chk_mounted
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2040128
	RJMP _0x20E0006
_0x2040128:
	MOVW R30,R28
	ADIW R30,4
	STD  Y+36,R30
	STD  Y+36+1,R31
	MOVW R30,R28
	ADIW R30,16
	ST   -Y,R31
	ST   -Y,R30
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	RCALL _follow_path_G102
	MOV  R17,R30
	LDD  R30,Y+38
	ANDI R30,LOW(0x1C)
	BRNE PC+2
	RJMP _0x2040129
	SBIW R28,8
	CPI  R17,0
	BREQ _0x204012A
	CPI  R17,4
	BRNE _0x204012B
	MOVW R26,R28
	ADIW R26,24
	RCALL _dir_register_G102
	MOV  R17,R30
_0x204012B:
	CPI  R17,0
	BREQ _0x204012C
	MOV  R30,R17
	ADIW R28,8
	RJMP _0x20E0006
_0x204012C:
	LDD  R30,Y+46
	ORI  R30,8
	STD  Y+46,R30
	__GETWRS 18,19,42
	RJMP _0x204012D
_0x204012A:
	LDD  R30,Y+46
	ANDI R30,LOW(0x4)
	BREQ _0x204012E
	LDI  R30,LOW(8)
	ADIW R28,8
	RJMP _0x20E0006
_0x204012E:
	__GETWRS 18,19,42
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x2040130
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x11)
	BREQ _0x204012F
_0x2040130:
	LDI  R30,LOW(7)
	ADIW R28,8
	RJMP _0x20E0006
_0x204012F:
	LDD  R30,Y+46
	ANDI R30,LOW(0x8)
	BRNE PC+2
	RJMP _0x2040132
	CALL SUBOPT_0x5F
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x60
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x61
	CALL SUBOPT_0x35
	MOVW R30,R18
	ADIW R30,20
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	STD  Z+0,R26
	STD  Z+1,R27
	MOVW R30,R18
	ADIW R30,26
	STD  Z+0,R26
	STD  Z+1,R27
	MOVW R30,R18
	ADIW R30,28
	CALL SUBOPT_0x31
	CALL __PUTDZ20
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,46
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x38
	CALL __CPD10
	BREQ _0x2040133
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x48
	RCALL _remove_chain_G102
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2040134
	ADIW R28,8
	RJMP _0x20E0006
_0x2040134:
	CALL SUBOPT_0x38
	CALL SUBOPT_0x6B
	__PUTD1SNS 24,10
_0x2040133:
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x8
	CALL _move_window_G102
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x2040135
	ADIW R28,8
	RJMP _0x20E0006
_0x2040135:
_0x2040132:
_0x204012D:
	LDD  R30,Y+46
	ANDI R30,LOW(0x8)
	BREQ _0x2040136
	MOVW R30,R18
	ADIW R30,11
	LDI  R26,LOW(0)
	STD  Z+0,R26
	CALL _get_fattime
	CALL SUBOPT_0x52
	__PUTD1RNS 18,14
	LDD  R26,Y+24
	LDD  R27,Y+24+1
	ADIW R26,4
	LDI  R30,LOW(1)
	ST   X,R30
	LDD  R30,Y+46
	ORI  R30,0x20
	STD  Y+46,R30
_0x2040136:
	ADIW R28,8
	RJMP _0x2040137
_0x2040129:
	CPI  R17,0
	BREQ _0x2040138
	MOV  R30,R17
	RJMP _0x20E0006
_0x2040138:
	__GETWRS 18,19,34
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x204013A
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x10)
	BREQ _0x2040139
_0x204013A:
	LDI  R30,LOW(4)
	RJMP _0x20E0006
_0x2040139:
	LDD  R30,Y+38
	ANDI R30,LOW(0x2)
	BREQ _0x204013D
	MOVW R30,R18
	LDD  R30,Z+11
	ANDI R30,LOW(0x1)
	BRNE _0x204013E
_0x204013D:
	RJMP _0x204013C
_0x204013E:
	LDI  R30,LOW(7)
	RJMP _0x20E0006
_0x204013C:
_0x2040137:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,46
	CALL __GETD1P
	__PUTD1SNS 41,26
	LDD  R30,Y+34
	LDD  R31,Y+34+1
	__PUTW1SNS 41,30
	LDD  R30,Y+38
	__PUTB1SNS 41,4
	CALL SUBOPT_0x5F
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x60
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x61
	__PUTD1SNS 41,14
	MOVW R26,R18
	ADIW R26,28
	CALL __GETD1P
	__PUTD1SNS 41,10
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,6
	CALL SUBOPT_0x5B
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ADIW R26,22
	CALL SUBOPT_0x5B
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Y+41
	LDD  R27,Y+41+1
	ST   X+,R30
	ST   X,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,6
	CALL __GETW1P
	__PUTW1SNS 41,2
	LDI  R30,LOW(0)
_0x20E0006:
	CALL __LOADLOCR4
	ADIW R28,43
	RET
; .FEND
_f_read:
; .FSTART _f_read
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,14
	CALL __SAVELOCR6
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x6E
	BREQ _0x204013F
	MOV  R30,R17
	RJMP _0x20E0005
_0x204013F:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x2040140
	LDI  R30,LOW(2)
	RJMP _0x20E0005
_0x2040140:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x1)
	BRNE _0x2040141
	LDI  R30,LOW(7)
	RJMP _0x20E0005
_0x2040141:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	__GETD2Z 10
	PUSH R25
	PUSH R24
	PUSH R27
	PUSH R26
	CALL SUBOPT_0x6F
	POP  R30
	POP  R31
	POP  R22
	POP  R23
	CALL __SUBD12
	CALL SUBOPT_0x40
	CALL SUBOPT_0x41
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CLR  R24
	CLR  R25
	CALL __CPD12
	BRSH _0x2040142
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	STD  Y+22,R30
	STD  Y+22+1,R31
_0x2040142:
_0x2040144:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	SBIW R30,0
	BRNE PC+2
	RJMP _0x2040145
	CALL SUBOPT_0x6F
	CALL SUBOPT_0x70
	BREQ PC+2
	RJMP _0x2040146
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R0,Z+5
	CALL SUBOPT_0x6C
	LDD  R30,Z+2
	CP   R0,R30
	BRLO _0x2040147
	CALL SUBOPT_0x6F
	CALL __CPD02
	BRNE _0x2040148
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,14
	CALL __GETD1P
	RJMP _0x2040149
_0x2040148:
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x71
	CALL _get_fat
_0x2040149:
	__PUTD1S 16
	__GETD2S 16
	CALL SUBOPT_0x19
	BRSH _0x204014B
	CALL SUBOPT_0x72
	LDI  R30,LOW(2)
	RJMP _0x20E0005
_0x204014B:
	__GETD2S 16
	CALL SUBOPT_0x30
	BRNE _0x204014C
	CALL SUBOPT_0x72
	LDI  R30,LOW(1)
	RJMP _0x20E0005
_0x204014C:
	CALL SUBOPT_0x36
	__PUTD1SNS 26,18
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040147:
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x71
	RCALL _clust2sect
	CALL SUBOPT_0x73
	CALL SUBOPT_0x44
	BRNE _0x204014D
	CALL SUBOPT_0x72
	LDI  R30,LOW(2)
	RJMP _0x20E0005
_0x204014D:
	CALL SUBOPT_0x74
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x75
	CALL SUBOPT_0x73
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x76
	BRNE PC+2
	RJMP _0x204014E
	CALL SUBOPT_0x74
	ADD  R30,R20
	ADC  R31,R21
	MOVW R0,R30
	CALL SUBOPT_0x6C
	LDD  R30,Z+2
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x204014F
	CALL SUBOPT_0x6C
	LDD  R30,Z+2
	LDI  R31,0
	MOVW R26,R30
	CALL SUBOPT_0x74
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
_0x204014F:
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x77
	__GETD1S 15
	CALL __PUTPARD1
	MOV  R26,R20
	CALL _disk_read
	CPI  R30,0
	BREQ _0x2040150
	CALL SUBOPT_0x72
	LDI  R30,LOW(1)
	RJMP _0x20E0005
_0x2040150:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2040152
	CALL SUBOPT_0x78
	CALL SUBOPT_0x79
	BRLO _0x2040153
_0x2040152:
	RJMP _0x2040151
_0x2040153:
	CALL SUBOPT_0x78
	CALL SUBOPT_0x7A
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CLR  R24
	CLR  R25
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x6D
	ADIW R30,32
	CALL SUBOPT_0x7B
_0x2040151:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x7C
	RJMP _0x2040143
_0x204014E:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2040154
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x7D
	LDD  R30,Y+29
	LDD  R31,Y+29+1
	CALL SUBOPT_0x7E
	BREQ _0x2040155
	CALL SUBOPT_0x72
	LDI  R30,LOW(1)
	RJMP _0x20E0005
_0x2040155:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x7F
_0x2040154:
	CALL SUBOPT_0x78
	CALL __CPD12
	BREQ _0x2040156
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x7D
	__GETD1S 15
	CALL SUBOPT_0x62
	BREQ _0x2040157
	CALL SUBOPT_0x72
	LDI  R30,LOW(1)
	RJMP _0x20E0005
_0x2040157:
_0x2040156:
	CALL SUBOPT_0x3E
	__PUTD1SNS 26,22
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x80
_0x2040146:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL SUBOPT_0x81
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	CP   R30,R18
	CPC  R31,R19
	BRSH _0x2040158
	__GETWRS 18,19,22
_0x2040158:
	CALL SUBOPT_0x5D
	LDD  R26,Y+28
	LDD  R27,Y+28+1
	CALL SUBOPT_0x81
	LDD  R26,Y+28
	LDD  R27,Y+28+1
	ADIW R26,32
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	CALL _memcpy
_0x2040143:
	CALL SUBOPT_0x82
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	CALL SUBOPT_0x83
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	CALL SUBOPT_0x84
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	SUB  R30,R18
	SBC  R31,R19
	STD  Y+22,R30
	STD  Y+22+1,R31
	RJMP _0x2040144
_0x2040145:
	LDI  R30,LOW(0)
_0x20E0005:
	CALL __LOADLOCR6
	ADIW R28,28
	RET
; .FEND
_f_write:
; .FSTART _f_write
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,10
	CALL __SAVELOCR6
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL SUBOPT_0x5E
	CALL SUBOPT_0x85
	CALL SUBOPT_0x86
	CALL SUBOPT_0x6E
	BREQ _0x2040159
	MOV  R30,R17
	RJMP _0x20E0004
_0x2040159:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x204015A
	LDI  R30,LOW(2)
	RJMP _0x20E0004
_0x204015A:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BRNE _0x204015B
	LDI  R30,LOW(7)
	RJMP _0x20E0004
_0x204015B:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 10
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CALL SUBOPT_0x4D
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x87
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x204015C
	LDI  R30,LOW(0)
	STD  Y+18,R30
	STD  Y+18+1,R30
_0x204015C:
_0x204015E:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	SBIW R30,0
	BRNE PC+2
	RJMP _0x204015F
	CALL SUBOPT_0x88
	CALL SUBOPT_0x70
	BREQ PC+2
	RJMP _0x2040160
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R0,Z+5
	CALL SUBOPT_0x85
	LDD  R30,Z+2
	CP   R0,R30
	BRSH PC+2
	RJMP _0x2040161
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL SUBOPT_0x4F
	BRNE _0x2040162
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,14
	CALL __GETD1P
	CALL SUBOPT_0x73
	CALL SUBOPT_0x44
	BRNE _0x2040163
	CALL SUBOPT_0x85
	CALL SUBOPT_0x89
	CALL SUBOPT_0x73
	__PUTD1SNS 22,14
_0x2040163:
	RJMP _0x2040164
_0x2040162:
	CALL SUBOPT_0x85
	CALL SUBOPT_0x86
	CALL SUBOPT_0x71
	CALL _create_chain_G102
	CALL SUBOPT_0x73
_0x2040164:
	CALL SUBOPT_0x44
	BRNE _0x2040165
	RJMP _0x204015F
_0x2040165:
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x2F
	BRNE _0x2040166
	CALL SUBOPT_0x8A
	LDI  R30,LOW(2)
	RJMP _0x20E0004
_0x2040166:
	CALL SUBOPT_0x3D
	CALL SUBOPT_0x30
	BRNE _0x2040167
	CALL SUBOPT_0x8A
	LDI  R30,LOW(1)
	RJMP _0x20E0004
_0x2040167:
	CALL SUBOPT_0x3E
	__PUTD1SNS 22,18
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,5
	LDI  R30,LOW(0)
	ST   X,R30
_0x2040161:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2040168
	CALL SUBOPT_0x85
	CALL SUBOPT_0x8B
	LDD  R30,Y+25
	LDD  R31,Y+25+1
	CALL SUBOPT_0x7E
	BREQ _0x2040169
	CALL SUBOPT_0x8A
	LDI  R30,LOW(1)
	RJMP _0x20E0004
_0x2040169:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7F
_0x2040168:
	CALL SUBOPT_0x85
	CALL SUBOPT_0x86
	CALL SUBOPT_0x71
	CALL _clust2sect
	CALL SUBOPT_0x40
	CALL SUBOPT_0x41
	CALL __CPD10
	BRNE _0x204016A
	CALL SUBOPT_0x8A
	LDI  R30,LOW(2)
	RJMP _0x20E0004
_0x204016A:
	CALL SUBOPT_0x8C
	CALL SUBOPT_0x18
	CALL SUBOPT_0x75
	CALL SUBOPT_0x40
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	CALL SUBOPT_0x76
	BRNE PC+2
	RJMP _0x204016B
	CALL SUBOPT_0x8C
	ADD  R30,R20
	ADC  R31,R21
	MOVW R0,R30
	CALL SUBOPT_0x85
	LDD  R30,Z+2
	MOVW R26,R0
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x204016C
	CALL SUBOPT_0x85
	LDD  R30,Z+2
	LDI  R31,0
	MOVW R26,R30
	CALL SUBOPT_0x8C
	SUB  R26,R30
	SBC  R27,R31
	MOVW R20,R26
_0x204016C:
	CALL SUBOPT_0x85
	CALL SUBOPT_0x77
	__GETD1S 11
	CALL __PUTPARD1
	MOV  R26,R20
	CALL _disk_write
	CPI  R30,0
	BREQ _0x204016D
	CALL SUBOPT_0x8A
	LDI  R30,LOW(1)
	RJMP _0x20E0004
_0x204016D:
	CALL SUBOPT_0x8D
	CALL SUBOPT_0x79
	BRSH _0x204016E
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0x86
	__GETD2Z 22
	__GETD1S 10
	CALL SUBOPT_0x7A
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CLR  R24
	CLR  R25
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x7B
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7F
_0x204016E:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x7C
	RJMP _0x204015D
_0x204016B:
	CALL SUBOPT_0x8D
	CALL __CPD12
	BREQ _0x204016F
	CALL SUBOPT_0x88
	MOVW R0,R26
	CALL SUBOPT_0x87
	MOVW R26,R0
	CALL __CPD21
	BRSH _0x2040171
	CALL SUBOPT_0x85
	CALL SUBOPT_0x8B
	__GETD1S 11
	CALL SUBOPT_0x62
	BRNE _0x2040172
_0x2040171:
	RJMP _0x2040170
_0x2040172:
	CALL SUBOPT_0x8A
	LDI  R30,LOW(1)
	RJMP _0x20E0004
_0x2040170:
_0x204016F:
	CALL SUBOPT_0x41
	__PUTD1SNS 22,22
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x80
_0x2040160:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x81
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	SUB  R26,R30
	SBC  R27,R31
	MOVW R18,R26
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	CP   R30,R18
	CPC  R31,R19
	BRSH _0x2040173
	__GETWRS 18,19,18
_0x2040173:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL SUBOPT_0x81
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,32
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	CALL _memcpy
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x40
	ST   X,R30
_0x204015D:
	CALL SUBOPT_0x82
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	CALL SUBOPT_0x83
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	CALL SUBOPT_0x84
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	SUB  R30,R18
	SBC  R31,R19
	STD  Y+18,R30
	STD  Y+18+1,R31
	RJMP _0x204015E
_0x204015F:
	CALL SUBOPT_0x88
	MOVW R0,R26
	CALL SUBOPT_0x87
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x2040174
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,6
	CALL __GETD1P
	__PUTD1SNS 22,10
_0x2040174:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDI  R30,LOW(0)
_0x20E0004:
	CALL __LOADLOCR6
	ADIW R28,24
	RET
; .FEND
_f_sync:
; .FSTART _f_sync
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	CALL __SAVELOCR4
	CALL SUBOPT_0x49
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL SUBOPT_0x6E
	BREQ PC+2
	RJMP _0x2040175
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x20)
	BRNE PC+2
	RJMP _0x2040176
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x2040177
	CALL SUBOPT_0x49
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	CALL SUBOPT_0x7E
	BREQ _0x2040178
	LDI  R30,LOW(1)
	RJMP _0x20E0003
_0x2040178:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL SUBOPT_0x7F
_0x2040177:
	CALL SUBOPT_0x49
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	__GETD2Z 26
	CALL _move_window_G102
	MOV  R17,R30
	CPI  R17,0
	BREQ PC+2
	RJMP _0x2040179
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,30
	LD   R18,X+
	LD   R19,X
	MOVW R26,R18
	ADIW R26,11
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,10
	CALL __GETD1P
	__PUTD1RNS 18,28
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,14
	CALL __GETW1P
	__PUTW1RNS 18,26
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	__GETD2Z 14
	MOVW R30,R26
	MOVW R22,R24
	CALL __LSRD16
	__PUTW1RNS 18,20
	CALL _get_fattime
	CALL SUBOPT_0x52
	__PUTD1RNS 18,22
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xDF
	ST   X,R30
	CALL SUBOPT_0x49
	ADIW R30,4
	LDI  R26,LOW(1)
	STD  Z+0,R26
	CALL SUBOPT_0x49
	MOVW R26,R30
	CALL _sync_G102
	MOV  R17,R30
_0x2040179:
_0x2040176:
_0x2040175:
	MOV  R30,R17
_0x20E0003:
	CALL __LOADLOCR4
	ADIW R28,10
	RET
; .FEND
_f_lseek:
; .FSTART _f_lseek
	CALL __PUTPARD2
	SBIW R28,16
	ST   -Y,R17
	CALL SUBOPT_0x8E
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	CALL SUBOPT_0x6E
	BREQ _0x2040183
	RJMP _0x20E0002
_0x2040183:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x80)
	BREQ _0x2040184
	LDI  R30,LOW(2)
	RJMP _0x20E0001
_0x2040184:
	CALL SUBOPT_0x8F
	CALL SUBOPT_0x90
	CALL __CPD12
	BRSH _0x2040186
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BREQ _0x2040187
_0x2040186:
	RJMP _0x2040185
_0x2040187:
	CALL SUBOPT_0x8F
	CALL SUBOPT_0x91
_0x2040185:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL SUBOPT_0xC
	CALL SUBOPT_0x43
	CALL SUBOPT_0x34
	CALL SUBOPT_0x92
	ADIW R26,5
	LDI  R30,LOW(255)
	ST   X,R30
	CALL SUBOPT_0x90
	CALL __CPD02
	BRLO PC+2
	RJMP _0x2040188
	CALL SUBOPT_0x8E
	LDD  R30,Z+2
	LDI  R31,0
	CALL __CWD1
	__GETD2N 0x200
	CALL __MULD12U
	__PUTD1S 9
	CALL SUBOPT_0xE
	CALL __CPD02
	BRSH _0x204018A
	CALL SUBOPT_0x93
	CALL SUBOPT_0x94
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x94
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x204018B
_0x204018A:
	RJMP _0x2040189
_0x204018B:
	CALL SUBOPT_0x2E
	CALL SUBOPT_0x6B
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x95
	CALL SUBOPT_0x6B
	CALL __COMD1
	CALL __ANDD12
	CALL SUBOPT_0x92
	ADIW R26,6
	CALL __GETD1P
	CALL SUBOPT_0x90
	CALL __SUBD21
	__PUTD2S 17
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,18
	CALL SUBOPT_0x96
	RJMP _0x204018C
_0x2040189:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,14
	CALL SUBOPT_0x96
	CALL SUBOPT_0x97
	CALL __CPD10
	BRNE _0x204018D
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x89
	CALL SUBOPT_0x98
	CALL SUBOPT_0x99
	CALL SUBOPT_0x2F
	BRNE _0x204018E
	CALL SUBOPT_0x9A
	LDI  R30,LOW(2)
	RJMP _0x20E0001
_0x204018E:
	CALL SUBOPT_0x99
	CALL SUBOPT_0x30
	BRNE _0x204018F
	CALL SUBOPT_0x9A
	LDI  R30,LOW(1)
	RJMP _0x20E0001
_0x204018F:
	CALL SUBOPT_0x97
	__PUTD1SNS 21,14
_0x204018D:
	CALL SUBOPT_0x9B
_0x204018C:
	CALL SUBOPT_0x97
	CALL __CPD10
	BRNE PC+2
	RJMP _0x2040190
_0x2040191:
	CALL SUBOPT_0x95
	CALL SUBOPT_0x90
	CALL __CPD12
	BRLO PC+2
	RJMP _0x2040193
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x2)
	BREQ _0x2040194
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x9C
	CALL _create_chain_G102
	CALL SUBOPT_0x98
	CALL SUBOPT_0x97
	CALL __CPD10
	BRNE _0x2040195
	CALL SUBOPT_0x95
	CALL SUBOPT_0x91
	RJMP _0x2040193
_0x2040195:
	RJMP _0x2040196
_0x2040194:
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x9C
	CALL _get_fat
	CALL SUBOPT_0x98
_0x2040196:
	CALL SUBOPT_0x99
	CALL SUBOPT_0x30
	BRNE _0x2040197
	CALL SUBOPT_0x9A
	LDI  R30,LOW(1)
	RJMP _0x20E0001
_0x2040197:
	CALL SUBOPT_0x99
	CALL SUBOPT_0x19
	BRLO _0x2040199
	CALL SUBOPT_0x8E
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	CALL SUBOPT_0x99
	CALL __CPD21
	BRLO _0x2040198
_0x2040199:
	CALL SUBOPT_0x9A
	LDI  R30,LOW(2)
	RJMP _0x20E0001
_0x2040198:
	CALL SUBOPT_0x9B
	CALL SUBOPT_0x9D
	__GETD2S 9
	CALL __ADDD12
	MOVW R26,R0
	CALL __PUTDP1
	__GETD2S 9
	CALL SUBOPT_0x93
	CALL __SUBD12
	CALL SUBOPT_0x91
	RJMP _0x2040191
_0x2040193:
	CALL SUBOPT_0x9D
	CALL SUBOPT_0x90
	CALL __ADDD12
	MOVW R26,R0
	CALL __PUTDP1
	CALL SUBOPT_0x90
	__GETD1N 0x200
	CALL __DIVD21U
	__PUTB1SNS 21,5
	CALL SUBOPT_0x93
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	BREQ _0x204019B
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x9C
	CALL _clust2sect
	CALL SUBOPT_0x34
	CALL SUBOPT_0xD
	CALL __CPD10
	BRNE _0x204019C
	CALL SUBOPT_0x9A
	LDI  R30,LOW(2)
	RJMP _0x20E0001
_0x204019C:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R30,Z+5
	LDI  R31,0
	CALL SUBOPT_0x2C
	CALL SUBOPT_0x75
	CALL SUBOPT_0x34
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	CALL SUBOPT_0x80
_0x204019B:
_0x2040190:
_0x2040188:
	CALL SUBOPT_0x9E
	CALL SUBOPT_0x70
	BREQ _0x204019E
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,22
	CALL __GETD1P
	CALL SUBOPT_0x2C
	CALL __CPD12
	BRNE _0x204019F
_0x204019E:
	RJMP _0x204019D
_0x204019F:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	LDD  R26,Z+4
	ANDI R26,LOW(0x40)
	BREQ _0x20401A0
	CALL SUBOPT_0x8E
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0x86
	CALL SUBOPT_0x7E
	BREQ _0x20401A1
	CALL SUBOPT_0x9A
	LDI  R30,LOW(1)
	RJMP _0x20E0001
_0x20401A1:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	CALL SUBOPT_0x7F
_0x20401A0:
	CALL SUBOPT_0x8E
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	ADIW R30,32
	CALL SUBOPT_0x11
	BREQ _0x20401A2
	CALL SUBOPT_0x9A
	LDI  R30,LOW(1)
	RJMP _0x20E0001
_0x20401A2:
	CALL SUBOPT_0xD
	__PUTD1SNS 21,22
_0x204019D:
	CALL SUBOPT_0x9E
	MOVW R0,R26
	CALL SUBOPT_0x8F
	MOVW R26,R0
	CALL __CPD12
	BRSH _0x20401A3
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,6
	CALL __GETD1P
	__PUTD1SNS 21,10
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x20
	ST   X,R30
_0x20401A3:
_0x20E0002:
	MOV  R30,R17
_0x20E0001:
	LDD  R17,Y+0
	ADIW R28,23
	RET
; .FEND

	.CSEG
_itoa:
; .FSTART _itoa
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
; .FEND

	.DSEG

	.CSEG

	.CSEG
_memcmp:
; .FSTART _memcmp
	ST   -Y,R27
	ST   -Y,R26
    clr  r22
    clr  r23
    ld   r24,y+
    ld   r25,y+
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
memcmp0:
    adiw r24,0
    breq memcmp1
    sbiw r24,1
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    breq memcmp0
memcmp1:
    sub  r22,r23
    brcc memcmp2
    ldi  r30,-1
    ret
memcmp2:
    ldi  r30,0
    breq memcmp3
    inc  r30
memcmp3:
    ret
; .FEND
_memcpy:
; .FSTART _memcpy
	ST   -Y,R27
	ST   -Y,R26
    ldd  r25,y+1
    ld   r24,y
    adiw r24,0
    breq memcpy1
    ldd  r27,y+5
    ldd  r26,y+4
    ldd  r31,y+3
    ldd  r30,y+2
memcpy0:
    ld   r22,z+
    st   x+,r22
    sbiw r24,1
    brne memcpy0
memcpy1:
    ldd  r31,y+5
    ldd  r30,y+4
	ADIW R28,6
	RET
; .FEND
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
	ADIW R28,5
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG
_prtc_get_time:
	.BYTE 0x2
_prtc_get_date:
	.BYTE 0x2
_fat:
	.BYTE 0x232
_file:
	.BYTE 0x220
_path:
	.BYTE 0xD
_text1:
	.BYTE 0x34
_text2:
	.BYTE 0x19
__base_y_G100:
	.BYTE 0x4
_status_G101:
	.BYTE 0x1
_timer1_G101:
	.BYTE 0x1
_timer2_G101:
	.BYTE 0x1
_card_type_G101:
	.BYTE 0x1
_FatFs_G102:
	.BYTE 0x2
_Fsid_G102:
	.BYTE 0x2
_Drive_G102:
	.BYTE 0x1
__seed_G103:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(_file)
	LDI  R31,HIGH(_file)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_path)
	LDI  R31,HIGH(_path)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	MOV  R26,R5
	CLR  R27
	JMP  _error

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	STS  _text1,R30
	JMP  _write_to_file

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,11
	CALL _itoa
	MOVW R26,R28
	ADIW R26,9
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4:
	CALL _lcd_puts
	LDI  R26,LOW(400)
	LDI  R27,HIGH(400)
	CALL _delay_ms
	JMP  _lcd_clear

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5:
	MOVW R26,R16
	CALL __CWD2
	CALL _seek_in_file
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6:
	LDI  R30,LOW(_file)
	LDI  R31,HIGH(_file)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(6)
	LDI  R27,HIGH(6)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x8:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	LDI  R31,0
	CALL __CWD1
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	CALL __GETD1P
	__PUTD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0xD:
	__GETD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xE:
	__GETD2S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xF:
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	LDD  R26,Z+1
	ST   -Y,R26
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 4
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	JMP  _disk_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	__GETD2Z 34
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x11:
	ST   -Y,R31
	ST   -Y,R30
	__GETD1S 8
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x12:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2N 0x0
	JMP  _move_window_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x13:
	ADIW R26,46
	__GETD1N 0x0
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x14:
	ADIW R30,50
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	JMP  _memset

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	CALL __PUTDZ20
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,50
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x16:
	CALL __GETD1P
	MOVW R26,R0
	CALL __PUTDP1
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x17:
	__GETD2Z 18
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x18:
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:32 WORDS
SUBOPT_0x19:
	__CPD2N 0x2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	__GETD1N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1B:
	CALL __GETD1P
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1C:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R18
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	RCALL SUBOPT_0x8
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G102
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x1D:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	MOVW R30,R18
	ANDI R31,HIGH(0x1FF)
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1E:
	LDD  R30,Y+12
	LDD  R31,Y+12+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1F:
	__GETD1N 0x100
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x20:
	RCALL SUBOPT_0x8
	CALL __ADDD21
	CALL _move_window_G102
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x21:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	ADIW R26,50
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x22:
	CALL __GETW1P
	CLR  R22
	CLR  R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	__GETD1N 0x80
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x24:
	__GETD1N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x25:
	__GETD2S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x26:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R16
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	RCALL SUBOPT_0x18
	CLR  R22
	CLR  R23
	CALL __ADDD21
	CALL _move_window_G102
	MOV  R21,R30
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x27:
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,50
	MOVW R30,R16
	ANDI R31,HIGH(0x1FF)
	ADD  R30,R26
	ADC  R31,R27
	MOVW R18,R30
	LDD  R30,Y+14
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x28:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x29:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2A:
	RCALL SUBOPT_0x18
	CALL __ADDD21
	CALL _move_window_G102
	MOV  R21,R30
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2B:
	CALL __MULB1W2U
	ANDI R31,HIGH(0x1FF)
	LDD  R26,Y+18
	LDD  R27,Y+18+1
	ADIW R26,50
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2C:
	__GETD2S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x2D:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,30
	CALL __GETD1P
	RCALL SUBOPT_0x2C
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2E:
	__GETD1S 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x2F:
	__CPD2N 0x1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:47 WORDS
SUBOPT_0x30:
	__CPD2N 0xFFFFFFFF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x31:
	__GETD2N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	__GETD2Z 14
	RJMP SUBOPT_0x30

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x33:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADIW R26,14
	CALL __GETD1P_INC
	__SUBD1N -1
	CALL __PUTDP1_DEC
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x34:
	__PUTD1S 5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	CALL __PUTD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x36:
	__GETD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x37:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x38:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x39:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3A:
	LDD  R30,Y+20
	LDD  R31,Y+20+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3B:
	__GETD2S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3C:
	CALL _get_fat
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3D:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x3E:
	__GETD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3F:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x40:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x41:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x42:
	RCALL SUBOPT_0x3F
	RCALL SUBOPT_0x18
	CALL __CPD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x43:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x44:
	RCALL SUBOPT_0x3E
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x45:
	__GETD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x46:
	CALL __SWAPD12
	CALL __SUBD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x47:
	CALL __GETD1P
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x48:
	__GETD2S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x49:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4A:
	ADIW R30,30
	MOVW R26,R30
	CALL __GETD1P
	RCALL SUBOPT_0x48
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	__GETD1S 2
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4C:
	__GETD1S 2
	__PUTD1SNS 8,10
	RJMP SUBOPT_0x49

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4D:
	CLR  R22
	CLR  R23
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x4E:
	ANDI R30,LOW(0xF)
	ANDI R31,HIGH(0xF)
	LSL  R30
	CALL __LSLW4
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4F:
	CALL __GETD1P
	CALL __CPD10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x50:
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x51:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	__GETD2Z 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x52:
	RCALL SUBOPT_0x39
	RJMP SUBOPT_0x3F

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x53:
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x8
	JMP  _clust2sect

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x54:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _dir_seek_G102
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x55:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	__GETD2Z 14
	CALL _move_window_G102
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x56:
	ST   -Y,R19
	ST   -Y,R18
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+20
	LDD  R27,Z+21
	ST   -Y,R27
	ST   -Y,R26
	LDI  R26,LOW(11)
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x57:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x58:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	ADIW R30,1
	STD  Y+8,R30
	STD  Y+8+1,R31
	SBIW R30,1
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R16,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x59:
	MOV  R30,R18
	SUBI R18,-1
	LDI  R31,0
	ADD  R30,R20
	ADC  R31,R21
	ST   Z,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x5A:
	ADD  R30,R26
	ADC  R31,R27
	LDD  R26,Y+11
	LDD  R27,Y+11+1
	ST   X+,R30
	ST   X,R31
	CPI  R16,33
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5B:
	RCALL SUBOPT_0x43
	CALL __PUTDP1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5C:
	__PUTD1SNS 6,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5D:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5E:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5F:
	MOVW R26,R18
	ADIW R26,20
	RJMP SUBOPT_0x22

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x60:
	MOVW R26,R18
	ADIW R26,26
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x61:
	CLR  R22
	CLR  R23
	CALL __ORD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x62:
	CALL __PUTPARD1
	LDI  R26,LOW(1)
	CALL _disk_read
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x63:
	ADIW R30,50
	SUBI R30,LOW(-510)
	SBCI R31,HIGH(-510)
	MOVW R26,R30
	CALL __GETW1P
	CPI  R30,LOW(0xAA55)
	LDI  R26,HIGH(0xAA55)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x64:
	CALL __GETD1P
	__ANDD1N 0xFFFFFF
	__CPD1N 0x544146
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x65:
	LDI  R26,LOW(_FatFs_G102)
	LDI  R27,HIGH(_FatFs_G102)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x66:
	__PUTD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x67:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	SUBI R26,LOW(-64)
	SBCI R27,HIGH(-64)
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x68:
	__GETD2S 22
	RJMP SUBOPT_0x4D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x69:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Z+8
	LDD  R27,Z+9
	MOVW R30,R26
	CALL __LSRW4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6A:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	RCALL SUBOPT_0x10
	RCALL SUBOPT_0x45
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6B:
	__SUBD1N 1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6C:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6D:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+28
	LDD  R31,Y+28+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x6E:
	LDD  R26,Z+2
	LDD  R27,Z+3
	CALL _validate_G102
	MOV  R17,R30
	CPI  R17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6F:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x70:
	MOVW R30,R26
	MOVW R22,R24
	ANDI R31,HIGH(0x1FF)
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x71:
	__GETD2Z 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x72:
	LDD  R26,Y+26
	LDD  R27,Y+26+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x73:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x74:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	LDD  R30,Z+5
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x75:
	CALL __CWD1
	CALL __ADDD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x76:
	LDI  R30,LOW(512)
	LDI  R31,HIGH(512)
	CALL __DIVW21U
	MOVW R20,R30
	MOV  R0,R20
	OR   R0,R21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x77:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x78:
	LDD  R30,Y+26
	LDD  R31,Y+26+1
	__GETD2Z 22
	RJMP SUBOPT_0x3E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x79:
	CALL __SUBD21
	MOVW R30,R20
	CLR  R22
	CLR  R23
	CALL __CPD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7A:
	CALL __SUBD21
	__GETD1N 0x200
	CALL __MULD12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7B:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(512)
	LDI  R27,HIGH(512)
	JMP  _memcpy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7C:
	ADIW R26,5
	LD   R30,X
	ADD  R30,R20
	ST   X,R30
	MOVW R30,R20
	LSL  R30
	ROL  R31
	MOV  R31,R30
	LDI  R30,0
	MOVW R18,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x7D:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+27
	LDD  R31,Y+27+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x7E:
	__GETD2Z 22
	CALL __PUTPARD2
	LDI  R26,LOW(1)
	CALL _disk_write
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7F:
	ADIW R26,4
	LD   R30,X
	ANDI R30,0xBF
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x80:
	ADIW R26,5
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x81:
	ADIW R26,6
	CALL __GETW1P
	ANDI R31,HIGH(0x1FF)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x82:
	MOVW R30,R18
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x83:
	ADIW R30,6
	MOVW R0,R30
	MOVW R26,R30
	CALL __GETD1P
	MOVW R26,R30
	MOVW R24,R22
	MOVW R30,R18
	RJMP SUBOPT_0x4D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x84:
	LD   R30,X+
	LD   R31,X+
	ADD  R30,R18
	ADC  R31,R19
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x85:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x86:
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+24
	LDD  R31,Y+24+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x87:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,10
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x88:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x89:
	ST   -Y,R31
	ST   -Y,R30
	RCALL SUBOPT_0x31
	JMP  _create_chain_G102

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x8A:
	LDD  R26,Y+22
	LDD  R27,Y+22+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8B:
	LDD  R30,Z+1
	ST   -Y,R30
	LDD  R30,Y+23
	LDD  R31,Y+23+1
	ADIW R30,32
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8C:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	LDD  R30,Z+5
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8D:
	LDD  R30,Y+22
	LDD  R31,Y+22+1
	__GETD2Z 22
	RJMP SUBOPT_0x41

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x8E:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8F:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,10
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x90:
	__GETD2S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x91:
	__PUTD1S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x92:
	__PUTD1SNS 21,6
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x93:
	__GETD1S 17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x94:
	RCALL SUBOPT_0x6B
	MOVW R26,R30
	MOVW R24,R22
	__GETD1S 9
	CALL __DIVD21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x95:
	__GETD1S 9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x96:
	CALL __GETD1P
	__PUTD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x97:
	__GETD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x98:
	__PUTD1S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x99:
	__GETD2S 13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x9A:
	LDD  R26,Y+21
	LDD  R27,Y+21+1
	ADIW R26,4
	LD   R30,X
	ORI  R30,0x80
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x9B:
	RCALL SUBOPT_0x97
	__PUTD1SNS 21,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x9C:
	ST   -Y,R31
	ST   -Y,R30
	__GETD2S 15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9D:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	ADIW R30,6
	MOVW R0,R30
	MOVW R26,R30
	CALL __GETD1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9E:
	LDD  R30,Y+21
	LDD  R31,Y+21+1
	__GETD2Z 6
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__ADDD21:
	ADD  R26,R30
	ADC  R27,R31
	ADC  R24,R22
	ADC  R25,R23
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__SUBD21:
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R25,R23
	RET

__ANDD12:
	AND  R30,R26
	AND  R31,R27
	AND  R22,R24
	AND  R23,R25
	RET

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__LSRW4:
	LSR  R31
	ROR  R30
__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__LSLD1:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	RET

__LSRD16:
	MOV  R30,R22
	MOV  R31,R23
	LDI  R22,0
	LDI  R23,0
	RET

__LSLD16:
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	RET

__COMD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULB1W2U:
	MOV  R22,R30
	MUL  R22,R26
	MOVW R30,R0
	MUL  R22,R27
	ADD  R31,R0
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__GETD1P_INC:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X+
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__PUTDP1_DEC:
	ST   -X,R23
	ST   -X,R22
	ST   -X,R31
	ST   -X,R30
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTDZ20:
	ST   Z,R26
	STD  Z+1,R27
	STD  Z+2,R24
	STD  Z+3,R25
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
