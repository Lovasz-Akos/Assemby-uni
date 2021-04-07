code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s k�dja
        int     10h                     ; Video BIOS h�v�sa a t�rl�shez
        mov     dx,offset szoveg        ; Sz�vegc�m
        mov     ah,9                    ; String ki�r�s k�dja
        int     21h                     ; DOS h�v�sa ki�r�sra
ciklus:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        mov     ah,2                    ; Karakter ki�r�s k�dja
        cmp     al,27                   ; �ppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Innen kell ki�ratnom
        int     21h                     ; DOS h�v�sa ki�r�sra
vizsga:
        cmp     dl,'a'                  ; �ppen az 'a' volt?
        jnz     ciklus                  ; Nem az volt, kezdem az elej�n
;
; Az 'a' m�r le volt �tve, v�rok 'b'-t
;
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        mov     ah,2                    ; Karakter ki�r�s k�dja
        cmp     al,27                   ; �ppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Innen kell ki�ratnom
        int     21h                     ; DOS h�v�sa ki�r�sra
        cmp     dl,'b'                  ; �ppen a 'b' volt?
        jnz     vizsga                  ; Nem az volt, kezdem az '-'-val
;
; Az 'a' �s a 'b' m�r le volt �tve, v�rok 'c'-t
;
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        mov     ah,2                    ; Karakter ki�r�s k�dja
        cmp     al,27                   ; �ppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Innen kell ki�ratnom
        int     21h                     ; DOS h�v�sa ki�r�sra
        cmp     dl,'c'                  ; �ppen a 'c' volt?
        jnz     vizsga                  ; Nem az volt, kezdem az '-'-val
;
; A v�g�re CR �s LF kit�tele, hogy eleg�nsabban n�zzen ki. AH m�g mindig 2!
;
abbaha:
        mov     dl,13                   ; A v�g�re CR (hogy szebb legyen)
        int     21h                     ; DOS h�v�sa ki�r�sra
        mov     dl,10                   ; A v�g�re LF (hogy szebb legyen)
        int     21h                     ; DOS h�v�sa ki�r�sra
	mov	ah,4ch
	int	21h

szoveg  db      'a, b, c-re vagy  ESC-re v�ge!',13,10,'$'

code	ends
	end	start

