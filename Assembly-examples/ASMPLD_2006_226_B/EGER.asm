code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; Hogy az �zemm�d ilyen legyen...
        int     10h                     ; Be�ll�tom
        mov     ax,0b800h               ; Ez a szegmens �rt�ke
        mov     es,ax                   ; ES <- B800 t�lt�s
        cld                             ; N�vekv� c�mes stringm�veletek
        xor     ax,ax                   ; AX <- 0
        int     33h                     ; Van eg�rdriver?
        or      ax,ax                   ; Nulla maradt?
        jz      egerni                  ; Nincs eg�rdriver
;
; Bekapcsolom az eg�rkurzort
;
        mov     ax,1                    ; Eg�r l�that�v� t�tel k�dja
        int     33h                     ; Eg�rdriver megh�v�sa
;
; Sz�veg k�z�pre
;
        mov     dx,offset balfel        ; Bal fels� sor ki�rat�s
        call    sorkii                  ; Kiteszem a k�zep�re
;
; V�rok eg�rle�t�sre, majd a poz�ci�t ki�rt�kelem
;
nemnul:
        call    egerny                  ; Eg�rlenyom�s vizsg�lata
        or      cx,dx                   ; X = Y = 0 helyen nyomta?
        jnz     nemnul                  ; Nem, ism�tlek
;
; Sz�veg k�z�pre
;
        mov     dx,offset jobfel        ; Jobb fels� sor ki�rat�s
        call    sorkii                  ; Kiteszem a k�zep�re
;
; V�rok eg�rle�t�sre, majd a poz�ci�t ki�rt�kelem
;
nemjof:
        call    egerny                  ; Eg�rlenyom�s vizsg�lata
        or      dx,dx                   ; Y = 0 helyen nyomta?
        jnz     nemjof                  ; Nem, ism�tlek
        cmp     cx,79 * 8               ; X = 79 helyen nyomta?
        jnz     nemjof                  ; Nem, ism�tlek
;
; Sz�veg k�z�pre
;
        mov     dx,offset jobals        ; Jobb als� sor ki�rat�s
        call    sorkii                  ; Kiteszem a k�zep�re
;
; V�rok eg�rle�t�sre, majd a poz�ci�t ki�rt�kelem
;
nemjoa:
        call    egerny                  ; Eg�rlenyom�s vizsg�lata
        cmp     dx,24 * 8               ; Y = 24 helyen nyomta?
        jnz     nemjoa                  ; Nem, ism�tlek
        cmp     cx,79 * 8               ; X = 79 helyen nyomta?
        jnz     nemjoa                  ; Nem, ism�tlek
;
; Sz�veg k�z�pre
;
        mov     dx,offset balals        ; Bal als� sor ki�rat�s
        call    sorkii                  ; Kiteszem a k�zep�re
;
; V�rok eg�rle�t�sre, majd a poz�ci�t ki�rt�kelem
;
nembaa:
        call    egerny                  ; Eg�rlenyom�s vizsg�lata
        cmp     dx,24 * 8               ; Y = 24 helyen nyomta?
        jnz     nembaa                  ; Nem, ism�tlek
        or      cx,cx                   ; X = 0 helyen nyomta?
        jnz     nembaa                  ; Nem, ism�tlek
;
; A v�ge�n ki kell kapcsolni
;

        mov     ax,2                    ; Eg�r neml�that�v� t�tel k�dja
        int     33h                     ; Eg�rdriver megh�v�sa

befprg:
	mov	ah,4ch
	int	21h
egerni:
        mov     ah,9                    ; Sz�vegki�rat�s k�dja
        mov     dx,offset nindri        ; Sz�vegc�m
        int     21h                     ; Ki�ratom
        jmp     befprg                  ; Befejezem a programot


;
; Eg�rle�t�st kiv�r� rutin
;
egerny:
        mov     ax,3                    ; Eg�rkurzor poz�ci� lek�rdez�s k�dja
        int     33h                     ; Eg�rdriver megh�v�sa
        test    bx,0000000000000001b    ; Volt bal gomb?
        jz      egerny                  ; Nem, v�rok r�
;
; M�r le�t�ttek, v�rok az elenged�sre
;
megnyo:
        mov     ax,3                    ; Eg�rkurzor poz�ci� lek�rdez�s k�dja
        int     33h                     ; Eg�rdriver megh�v�sa
        test    bx,0000000000000001b    ; Van bal gomb?
        jnz     megnyo                  ; Igen, m�g nem engedte el
;
; Visszat�r�s el�tt hossz �rt�kek maszkol�sa
;
        and     cx,0fff8h               ; Hogy 8-al oszthat� legyen az X
        and     dx,0fff8h               ; Hogy 8-al oszthat� legyen az Y
        ret                             ; K�sz
;
; Ki�rat� rutin
;
sorkii:
        mov     ax,2                    ; Eg�r neml�that�v� t�tel k�dja
        int     33h                     ; Eg�rdriver megh�v�sa
        mov     di,offset 80 * 12 * 2   ; Itt fogok t�r�lni
        mov     cx,80                   ; Ennyi a hossza a sornak
        mov     ax,es:[di]              ; AH <- sz�nk�d
        mov     al,' '                  ; Ezzel fogok az el�z�t t�r�lni
        rep     stosw                   ; Ism�telt sz�k�z kit�tel
        mov     si,dx                   ; Ez a c�m
        lodsb                           ; AL <- hossz b�jt
        mov     ah,0                    ; AX <- hossz �rt�ke
        mov     cx,ax                   ; A hosszr�l m�solat
        neg     ax                      ; AX negat�v legyen
        add     ax,80                   ; AX <- (80 - hossz)
;
; Logikailag lehetne AND AX,0FFFEH m�velet is!!!!
;
        shr     ax,1                    ; A fele kell csak (�gy k�z�pre megy)
        shl     ax,1                    ; Dupla a hossza
        add     ax,80 * 12 * 2          ; A sor elej�re tolom
        mov     di,ax                   ; Ide teszem ki
kamaci:
        lodsb                           ; Beolvastam a programb�l
        stosb                           ; Kitettem a k�perny�re
        inc     di                      ; Sz�nr�sz �tl�p�s
        loop    kamaci                  ; Kim�solom a karaktereket
        mov     ax,1                    ; Eg�r l�that�v� t�tel k�dja
        int     33h                     ; Eg�rdriver megh�v�sa
        ret                             ; K�sz a karaktersor kit�tele

balfel  db      balveg - $ - 1          ; Ennyi a sz�veg hossza
        db      'Kattints a bal fels� sarokba!'
balveg  equ     $

jobfel  db      jobveg - $ - 1          ; Ennyi a sz�veg hossza
        db      'Kattints a jobb fels� sarokba!'
jobveg  equ     $

jobals  db      jobave - $ - 1          ; Ennyi a sz�veg hossza
        db      'Kattints a jobb als� sarokba!'
jobave  equ     $

balals  db      balave - $ - 1          ; Ennyi a sz�veg hossza
        db      'Kattints a bal als� sarokba!'
balave  equ     $


nindri  db      'Nincs eg�rdriver!$'

code	ends
	end	start

