code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; VIDEO BIOS h�v�sa, m�dv�lt�shoz
;
; A ciklust ki�rat�ssal kezdem
;
tokici:
        mov     dx,offset amitki        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�rat�s k�dja
        int     21h                     ; Megy ki a sz�veg DOS-sal
;
; A m�sodik sz�mjegyet manipul�lom
;
        mov     bx,offset amitki + 1    ; Sz�vegc�m a m�sodik jegyhez
        dec     byte ptr [bx]           ; Egyel cs�kkentem
;
; Figyelek, hogy a '0' karaktern�l nem lehet kisebb
;
        cmp     byte ptr [bx],'0'       ; Ennel kisebb lett?
        jae     marhat                  ; Nem, akkor maradhatok
;
; Most m�r a '9' kell, de cs�kkenteni kell az els� jegyet is!
;
        mov     byte ptr [bx],'9'       ; �gy most 9 lett bel�le
        dec     bx                      ; �l�pek az els� jegyre
        dec     byte ptr [bx]           ; Egyel cs�kkentem
marhat:
        mov     bx,offset amitki        ; Sz�vegc�m a sz�mokhoz
        cmp     [bx],'00'               ; El�rte?
        jz      kilep                   ; Igen, akkorm befejezem
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; V�rok le�t�sre DOS-sal
        cmp     al,27                   ; ESC j�tt?
        jnz     tokici                  ; Nem akkor j�n a tov�bbi ki�rat�s
kilep:
	mov	ah,4ch
	int	21h

amitki  db      '99',13,10,'$'

code	ends
	end	start

