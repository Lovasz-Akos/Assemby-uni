code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚s v‚gett k¢d
        int     10h                     ; Video Bios h¡v sa k‚perny”t”rl‚shez
        mov     bx,offset szoveg        ; A kezd‹ karakter c¡me
        mov     cx,kardar               ; Ennyi karakterb‹l  ll a sz”veg
ciklus:
        mov     ah,9                    ; String ki¡rat s k¢dja
        mov     dx,offset csomos        ; A sok sz¢k”z c¡me
        int     21h                     ; String ki¡rat s k¢dja
        mov     ah,2                    ; Karakter ki¡rat si k‚r‚s k¢dja
        mov     dl,[bx]                 ; Ezt a karaktert ¡rja ki
        inc     bx                      ; L‚pek a k”vetkez‹re
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        mov     dl,13                   ; CR karakter k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        mov     dl,10                   ; LF karakter k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        loop    ciklus                  ; Ciklusban t”bbsz”r csin lom
	mov	ah,4ch
	int	21h

szoveg  db      'Assembly'
kardar  equ     $ - szoveg
csomos  db      '                                            $'


code	ends
	end	start


