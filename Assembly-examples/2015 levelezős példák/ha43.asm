code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

darabs  db      ?
        db      ?
parsor  db      126 dup(?)

	org	100h

     
start:
        mov     ax,3                    ; T�rl�shez k�d
        int     10h                     ; VIDEO BIOS-sal t�rl�s
        mov     ax,1                    ; Eg�r l�that�s�g k�dja
        int     33h                     ; Eg�rdriver h�v�sa
        mov     bp,0ffffh               ; Ilyen biztos nincs
egerci:
        mov     ax,3                    ; Eg�rparam�terek lek�rdez�se
        int     33h                     ; Eg�rdriver h�v�sa
        cmp     bx,bp                   ; Volt v�ltoz�s?
        jz      omireg                  ; Nem, nincs ki�r�s
        mov     bp,bx                   ; Elt�rolom az aktu�lis �llapotot
        mov     dx,offset egysem        ; Sz�vegc�m
        or      bx,bx                   ; Nulla a BX?
        jz      megtal                  ; Igen, nincs lenyomva
        mov     dx,offset balgom        ; Sz�vegc�m
        dec     bx                      ; Egy volt a BX?
        jz      megtal                  ; Igen, bal gomb lenyomva
        mov     dx,offset jobgom        ; Sz�vegc�m
        dec     bx                      ; Kett� volt a BX?
        jz      megtal                  ; Igen, jobb gomb lenyomva
        mov     dx,offset mindke        ; Sz�vegc�m
megtal:
        mov     ax,2                    ; Eg�r l�that�s�g megsz�ntet�s k�dja
        int     33h                     ; Eg�rdriver h�v�sa
        mov     ah,9                    ; String ki�rat�s k�dja
        int     21h                     ; Ki�rat�s DOS-sal
        mov     ax,1                    ; Eg�r l�that�s�g k�dja
        int     33h                     ; Eg�rdriver h�v�sa
omireg:
        mov     ah,1                    ; Le�t�svizsg�lat
        int     16h                     ; A klavi a ROM-BIOS-ban
        jz      egerci                  ; Nem volt le�t�s
        mov     ah,0                    ; Le�t�sv�r�s k�dja
        int     16h                     ; A klavi a ROM-BIOS-ban
        cmp     al,27                   ; ESC volt?
        jnz     egerci                  ; Nem ESC volt, vissza
        mov     ax,2                    ; Eg�r l�that�s�g megsz�ntet�s k�dja
        int     33h                     ; Eg�rdriver h�v�sa
        mov     ah,4ch
        int     21h

egysem  db      'Egyik sem',13,'$'
balgom  db      'Bal gomb ',13,'$'
jobgom  db      'Jobb gomb',13,'$'
mindke  db      'Mindkett�',13,'$'

code	ends
	end	start

