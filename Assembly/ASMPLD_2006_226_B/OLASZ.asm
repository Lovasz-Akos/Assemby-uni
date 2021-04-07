code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,13h                  ; MCGA �zem k�dja
        int     10h                     ; Elind�tom az MCGA �zemet
        mov     ax,0a000h               ; Ez az MCGA �zem ter�lete
        mov     es,ax                   ; ES <- MCGA ter�let c�me
        mov     si,offset szintbl       ; Itt van a t�bl�zat

        mov     di,(25 * 320) - 40      ; M�g h�tt�rrel kezdek
        mov     cx,150                  ; A z�szl� ilyen magas legyen
zamagc:
        push    cx                      ; M�sra is haszn�lom, ez�' mentem
        mov     al,0                    ; H�tt�rrel kezdek, ez az �tl�p�s
megtob:
        mov     cl,80                   ; Egy elem sz�less�ge pontban
        rep     stosb                   ; Kimenet a 80 sz�nb�jt
        inc     al                      ; K�vetkez� sz�n
        cmp     al,4                    ; Ez m�r a 5. sz�n?
        jnz     megtob                  ; Nem, rajtolok tov�bb
        pop     cx                      ; Vissza a magass�g ciklusa
        loop    zamagc                  ; Kirajzolom a z�szl� magass�g�t
        call    negysz                  ; N�gy sz�n defini�l�s, majd v�r�s
        call    negysz                  ; N�gy sz�n defini�l�s, majd v�r�s
        mov     ax,3                    ; Visszakapcsolaok karekteresre
        int     10h                     ; Visszakapcsol�s
	mov	ah,4ch
	int	21h
negysz:
        mov     cl,4                    ; Ciklusban defini�lok
szinde:
        mov     dx,3c8h                 ; Ez a sz�nsz�m regisztere
        lodsb                           ; Sz�nsz�m beolvas�s
        out     dx,al                   ; Kik�ld�m a sz�nsz�mot
        inc     dx                      ; Megn�velem a sz�n�sszetev�k c�m�re
        lodsb                           ; Piros �sszetev� beolvas�s
        out     dx,al                   ; Kik�ld�m az �sszetev�t
        lodsb                           ; Z�ld �sszetev� beolvas�s
        out     dx,al                   ; Kik�ld�m az �sszetev�t
        lodsb                           ; K�k �sszetev� beolvas�s
        out     dx,al                   ; Kik�ld�m az �sszetev�t
        loop    szinde                  ; Sz�ndefini�l�s ciklusban
        mov     ah,8                    ; Karakterbeolvas�s n�m�n k�dja
        int     21h                     ; DOS h�v�s klavira v�r�sra
        ret                             ; K�sz, visszat�rek

szintbl db      0,0,0,63                ; H�tt�rsz�n k�k
        db      1,63,0,0                ; 1-es sz�n piros
        db      2,63,63,63              ; 2-es sz�n feh�r
        db      3,0,63,0                ; 3-as sz�n z�ld

        db      0,0,0,0                 ; H�tt�rsz�n fekete
        db      1,0,63,0                ; 1-es sz�n z�ld
        db      2,63,63,63              ; 2-es sz�n feh�r
        db      3,63,0,0                ; 3-as sz�n piros

code	ends
	end	start

