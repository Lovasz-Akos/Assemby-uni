code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h


start:
        mov     ax,3                    ; M�dv�lt�s k�dja k�perny�t�rl�shez
        int     10h                     ; 80x25-�s sz�nes �zemm�dra VGA BIOS
        mov     dx,offset hogyhi        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; DOS h�v�s ki�rat�sra
        mov     cx,5                    ; Ennyi karakterb�l �ll
        mov     bx,offset abizne        ; A t�rol� c�me
ciklus:
        mov     ah,1                    ; Visszahangos le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        mov     [bx],al                 ; Kitettem a karakter
        inc     bx                      ; L�pek a k�vetkez�re
        loop    ciklus                  ; Vissza a k�vetkez� le�t�sv�r�sra

        mov     dx,offset sziasz        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; DOS h�v�s ki�rat�sra

        mov     ah,4ch
        int     21h               

hogyhi  db      'Hogy h�vnak? $'

sziasz  db      13,10,'Szia, '

abizne  db      5 dup(?)

        db      '!$'

code	ends
	end	start

