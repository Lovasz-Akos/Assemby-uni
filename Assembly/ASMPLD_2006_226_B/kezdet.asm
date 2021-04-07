code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        push    dx                      ; DX-et elmentem legm‚lyebbre
        push    bx                      ; BX j”n a DX tetej‚re
        push    ax                      ; AX megy a STACK legfels‹re
;
; A rutinnak k‚t param‚ter lesz. AX-ben a karakterp r (pl.'AX')
; BX-ben padig a ki¡ratand¢ ‚rt‚k
;
        mov     ax,'AX'                 ; Ez lesz a rutin param‚tere
        pop     bx                      ; BX-b‹l fogom ki¡ratni (AX)
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'BX'                 ; Ez lesz a rutin param‚tere
        pop     bx                      ; BX-b‹l fogom ki¡ratni (BX)
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'CX'                 ; Ez lesz a rutin param‚tere
        mov     bx,cx                   ; BX-b‹l fogom ki¡ratni
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'DX'                 ; Ez lesz a rutin param‚tere
        pop     bx                      ; BX-b‹l fogom ki¡ratni (DX)
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'SI'                 ; Ez lesz a rutin param‚tere
        mov     bx,si                   ; BX-b‹l fogom ki¡ratni
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'DI'                 ; Ez lesz a rutin param‚tere
        mov     bx,di                   ; BX-b‹l fogom ki¡ratni
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'BP'                 ; Ez lesz a rutin param‚tere
        mov     bx,bp                   ; BX-b‹l fogom ki¡ratni
        call    regkii                  ; Regiszterki¡rat¢ rutin
        mov     ax,'SP'                 ; Ez lesz a rutin param‚tere
        mov     bx,sp                   ; BX-b‹l fogom ki¡ratni
        call    regkii                  ; Regiszterki¡rat¢ rutin
	mov	ah,4ch
	int	21h
regkii:
;
; Els‹re ki¡ratom az AX-ben lev‹ k‚t betût, de
; el kell tenni a m sikat, mert a ki¡rat s erontan 
;
        push    ax                      ; Elromlana az AL
        mov     dl,ah                   ; A DOS innen fogja ki¡rni
        mov     ah,2                    ; A ki¡rat s k¢dja DOS-ban
        int     21h                     ; Az els‹ betû kikld‚se
        pop     dx                      ; DL-be vissza a r‚gi AL
;
; AH-ban tov bbra is 2 van, nem kell £jra bet”lteni!!!
;
        int     21h                     ; A m sodik betû kikld‚se
        mov     dl,'='                  ; Mehet ki az '=' karakter
        int     21h                     ; Az '=' kikld‚se
;
; A kezdeti ‚rt‚ket amit ki akarok ¡rni BX tartalmazza.
; BX-et £gy ¡ratom ki, mintha k‚t r‚szb‹l  llna. Olyan
; Elj r st h¡vok ami BL-t ¡rja ki.
;
        push    bx                      ; Elrontan m
        mov     bl,bh                   ; El‹sz”r a BH kerl ki¡rat sra
        call    blkiir                  ; BL kikld‚se a k‚perny‹re (BH)
        pop     bx                      ; Vissza az eredeti BL
        call    blkiir                  ; BL kikld‚se a k‚perny‹re (BH)
        mov     dl,10                   ; LF karakter
        mov     ah,2                    ; A ki¡rat s k¢dja DOS-ban
        int     21h                     ; Az LF kikld‚se
        mov     dl,13                   ; CR karakter
        int     21h                     ; A CR kikld‚se
        ret                             ; K‚sz a ki¡r s visszat‚rhetek
;
; Olyan elj r st ¡rok, amely BL als¢ 4 bitj‚nek ‚rt‚k‚t ki¡rja
; Els‹nek a magasabb 4 bitet kell ki¡rni, csak ut na az alacsonyabbat
;
blkiir:
        push    bx                      ; Kell k‚s‹bb is az als¢ 4 bit
        shr     bl,1                    ; Lel‚ptetem 1 bittel BL-t
        shr     bl,1                    ; Lel‚ptetem 1 bittel BL-t
        shr     bl,1                    ; Lel‚ptetem 1 bittel BL-t
        shr     bl,1                    ; Lel‚ptetem 1 bittel BL-t
;
; Most van a fels‹ n‚gy bit az als¢ n‚gy bit hely‚n
;
        call    bnbkii                  ; Kiteszem a k‚perny‹re a karaktert
        pop     bx                    ; Itt van az als¢ n‚gy bit
;;;;;        call    bnbkii                  ; Kiteszem a k‚perny‹re a karaktert
;;;;;        ret                             ; Ksz a BL ki¡rat sa
;
; Most a BL als¢ n‚gy bitj‚t karakterr‚ (0..9 ‚s A..F) kell alak¡tani
;
bnbkii:
        and     bl,00001111b            ; Csak a k‚rd‚ses bitek maradjanak
        add     bl,'0'                  ; Ha sz mjegy, akkor m r is j¢
        cmp     bl,'9'                  ; El‚rte a 9-est
        jbe     marnum                  ; Ekkor sz mjegy
        add     bl,'A' - ('9' + 1)      ; Betûv‚ alak¡tom
marnum:
        mov     dl,bl                   ; DL-b‹l ¡rom majd ki
;
; Ha a rutin ebben a programban haszn latos, akkor nem kell az AH-t
; bet”lteni, de  ltal nos rutinn l nem ismerjk AH ‚rt‚k‚t
;
        mov     ah,2                    ; A ki¡rat s k¢dja DOS-ban
        int     21h                     ; A kkisz molt karakter kikld‚se
        ret                             ; Als¢ 4 bit ki¡rva

code	ends
	end	start

