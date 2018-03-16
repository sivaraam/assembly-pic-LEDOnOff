#include "p16f873a.inc"

; CONFIG
; __config 0xFF39
__CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

START
    bsf 0x03, 5                      ; switch to bank 1 by setting RP0 of STATUS in bank 0
    bcf 0x86, 5                      ; configure pin 5 for output by clearing 5th bit of TRISB
    bsf 0x86, 4                      ; configure pin 4 for input by setting 4th bit of TRISB
    bcf 0x83, 5                      ; switch back to bank 0 by clearing RP0 of STATUS in bank 1
    
LOOP
    btfsc 0x06, 4                    ; glow LED only if there is input
    bsf 0x06, 5
    btfss 0x06, 4
    bcf 0x06, 5
    goto LOOP
    
    END