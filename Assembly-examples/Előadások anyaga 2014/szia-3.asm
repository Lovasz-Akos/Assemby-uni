code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h


start:
        mov     ax,3                    ; M�dv�lt�s k�dja k�perny�t�rl�shez
        int     10h                     ; 80x25-�s sz�nes �zemm�dra VGA BIOS
        mov     dx,offset hogyhi        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; DOS h�v�s ki�rat�sra
        mov     cx,10                   ; Ennyi karakterb�l �ll
        mov     bx,offset abizne        ; A t�rol� c�me
ciklus:
        mov     ah,1                    ; Visszahangos le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        mov     [bx],al                 ; Kitettem a karaktert
        cmp     al,13                   ; �ppen az enter?
        jz      ellen0                  ; Ellen�rz�m, hogy volt-e le�t�s
        inc     bx                      ; L�pek a k�vetkez�re
        loop    ciklus                  ; Vissza a k�vetkez� le�t�sv�r�sra
rendbe:
        mov     dx,offset sziasz        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; DOS h�v�s ki�rat�sra
        mov     cx,10                   ; Ennyi karakterb�l �ll
        mov     bx,offset abizne        ; A t�rol� c�me
        mov     ah,2                    ; Karakterki�rat�s k�dja
kiirat:
        mov     dl,[bx]                 ; Kitettem a karaktert
        cmp     dl,13                   ; �ppen az enter?
        jz      befaki                  ; Igen, akkor nincs tov�bb
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        inc     bx                      ; L�pek a k�vetkez�re
        loop    kiirat                  ; Vissza a k�vetkez� ki�rat�sra
befaki:
        mov     dl,'!'                  ; Karakter a v�g�re
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
kilep:
        mov     ah,4ch
        int     21h
ellen0:
        cmp     cx,10                   ; Volt egy�ltal�n le�t�s?
        jnz     rendbe                  ; Igen, akkor folytatom
        mov     dx,offset hibasz        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; DOS h�v�s ki�rat�sra
        jmp     kilep                   ; Itt be is fejezem

hogyhi  db      'Hogy h�vnak? $'
                 
hibasz  db      'Az�'' csak tudod, hogy hogy h�vnak!$'

sziasz  db      13,10,'Szia, $'

abizne  db      10 dup(?)

code	ends
	end	start

