code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; M�dv�lt�s a VIDEO BIOS seg�ts�g�vel
        mov     dx,offset mitcsi        ; Sz�vegc�m
        mov     ah,9                    ; String ki�rat�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
        mov     cx,10                   ; Ennyi a ciklussz�m
ciklus:
        mov     ah,8                    ; N�ma le�t�svr�s k�dja
        int     21h                     ; DOS-sal beolvas�s
        cmp     al,27                   ; Az ESC az?
        jz      kilep                   ; Igen, akkor abba-fejezem
        cmp     al,'Q'                  ; A 'Q' az?
        jz      kilep                   ; Igen, akkor abba-fejezem
        cmp     al,'q'                  ; A 'q' az?
        jz      kilep                   ; Igen, akkor abba-fejezem
        cmp     al,'9'                  ; Enn�l nagyobb?
        ja      ciklus                  ; Igen, akkor nem �rok ki semmit
        mov     dl,al                   ; Karakter a ki�rat�s hely�re
        mov     ah,2                    ; Karakter ki�rat�s k�dja
        int     21h                     ; Ki�rat�s a DOS-al
        loop    ciklus                  ; Vissza ciklusban
kilep:
	mov	ah,4ch
	int	21h

mitcsi  db      '�ss sz�mokat �s bet�ket. ESC, Q vagy q eset�n kil�p.', 13, 10, '$'

code	ends
	end	start

