code    segment para   public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�d �s k�d
        int     10h                     ; Video BIOS h�v�sa
        mov     dx,offset escszo        ; A sz�veg c�me
        mov     ah,9                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
        mov     dl,'a'                  ; Kezd� karakter
cikkor:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; A DOS h�v�sa le�t�sv�r�sra 
        cmp     al,27                   ; �ppen az ESC karakter?
        jz      befeje                  ; Igen, akkor v�ge van
        cmp     dl,'z' + 1              ; A 'z'-t k�vet�n van?
        jz      befeje                  ; Ezt m�r nem kell ki�rni 
        mov     ah,2                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
        inc     dl                      ; A k�vetkez�re
        jmp     cikkor                  ; M�g van mit ki�rni
befeje:
	mov	ah,4ch
        int     21h

escszo  db      'ESC= v�ge!', 13, 10, '$'  

code	ends
	end	start

                                        
