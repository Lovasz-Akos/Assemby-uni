code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        xor     bx,bx                   ; Kezdeti �rt�k
        mov     si,10                   ; Ez a szorz�
beocik:
        mov     ah,1                    ; Beolvas�s viszhanggal k�dja
        int     21h                     ; Beolvas�sra DOS h�v�s
        cmp     al,13                   ; ENTER lett le�tve?
        jz      eppkii                  ; Igwen, ki�rat�s j�n
        cmp     al,'0'                  ; Kisebb mint a '0' karakter?
        jb      ighiba                  ; Igen, kisebb, hiba van
        cmp     al,'9'                  ; Nagyobbb mint a '9' karakter?
        ja      ighiba                  ; Igen, nagyobb, hiba van
        and     ax,0000000000001111b    ; Csak az als� n�gy bit marad
        xchg    bx,ax                   ; AX <- eddigi, BX <- le�t�tt �rt�k
        mul     si                      ; AX <- AX * 10
        jc      tulsok                  ; Nagyobb lett mint 65535
        add     bx,ax                   ; Eredm�ny
        jnc     beocik                  ; Ciklusban beolvasok
tulsok:
        mov     dx,offset soknum        ; Sz�vegc�m
        jmp     bajkii                  ; Hibaki�rat�s lesz
eppkii:
        mov     ax,'BX'                 ; Ez lesz a rutin param�tere
        call    regkii                  ; Regiszterki�rat� rutin
kilep:
	mov	ah,4ch
	int	21h
ighiba:
        mov     dx,offset rosszc        ; Sz�vegc�m
bajkii:
        mov     ah,9                    ; Stringki�rat�s k�dja
        int     21h                     ; Hibasz�veg kik�ld�s
        jmp     kilep                   ; Befejeztem
        

regkii:
;
; Els�re ki�ratom az AX-ben lev� k�t bet�t, de
; el kell tenni a m�sikat, mert a ki�rat�s erontan�
;
        push    ax                      ; Elromlana az AL
        mov     dl,ah                   ; A DOS innen fogja ki�rni
        mov     ah,2                    ; A ki�rat�s k�dja DOS-ban
        int     21h                     ; Az els� bet� kik�ld�se
        pop     dx                      ; DL-be vissza a r�gi AL
;
; AH-ban tov�bbra is 2 van, nem kell �jra bet�lteni!!!
;
        int     21h                     ; A m�sodik bet� kik�ld�se
        mov     dl,'='                  ; Mehet ki az '=' karakter
        int     21h                     ; Az '=' kik�ld�se
;
; A kezdeti �rt�ket amit ki akarok �rni BX tartalmazza.
; BX-et �gy �ratom ki, mintha k�t r�szb�l �llna. Olyan
; Elj�r�st h�vok ami BL-t �rja ki.
;
        push    bx                      ; Elrontan�m
        mov     bl,bh                   ; El�sz�r a BH ker�l ki�rat�sra
        call    blkiir                  ; BL kik�ld�se a k�perny�re (BH)
        pop     bx                      ; Vissza az eredeti BL
        call    blkiir                  ; BL kik�ld�se a k�perny�re (BH)
        mov     dl,10                   ; LF karakter
        mov     ah,2                    ; A ki�rat�s k�dja DOS-ban
        int     21h                     ; Az LF kik�ld�se
        mov     dl,13                   ; CR karakter
        int     21h                     ; A CR kik�ld�se
        ret                             ; K�sz a ki�r�s visszat�rhetek
;
; Olyan elj�r�st �rok, amely BL als� 4 bitj�nek �rt�k�t ki�rja
; Els�nek a magasabb 4 bitet kell ki�rni, csak ut�na az alacsonyabbat
;
blkiir:
        push    bx                      ; Kell k�s�bb is az als� 4 bit
        shr     bl,1                    ; Lel�ptetem 1 bittel BL-t
        shr     bl,1                    ; Lel�ptetem 1 bittel BL-t
        shr     bl,1                    ; Lel�ptetem 1 bittel BL-t
        shr     bl,1                    ; Lel�ptetem 1 bittel BL-t
;
; Most van a fels� n�gy bit az als� n�gy bit hely�n
;
        call    bnbkii                  ; Kiteszem a k�perny�re a karaktert
        pop     bx                    ; Itt van az als� n�gy bit
;;;;;        call    bnbkii                  ; Kiteszem a k�perny�re a karaktert
;;;;;        ret                             ; K�sz a BL ki�rat�sa
;
; Most a BL als� n�gy bitj�t karakterr� (0..9 �s A..F) kell alak�tani
;
bnbkii:
        and     bl,00001111b            ; Csak a k�rd�ses bitek maradjanak
        add     bl,'0'                  ; Ha sz�mjegy, akkor m�r is j�
        cmp     bl,'9'                  ; El�rte a 9-est
        jbe     marnum                  ; Ekkor sz�mjegy
        add     bl,'A' - ('9' + 1)      ; Bet�v� alak�tom
marnum:
        mov     dl,bl                   ; DL-b�l �rom majd ki
;
; Ha a rutin ebben a programban haszn�latos, akkor nem kell az AH-t
; bet�lteni, de �ltal�nos rutinn�l nem ismerj�k AH �rt�k�t
;
        mov     ah,2                    ; A ki�rat�s k�dja DOS-ban
        int     21h                     ; A kkisz�molt karakter kik�ld�se
        ret                             ; Als� 4 bit ki�rva


soknum  db      10,13,'T�l nagy ( t�bb mint 65535) az eredm�ny!$'
rosszc  db      10,13,'Hib�s karakter j�tt. Kil�pek!$'


code	ends
	end	start

