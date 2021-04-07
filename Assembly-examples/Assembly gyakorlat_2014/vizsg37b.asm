code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; VIDEO BIOS h�v�sa, m�dv�lt�shoz
        mov     bx,'99'                 ; Ezzel kezdek
;
; A ciklust ki�rat�ssal kezdem
;
tokici:
        mov     ah,2                    ; Karakterki�rat�s k�dja
        mov     dl,bh                   ; Az 1. karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,bl                   ; A 2. karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,13                   ; A CR karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,10                   ; Az LF karakter
        int     21h                     ; Megy ki a karakter DOS-sal
;
; A m�sodik sz�mjegyet manipul�lom
;
        dec     bl                      ; Egyel cs�kkentem
;
; Figyelek, hogy a '0' karaktern�l nem lehet kisebb
;
        cmp     bl,'0'                  ; Ennel kisebb lett?
        jae     marhat                  ; Nem, akkor maradhatok
;
; Most m�r a '9' kell, de cs�kkenteni kell az els� jegyet is!
;
        mov     bl,'9'                  ; �gy most 9 lett bel�le
        dec     bh                      ; Egyel cs�kkentem
marhat:
        cmp     bx,'00'                 ; El�rte?
        jz      kilep                   ; Igen, akkorm befejezem
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; V�rok le�t�sre DOS-sal
        cmp     al,27                   ; ESC j�tt?
        jnz     tokici                  ; Nem akkor j�n a tov�bbi ki�rat�s
kilep:
	mov	ah,4ch
	int	21h

code	ends
	end	start

