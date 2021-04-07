code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s k�dja
        int     10h                     ; Video BIOS h�v�sa a t�rl�shez
        mov     dx,offset szoveg        ; Sz�vegc�m
        mov     ah,9                    ; String ki�r�s k�dja
        int     21h                     ; DOS h�v�sa ki�r�sra
        mov     cx,10                   ; Ennyit v�rok maximum
ciklus:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        cmp     al,27                   ; �ppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        cmp     al,'Q'                  ; �ppen a 'Q' karakter az?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        cmp     al,'q'                  ; �ppen a 'q' karakter az?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Ez volt a le�t�tt karakter
        inc     dl                      ; Mivel a k�vetkez�t kell ki�rni
        mov     ah,2                    ; A karakter ki�rat�s k�dja
        int     21h                     ; A DOS h�v�sa karakter ki�rat�sra
        loop    ciklus                  ; Le�t�sv�r�si ciklus
abbaha:
	mov	ah,4ch
	int	21h

szoveg  db      '�sss�l le billenty�ket, ESC, Q, q kil�p�s.',13,10,'$'

code	ends
	end	start

