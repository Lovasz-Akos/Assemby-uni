code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h

buflen  EQU     78                      ; A puffer hosza

start:
        mov     ax,3                    ; M�dv�lt�s k�dja k�perny�t�rl�shez
        int     10h                     ; 80x25-�s sz�nes �zemm�dra VGA BIOS
        xor     di,di                   ; Ez az alaphelyzet (nincs le�t�s)
strkii:
        mov     dx,offset taldrb        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�rat�s k�dja
        int     21h                     ; A DOS h�v�sa ki�rat�sra
vartov:
        mov     ah,1                    ; BIOS le�t�sfigyel�s k�dja
        int     16h                     ; BIOS le�t�sfigyel�s h�v�sa
        jnz     valami                  ; Volt le�t�s
        mov     ax,3                    ; Eg�rparam�terek beolvas�sa
        int     33h                     ; Eg�rkezel�s
        mov     si,offset taldrb        ; Sz�vegc�m a karakterhez
        mov     al,[si]                 ; Ezt v�ltoztatom
        mov     cx,bx                   ; M�solat az eredeti �llapotr�l
        xor     bx,di                   ; �sszehasonl�t�s
        and     bx,0000000000000011b    ; Csak a k�t als� bit sz�m�t
        mov     di,cx                   ; Most m�r ez az alap�llapot
        jz      vartov                  ; Nincs v�ltoz�s
        test    bx,0000000000000001b    ; Melyik gomb az?
        jz      jobbgo                  ; A jobb volt az (Nem a bal. :-)
        test    cx,0000000000000001b    ; A bal le van nyomva?
        jz      vartov                  ; Nincs, akkor v�rok tov�bb
        cmp     al,'9'                  ; M�r itt tart?
        jz      vartov                  ; Igen, nem birizg�lom
        inc     al                      ; A k�vetkez�re
        mov     [si],al                 ; Ezt ki is teszem
        jmp     strkii                  ; �jra kiteszem
jobbgo:
        test    cx,0000000000000010b    ; A jobb le van nyomva?
        jz      vartov                  ; Nincs, akkor v�rok tov�bb
        cmp     al,'1'                  ; M�r itt tart?
        jz      vartov                  ; Igen, nem birizg�lom
        dec     al                      ; Az el�z�re
        mov     [si],al                 ; Ezt ki is teszem
        jmp     strkii                  ; �jra kiteszem
valami:
        mov     ah,0                    ; BIOS le�t�sv�r�s k�dja
        int     16h                     ; BIOS le�t�sv�r�s h�v�sa
        cmp     al,27                   ; Az ESC volt az?
        jnz     vartov                  ; V�rok tov�bb


        mov     ah,4ch
        int     21h         

taldrb  db      '1', 8, '$'

code	ends
	end	start

