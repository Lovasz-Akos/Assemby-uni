code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80x25-”s m¢dbe ll¡t s-k‚r‚s k¢dja
        int     10h                     ; Vide¢-kezel‹ megszak¡t s h¡v s
;
; Nem v‚letlen, hanem a be ll¡tott ‚rt‚ke kerl ki¡r sra
;
        mov     bx,1234h                ; Ezt az ‚rt‚ket ¡rassuk ki
;
; Be ll¡tom a ciklussz mnak megfelel‹en a CX regisztert
;
        mov     cx,16                   ; Ez a ciklussz m
;
; Mivel nem v ltozik a ciklusban, el‚g cikluson k¡vl be ll¡tani
;
        mov     ah,2                    ; A karakterki¡r s k¢dja
bincik:
        xor     dl,dl                   ; DL-be null t tesznk
        rcl     bx,1                    ; A legfels‹ bit CY flag-be kerl
        adc     dl,'0'                  ; DL-be '0', vagy '1' CY-t¢l fgg‹en
        int     21h                     ; A DOS megh¡v sa a karakterrel
        loop    bincik                  ; A k”vetkez‹ karakter ki¡r sa 
;
; Kil‚pnk a programunkb¢l
;
        mov     ax,4c00h                ; A kil‚p‚sk‚r‚s k¢dja sikeresen
        int     21h                     ; A DOS h¡v sa kil‚p‚sre,
                                        ; Innen m r nem t‚rnk vissza!!!!


code	ends
	end	start

