

code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; M�dv�lt�s k�dja k�perny�t�rl�shez
        int     10h                     ; VIDEO BIOS h�v�sa t�rl�shez
        mov     bh,'1'                  ; Kezd��rt�k
szacik:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS-sal le�t�sv�r�s
        cmp     al,27                   ; ESC volt?
        jz      befeje                  ; Igen, akkor v�ge
        cmp     al,'Q'                  ; 'Q' volt?
        jz      befeje                  ; Igen, akkor v�ge
        cmp     al,'q'                  ; 'q' volt?
        jz      befeje                  ; Igen, akkor v�ge
        mov     ah,2                    ; Karakterki�rat�s k�dja
        mov     dl,bh                   ; Ezt kell ki�rni
        int     21h                     ; Karakterki�rat�s DOS-sal
        mov     dl,13                   ; Ezt kell ki�rni (CR)
        int     21h                     ; Karakterki�rat�s DOS-sal
        mov     dl,10                   ; Ezt kell ki�rni (LF)
        int     21h                     ; Karakterki�rat�s DOS-sal
        inc     bh                      ; K�vetkez�
        cmp     bh,'9' + 1              ; El�rt a v�g�re
        jnz     szacik                  ; Nem, ki�rat� ciklus
befeje:
        mov     ah,4ch   
        int     21h

szoveg  db      'Assembly'
hossza  equ     $ - szoveg
code	ends
	end	start

