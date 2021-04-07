code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        xor     bx,bx                   ; Kezdeti ÇrtÇk
        mov     si,10                   ; Ez a szorz¢
beocik:
        mov     ah,1                    ; Beolvas†s viszhanggal k¢dja
        int     21h                     ; Beolvas†sra DOS h°v†s
        cmp     al,13                   ; ENTER lett leÅtve?
        jz      eppkii                  ; Igwen, ki°rat†s jîn
        cmp     al,'0'                  ; Kisebb mint a '0' karakter?
        jb      ighiba                  ; Igen, kisebb, hiba van
        cmp     al,'9'                  ; Nagyobbb mint a '9' karakter?
        ja      ighiba                  ; Igen, nagyobb, hiba van
        and     ax,0000000000001111b    ; Csak az als¢ nÇgy bit marad
        xchg    bx,ax                   ; AX <- eddigi, BX <- leÅtîtt ÇrtÇk
        mul     si                      ; AX <- AX * 10
        jc      tulsok                  ; Nagyobb lett mint 65535
        add     bx,ax                   ; EredmÇny
        jnc     beocik                  ; Ciklusban beolvasok
tulsok:
        mov     dx,offset soknum        ; Szîvegc°m
        jmp     bajkii                  ; Hibaki°rat†s lesz
eppkii:
        mov     ax,'BX'                 ; Ez lesz a rutin paramÇtere
        call    regkii                  ; Regiszterki°rat¢ rutin
kilep:
	mov	ah,4ch
	int	21h
ighiba:
        mov     dx,offset rosszc        ; Szîvegc°m
bajkii:
        mov     ah,9                    ; Stringki°rat†s k¢dja
        int     21h                     ; Hibaszîveg kikÅldÇs
        jmp     kilep                   ; Befejeztem
        

regkii:
;
; Elsãre ki°ratom az AX-ben levã kÇt bet˚t, de
; el kell tenni a m†sikat, mert a ki°rat†s erontan†
;
        push    ax                      ; Elromlana az AL
        mov     dl,ah                   ; A DOS innen fogja ki°rni
        mov     ah,2                    ; A ki°rat†s k¢dja DOS-ban
        int     21h                     ; Az elsã bet˚ kikÅldÇse
        pop     dx                      ; DL-be vissza a rÇgi AL
;
; AH-ban tov†bbra is 2 van, nem kell £jra betîlteni!!!
;
        int     21h                     ; A m†sodik bet˚ kikÅldÇse
        mov     dl,'='                  ; Mehet ki az '=' karakter
        int     21h                     ; Az '=' kikÅldÇse
;
; A kezdeti ÇrtÇket amit ki akarok °rni BX tartalmazza.
; BX-et £gy °ratom ki, mintha kÇt rÇszbãl †llna. Olyan
; Elj†r†st h°vok ami BL-t °rja ki.
;
        push    bx                      ; Elrontan†m
        mov     bl,bh                   ; Elãszîr a BH kerÅl ki°rat†sra
        call    blkiir                  ; BL kikÅldÇse a kÇpernyãre (BH)
        pop     bx                      ; Vissza az eredeti BL
        call    blkiir                  ; BL kikÅldÇse a kÇpernyãre (BH)
        mov     dl,10                   ; LF karakter
        mov     ah,2                    ; A ki°rat†s k¢dja DOS-ban
        int     21h                     ; Az LF kikÅldÇse
        mov     dl,13                   ; CR karakter
        int     21h                     ; A CR kikÅldÇse
        ret                             ; KÇsz a ki°r†s visszatÇrhetek
;
; Olyan elj†r†st °rok, amely BL als¢ 4 bitjÇnek ÇrtÇkÇt ki°rja
; Elsãnek a magasabb 4 bitet kell ki°rni, csak ut†na az alacsonyabbat
;
blkiir:
        push    bx                      ; Kell kÇsãbb is az als¢ 4 bit
        shr     bl,1                    ; LelÇptetem 1 bittel BL-t
        shr     bl,1                    ; LelÇptetem 1 bittel BL-t
        shr     bl,1                    ; LelÇptetem 1 bittel BL-t
        shr     bl,1                    ; LelÇptetem 1 bittel BL-t
;
; Most van a felsã nÇgy bit az als¢ nÇgy bit helyÇn
;
        call    bnbkii                  ; Kiteszem a kÇpernyãre a karaktert
        pop     bx                    ; Itt van az als¢ nÇgy bit
;;;;;        call    bnbkii                  ; Kiteszem a kÇpernyãre a karaktert
;;;;;        ret                             ; Kêsz a BL ki°rat†sa
;
; Most a BL als¢ nÇgy bitjÇt karakterrÇ (0..9 Çs A..F) kell alak°tani
;
bnbkii:
        and     bl,00001111b            ; Csak a kÇrdÇses bitek maradjanak
        add     bl,'0'                  ; Ha sz†mjegy, akkor m†r is j¢
        cmp     bl,'9'                  ; ElÇrte a 9-est
        jbe     marnum                  ; Ekkor sz†mjegy
        add     bl,'A' - ('9' + 1)      ; Bet˚vÇ alak°tom
marnum:
        mov     dl,bl                   ; DL-bãl °rom majd ki
;
; Ha a rutin ebben a programban haszn†latos, akkor nem kell az AH-t
; betîlteni, de †ltal†nos rutinn†l nem ismerjÅk AH ÇrtÇkÇt
;
        mov     ah,2                    ; A ki°rat†s k¢dja DOS-ban
        int     21h                     ; A kkisz†molt karakter kikÅldÇse
        ret                             ; Als¢ 4 bit ki°rva


soknum  db      10,13,'T£l nagy ( tîbb mint 65535) az eredmÇny!$'
rosszc  db      10,13,'Hib†s karakter jîtt. KilÇpek!$'


code	ends
	end	start

