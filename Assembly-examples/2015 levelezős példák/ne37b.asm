code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; Video Bios h�v�sa t�rl�shez
        mov     bx,'99'                 ; Ezzel kezdek
ujrame:
        cmp     bx,'00'                 ; Ez az?
        jz      kilep                   ; Igen, v�ge
        mov     dl,bh                   ; A h�nyados sz�m�rt�ke
        mov     ah,2                    ; Karakter ki�rat�s k�dja
        int     21h                     ; Ki�r�s DOS-sal
        mov     dl,bl                   ; A marad�k sz�m�rt�ke
        mov     ah,2                    ; Karakter ki�rat�s k�dja
        int     21h                     ; Ki�r�s DOS-sal
        mov     dl,13                   ; CR
        int     21h                     ; Ki�r�s DOS-sal
        mov     dl,10                   ; LF
        int     21h                     ; Ki�r�s DOS-sal
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; DOS-sal v�rok
        cmp     al,27                   ; ESC volt?
        jz      kilep                   ; Igen, be is fejezem
        dec     bl                      ; Egyel cs�kkentem
        cmp     bl,'0'                  ; Enn�l kisebb lett?
        jae     ujrame                  ; Nem, megyek tov�bb
        mov     bl,'9'                  ; �j kezdet
        dec     bh                      ; H r�sz is cs�kken
        cmp     bh,'0'                  ; Enn�l kisebb lett?
        jae     ujrame                  ; Nem, megyek tov�bb
kilep:
        mov     ah,4ch
        int     21h

kiltxt  db      13,10,'Kil�pjek? (Igen) $'
               

code	ends
	end	start

