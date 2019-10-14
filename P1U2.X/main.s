#include <xc.inc>

; When assembly code is placed in a psect, it can be manipulated as a
; whole by the linker and placed in memory.  
;
; In this example, barfunc is the program section (psect) name, 'local' means
; that the section will not be combined with other sections even if they have
; the same name.  class=CODE means the barfunc must go in the CODE container.
; PIC18's should have a delta (addressible unit size) of 1 (default) since they
; are byte addressible.  PIC10/12/16's have a delta of 2 since they are word
; addressible.  PIC18's should have a reloc (alignment) flag of 2 for any
; psect which contains executable code.  PIC10/12/16's can use the default
; reloc value of 1.  Use one of the psects below for the device you use:

psect   barfunc,local,class=CODE,delta=2 ; PIC10/12/16
; psect   barfunc,local,class=CODE,reloc=2 ; PIC18

global _bar ; extern of bar function goes in the C source file
_bar:
    movf PORTA,w    ; here we use a symbol defined via xc.inc
    return
LIST		p=16F887		; Tipo de microcontrolador
INCLUDE 	P16F887.INC		; Define los SFRs y bits P16F887

__CONFIG _CONFIG1, _CP_OFF&_WDT_OFF&_XT_OSC	
						; Ingresa parámetros de configuración
errorlevel	 -302			
			
; INICIO DEL PROGRAMA 

	ORG 	0x00			; Comienzo del programa (Vector de Reset)
	
; SETEO DE PUERTOS
	BANKSEL 	TRISA		; selecciona el banco conteniendo TRISA
	CLRF		TRISA		; puerto A configurado como salida
	BANKSEL	        ANSEL
	CLRF		ANSEL	              ; configura puertos con entradas digitales
	CLRF		ANSELH	              ; configura puertos con entradas digitales
	BANKSEL 	PORTA	              ; selecciona el puerto A como salida
	CLRF		PORTA
	
	
; DESARROLLO DEL PROGRAMA
;1
VALOR
	MOVLW	B'00111111' 		; mueve 0xAA al registro W
	MOVWF	PORTA			; pasa el valor al puerto A
	GOTO		VALOR


    END

    
