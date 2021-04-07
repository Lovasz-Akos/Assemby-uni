code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
        mov     ax,3                    ; K�perny�t�rl�s m�dbe�ll�t�ssal k�d
        int     10h                     ; Video BIOS h�v�sa a t�rl�shez
        mov     ah,9                    ; String ki�rat�s k�dja
        mov     dx,offset teendo        ; A sz�veg c�me
        int     21h                     ; DOS-sal ki�ratom a stringet
        mov     bx,1                    ; Ennyivel kezdek
karcik:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; A DOS h�v�sa le�t�sv�r�sra
        cmp     al,27                   ; Az ESC volt az?
        jz      kilep                   ; Igen, akkor befejeztem
        mov     dl,al                   ; Ezt a karaktert kell ki�rni
        mov     ah,2                    ; Karakter ki�rat�s k�dja
        mov     cx,bx                   ; Ennyiszer kell ki�ratni
kaciki:
        int     21h                     ; Ciklusban h�vogatom a DOS-t
        loop    kaciki                  ; Ki�rat� ciklus

        inc     bx                      ; Egyel t�bbsz�r kell m�r ezut�n
        jmp     karcik                  ; Vissza a le�t�sv�r�sra
kilep:
	mov	ah,4ch
	int	21h

teendo  db      '�ss�l le billenty�ket. Kil�p�s ESC-re.', 13, 10, '$'

code	ends
	end	start

