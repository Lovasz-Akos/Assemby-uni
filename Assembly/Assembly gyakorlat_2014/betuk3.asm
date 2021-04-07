code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚s v‚gett k¢d
        int     10h                     ; Video Bios h¡v sa
        mov     dx,offset szoveg        ; A ki¡ratand¢ sz”veg c¡me
        mov     ah,9                    ; A string ki¡rat s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     cx,10                   ; Ennyi let‚s maximum
ciklus:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r sra
        cmp     al,'Q'                  ; ppen a 'Q' a let‚s?
        jz      kilep                   ; Igen, akkor kil‚pek a programb¢l
        cmp     al,'q'                  ; ppen a 'q' a let‚s?
        jz      kilep                   ; Igen, akkor kil‚pek a programb¢l
        cmp     al,27                   ; ppen az ESC a let‚s?
        jz      kilep                   ; Igen, akkor kil‚pek a programb¢l
        mov     dl,al                   ; Innen ¡ratom ki a let”tt karaktert
        mov     ah,2                    ; A karakter ki¡rat s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        int     21h                     ; A DOS h¡v sa m sodik ki¡rat sra
        loop    ciklus                  ; K”vetkez‹ ciklusr‚szre
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'šss”n le maximum 10 billentyût, ESC, Q, q - v‚ge.', 13, 10,'$'

code	ends
	end	start


