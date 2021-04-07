code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:               
        mov     ax,3                    ; K�perny�t�rl�shez v�lt�s k�d
        int     10h                     ; Video Bios-al t�rl�s
        mov     ax,1                    ; Eg�r kurzor bekapcsol�s
        int     33h                     ; Eg�r driver h�v�sa
        mov     si,0ffffh               ; Ilyen X koordin�ta nincs
        mov     bp,0ffffh               ; Ilyen Y koordin�ta nincs
egecik:
        mov     ah,1                    ; Le�t�s vizsg�lat k�dja
        int     16h                     ; Klavi a Bios-ban
        jz      ninleu                  ; Nincs le�t�s
        mov     ah,0                    ; Le�t�s beolvas�s
        int     16h                     ; Klavi a Bios-ban
        cmp     al,27                   ; �ppen ESC volt?
        jz      kileci                  ; Igen, kil�pek a ciklusb�l
ninleu:
        mov     ax,3                    ; Eg�r�llapot lek�rdez�s k�dja
        int     33h                     ; Eg�r driver h�v�sa
        cmp     cx,si                   ; Ilyen volt az X?
        jnz     kooval                  ; Nem, v�ltozott
        cmp     dx,bp                   ; Ilyen volt az Y?
        jz      koonev                  ; Igen, nincs v�ltoz�s
kooval:
        mov     si,cx                   ; Az �j X koordin�ta
        mov     bp,dx                   ; Az �j Y koordin�ta
;
; Most ki�rom a koordin�t�kat
;                                             
        mov     ax,2                    ; Eg�r kurzor kikapcsol�s
        int     33h                     ; Eg�r driver h�v�sa
        mov     ah,2                    ; Egy karakter ki�r�sa
        mov     dl,'X'                  ; Ezt �rja ki
        int     21h                     ; Ki�rat�s DOS-sal
        mov     dl,'='                  ; Ezt �rja ki
        int     21h                     ; Ki�rat�s DOS-sal
        mov     ax,si                   ; Ezt �rja ki
        call    axdeko                  ; AX ki�rat�sa decim�lisan
        mov     ah,2                    ; Egy karakter ki�r�sa
        mov     dl,'Y'                  ; Ezt �rja ki
        int     21h                     ; Ki�rat�s DOS-sal
        mov     dl,'='                  ; Ezt �rja ki
        int     21h                     ; Ki�rat�s DOS-sal
        mov     ax,bp                   ; Ezt �rja ki
        call    axdeko                  ; AX ki�rat�sa decim�lisan
        mov     ah,9                    ; Karakter string ki�r�sa
        mov     dx,offset martor        ; Ezt �rja ki
        int     21h                     ; Ki�rat�s DOS-sal
        mov     ax,1                    ; Eg�r kurzor bekapcsol�s
        int     33h                     ; Eg�r driver h�v�sa
koonev:
        jmp     egecik                  ; Eg�r v�r� ciklus
kileci:
        mov     ax,2                    ; Eg�r kurzor kikapcsol�s
        int     33h                     ; Eg�r driver h�v�sa
	mov	ah,4ch
        int     21h
axdeko:
        mov     cl,3                    ; Ennyiszer l�pjen
        shr     ax,cl                   ; Osztom 8-al
        mov     cx,sp                   ; Most �res a stack
        mov     bx,10                   ; Ezzel osztogatok
kokasz:
        xor     dx,dx                   ; H r�sz �res legyen
        div     bx                      ; DX:AX oszt�sa
        push    dx                      ; Karakternek val�
        or      ax,ax                   ; Megvizsg�lom, hogy nulla-e
        jnz     kokasz                  ; M�g sz�molni kell
        mov     ah,2                    ; Egy karakter ki�rat�sa
vanmik:
        pop     dx                      ; A marad�k
        or      dl,'0'                  ; Karakterr� alak�tom
        int     21h                     ; Ki�rat�s DOS-sal        
        cmp     cx,sp                   ; A v�g�re �rt m�r?
        jnz     vanmik                  ; Nem, m�g veszek ki
        ret                             ; K�sz vagyok

martor  db      '      ', 13, '$'


code	ends
	end	start

