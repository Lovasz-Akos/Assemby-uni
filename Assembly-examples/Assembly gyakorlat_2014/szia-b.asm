code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s k�dja
        int     10h                     ; Video BIOS h�v�sa a t�rl�shez
        mov     dx,offset mianev        ; Sz�vegc�m
        mov     ah,9                    ; String ki�r�s k�dja
        int     21h                     ; DOS h�v�sa ki�r�sra
;
; Beolvasok nevet 5 karakterben
;
        mov     cx,5                    ; Ennyi karakterb�l �ll a n�v
        mov     bx,offset holnev        ; A t�rol� kezd�c�m�t be�ll�tom
        mov     ah,1                    ; Visszhangos le�t�sv�r�s k�dja
nevbek:
        int     21h                     ; DOS h�v�s viszhangos le�t�sv�r�sra
        mov     [bx],al                 ; Kitettem a le�t�tt karaktert
        inc     bx                      ; K�vetkez� karakter c�m�re
        loop    nevbek                  ; A nevet bek�r� ciklus
;
; N�vbeolvas�s k�sz, kezdem a sz�veget
;
        mov     dx,offset sziast        ; Sz�vegc�m
        mov     ah,9                    ; String ki�r�s k�dja
        int     21h                     ; DOS h�v�sa ki�r�sra
	mov	ah,4ch
	int	21h

mianev  db      'Hogy h�vnak? $'

sziast  db      13, 10,'Szia '
holnev  db      5 dup(?)
        db      '!', 13, 10, '$'

code	ends
	end	start

