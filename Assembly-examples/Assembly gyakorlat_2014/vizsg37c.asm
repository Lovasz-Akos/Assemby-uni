code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; VIDEO BIOS h�v�sa, m�dv�lt�shoz
        mov     bl,99                   ; Ezzel kezdek
;
; A ciklust ki�rat�ssal kezdem
;
tokici:
        mov     al,bl                   ; Ezt kell dek�dolni
        aam                             ; Mintha szoroztam volna
        mov     bh,al                   ; M�solat az L r�szr�l
        mov     dl,ah                   ; Az els� NUMERIKUS �rt�k
        or      dl,'0'                  ; Karakterr� alak�tom
        mov     ah,2                    ; Karakterki�rat�s k�dja
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,bh                   ; A 2. karakter NUMERIKUS �rt�kben
        or      dl,'0'                  ; Karakterr� alak�tom
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,13                   ; A CR karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,10                   ; Az LF karakter
        int     21h                     ; Megy ki a karakter DOS-sal

        dec     bl                      ; El�rte?
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

