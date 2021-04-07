code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚s v‚gett k¢d
        int     10h                     ; Video Bios h¡v sa k‚perny”t”rl‚shez
        mov     bx,offset szoveg        ; A kezd‹ karakter c¡me
        mov     cx,kardar               ; Ennyi karakterb‹l  ll a sz”veg
ciklus:
        mov     ah,2                    ; Karakter ki¡rat si k‚r‚s k¢dja
        mov     di,12                   ; Ennyivel beljebb
        mov     dl,' '                  ; Ezzel megyek beljebb
spacik:
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        dec     di                      ; Cs”kkentem a sz ml l¢t
        jnz     spacik                  ; M‚g kell ki¡rni
        mov     dl,[bx]                 ; Ezt a karaktert ¡rja ki
        inc     bx                      ; L‚pek a k”vetkez‹re
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        mov     dx,offset crlf          ; A CR ‚s LF karakter stringben c¡me
        mov     ah,9                    ; String ki¡rat s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        loop    ciklus                  ; Ciklusban t”bbsz”r csin lom
	mov	ah,4ch
	int	21h

crlf    db      13,10,'$'
szoveg  db      'Assembly-pr¢ba'
kardar  equ     $ - szoveg

code	ends
	end	start


