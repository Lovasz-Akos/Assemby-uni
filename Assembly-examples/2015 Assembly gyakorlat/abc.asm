code    segment para   public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�d �s k�d
        int     10h                     ; Video BIOS h�v�sa
        mov     dx,offset escszo        ; A sz�veg c�me
        mov     ah,9                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
        mov     cx,26                   ; Ennyiszer fusson a ciklus
        mov     dl,'a'                  ; Kezd� karakter
cikkor:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; A DOS h�v�sa le�t�sv�r�sra 
        cmp     al,27                   ; �ppen az ESC karakter?
        jz      befeje                  ; Igen, akkor v�ge van
;;;;        mov     dl,bl                   ; DL <- ki�ratand� karakter
        mov     ah,2                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
        inc     dl                      ; A k�vetkez�re
        loop    cikkor                  ; Ha maradt m�g bel�le, akkor vissza
befeje:
	mov	ah,4ch
        int     21h

escszo  db      'ESC= v�ge!', 13, 10, '$'

code	ends
	end	start

                                        
