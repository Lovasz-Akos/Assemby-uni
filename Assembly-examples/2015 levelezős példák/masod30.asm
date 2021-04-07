code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; Video Bios h�v�sa t�rl�shez
        mov     bx,1                    ; Ennyivel kezd�nk
ujsoki:
        mov     si,offset asstxt        ; Itt kezd�nk
        mov     cx,bx                   ; �tteszem a ciklussz�mot
        mov     ah,2                    ; Egy karakter ki�rat�s k�dja
kakici:
        mov     dl,[si]                 ; Ez a karakter a ki�ratand�
        inc     si                      ; L�pek a k�vetkez�re
        int     21h                     ; Ki�rom DOS-sal
        loop    kakici                  ; Ciklusban
        mov     dl,13                   ; CR karakter
        int     21h                     ; Ki�rom DOS-sal
        mov     dl,10                   ; LF karakter
        int     21h                     ; Ki�rom DOS-sal
        inc     bx                      ; K�vetkez� mennyis�g
        cmp     bx,betnum               ; Van m�g h�tra?
        jbe     ujsoki                  ; Mehet ki �jra

        mov     ah,4ch
        int     21h

asstxt  db      'Assembly'
betnum  equ     $-asstxt


code	ends
	end	start

