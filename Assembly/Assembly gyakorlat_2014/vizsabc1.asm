code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s k�dja
        int     10h                     ; Video BIOS h�v�sa a t�rl�shez
        mov     dx,offset szoveg        ; Sz�vegc�m
        mov     ah,9                    ; String ki�r�s k�dja
        int     21h                     ; DOS h�v�sa ki�r�sra
        xor     bx,bx                   ; Nincs m�g semmilyen
ciklus:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        mov     ah,2                    ; Karakter ki�rat�s k�dja
        cmp     al,27                   ; �ppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; �tteszem a ki�ratand�t
        int     21h                     ; DOS h�v�sa ki�r�sra
        or      bx,bx                   ; Nem volt m�g 'a' le�t�s?
        jnz     voltma                  ; Volt m�r legal�bb az 'a'
atvizs:
        cmp     al,'a'                  ; �ppen az 'a'?
        jnz     ciklus                  ; Nem az, akkor marad
        inc     bx                      ; BX <- 1
        jmp     ciklus                  ; Mehet tov�bb
;
; BX nem nulla, azaz volt m�r 'a' vagy 'ab'
;
voltma:
        cmp     bx,1                    ; Volt m�r 'b' is?
        jnz     voltmb                  ; Igen, volt m�r az 'ab'
        cmp     al,'b'                  ; �ppen a 'b'?
        jnz     ujaviz                  ; Nem az, akkor kezdje az 'a'-n�l
        inc     bx                      ; BX <- 2
        jmp     ciklus                  ; Mehet tov�bb
;
; BX nem nulla, nem egy, azaz volt m�r 'ab'
;
voltmb:
        cmp     al,'c'                  ; �ppen a 'c'?
        jz      abbaha                  ; Igen, akkor be is fejezem
;
; Nem a 'b' vagy nem a 'c' lett le��tve, 'a'-t kell el�k�sz�teni
;
ujaviz:
        xor     bx,bx                   ; M�g nem volt semmi
        jmp     atvizs                  ; Az 'a'-t fogom megvizsg�lni
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

