code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚s v‚gett k¢d
        int     10h                     ; Video Bios h¡v sa k‚perny”t”rl‚shez
        mov     bx,offset szoveg        ; A kezd‹ karakter c¡me
        mov     cx,kardar               ; Ennyi karakterb‹l  ll a sz”veg
        mov     ah,2                    ; Karakter ki¡rat si k‚r‚s k¢dja
ciklus:

        push    cx
        mov     cx,30                   ; Ennyi sz¢k”z
        mov     dl,' '                  ; A sz¢k”z
sokspa:
        int     21h                     ; Karakter ki¡rat s k‚r‚s
        loop    sokspa                  ; Ciklusban kiteszem a sz¢k”z”ket
        pop     cx

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

code	ends
	end	start


