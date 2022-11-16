RS 		EQU 	P1.0
RW 		EQU 	P1.1
E  		EQU 	P1.2
DBUS 	EQU 	P1
CONT 	EQU 	R0


ORG 0100H
	
PRINCIPAL: 		ACALL INIT  ;Inicializa LCD


INIT: 			MOV 	A, #38H ; 2 lineas, matriz de 5x7
				ACALL   ESPERA  ; Espera a que el LCD este libre
				CLR 	RS		; Prepara comando para salida
				ACALL 	SALIDA 	; Envia comando para salida
				
				MOV 	A, #0EH ; LCD encendido, cursor encendido
				ACALL 	ESPERA  ; espera que LCD este libre
				CLR 	RS		; Prepara comando para salida
				ACALL	SALIDA 	; Envia el comando

ESPERA:			CLR		RS		; Mandar comando
				SETB	RW		; Configurar LCD en modo lectura
				SETB 	DBUS.7	; DB7 = ENTRADA
				SETB 	E		; Transición de 1 a 0 para habilitar LCD
				JB		DBUS.7, ESPERA
				RET


WRITE_TO_DP:	ACALL 	ESPERA  ; Espera a que el LCD este libre
                SETB 	RS		; Prepara comando para salida
                ACALL 	SALIDA 	; Envia comando para salida
                RET
                
CURSOR_RIGHT:   MOV 	A, #14H ; Mueve cursor a la derecha
                ACALL 	ESPERA  ; Espera a que el LCD este libre
                CLR 	RS		; Prepara comando para salida
                ACALL 	SALIDA 	; Envia el comando
                RET

; Funcion para colocar el cursor en la segunda linea
JMP_LINE:		MOV 	A, #C0H ; Comando para colocar cursor en segunda linea
                ACALL 	ESPERA  ; Espera a que el LCD este libre
                CLR 	RS		; Prepara comando para salida
                ACALL 	SALIDA 	; Envia comando para salida
                RET

; Funcion para limpia la pantalla LCD y coloca el cursor en la primera linea
CLEAR_CURSOR:	MOV 	A, #01H ; Comando para limpiar pantalla
                ACALL 	ESPERA  ; Espera a que el LCD este libre
                CLR 	RS		; Prepara comando para salida
                ACALL 	SALIDA 	; Envia comando para salida
                MOV 	A, #02H ; Comando para colocar cursor en primera linea
                ACALL 	ESPERA  ; Espera a que el LCD este libre
                CLR 	RS		; Prepara comando para salida
                ACALL 	SALIDA 	; Envia comando para salida
                RET

SALIDA: 		MOV 	DBUS, A
				CLR		RW
				SETB	E
				CLR		E
				RET
END