code    segment para   public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�d �s k�d
        int     10h                     ; Video BIOS h�v�sa
        mov     dx,offset escszo        ; A sz�veg c�me
        mov     ah,9                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
elokez:
        mov     bl,0                    ; Nincs semmi
cikkor:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; A DOS h�v�sa le�t�sv�r�sra 
        cmp     al,27                   ; �ppen az ESC karakter?
        jz      befeje                  ; Igen, akkor v�ge van
        mov     dl,al                   ; A kiteend� karakter
        mov     ah,2                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
        cmp     dl,'a'                  ; �ppen az 'a' karakter?
        jnz     talble                  ; Nem, akkor 'b'-t vizsg�lom
        mov     bl,1                    ; Jelzem, hogy volt 'a'
        jmp     cikkor                  ; �j le�t�st v�rok
;
; 'a' ut�n a 'b'-t vizsg�lom
;
talble:
        cmp     dl,'b'                  ; �ppen a 'b' karakter?
        jnz     talcle                  ; Nem, akkor lehet a 'c'
        cmp     bl,1                    ; El�tte 'a' volt?
        jnz     elokez                  ; Nem, kezdj�k az elej�n
        mov     bl,2                    ; Jelzem, hogy 'b' is volt
        jmp     cikkor                  ; �j le�t�st v�rok
;
; 'b' ut�n a 'c'-re v�rok
;                     
talcle:
        cmp     dl,'c'                  ; �ppen a 'c' karakter?
        jnz     elokez                  ; Nem, akkor lehet a 'c'
        cmp     bl,2                    ; El�tte 'b' volt?
        jnz     elokez                  ; Nem, kezdj�k az elej�n
befeje:
	mov	ah,4ch
        int     21h

escszo  db      'ESC, vagy abc egym�s ut�ni le�t�sre v�ge!', 13, 10, '$'  

code	ends
	end	start

                                        
