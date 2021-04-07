code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

parmer  db      ?                       ; Ez a param‚terek hossza karakterben
        db      ?                       ; Az elv laszt¢ karakter helye
parsor  db      125 dup(?)              ; A parancssor ‚rdemi r‚sz

	org	100h


start:
;
; Param‚ter vizsg lat
;
        mov     cl,[parmer]             ; CL <- parancsssor hossza
        mov     ch,0                    ; H r‚sz null z sa miatt CX <- AL
        jcxz    mostnu                  ; Most nulla lett!
        dec     cx                      ; Csak az elv laszt¢ van?
        jcxz    mostnu                  ; Igen, csak az elv laszt¢ karakter
;
; A ki¡rat sra kerl‹ ‚rt‚k DX:AX-ben lesz
;
        xor     ax,ax                   ; L r‚sz kezd‹‚rt‚ke
        cwd                             ; DX-be (H r‚sz) is nulla kerl
        mov     di,10                   ; Ez lesz a szorz¢
;
; Innen m r a parancssor ‚rdemi r‚sz elemezhet‹ ki
;
        mov     si,offset parsor        ; SI <- a param‚tersor els‹
                                        ; karakter‚nek c¡me
;
; Ciklust szervezek a kbeolvas sra
;
karcik:
        mov     bl,[si]                 ; Beolvasom a karaktert a sorb¢l
        cmp     bl,'0'                  ; Enn‚l a karaktern‚l kisebb?
        jb      hibach                  ; Ha kisebb, akkor hiba t”rt‚nt
        cmp     bl,'9'                  ; Enn‚l a karaktern‚l nagyobb?
        ja      hibach                  ; Ha nagyobb, akkor hiba t”rt‚nt
;
; Itt m r biztosak lehetnk abban, hogy sz mjegy karakter ‚rkezett
; Az eddigi eredm‚nyt megszorzom 10-el
;
        mul     di                      ; DX:AX <- (DX:AX) * 10
;
; A BL-ben l‚v‹ karakert BX-ben l‚v‹ sz mm  alak¡tjuk
;
        and     bx,000fh                ; BX <- a karakter numerikus ‚rt‚ke
;
; BX-et hozz adom a DX:AX-hez
;
        add     ax,bx                   ; L r‚szhez hozz adom a BX-et
        adc     dx,0                    ; Ha VAN!! CY, hozz adom DX-hez
;
; A sz mjegy ki‚rt‚kelve, j”het a k”vetkez‹
;
        inc     si                      ; L‚pek a parancsor k”vetkez‹ elem‚re
        loop    karcik                  ; Ciklus a ki¡rat sra
;
; K‚sz a beolvas s, most j”n a k¡rat s
;
        push    ax                      ; K‚s‹bb ¡rom majd ki
        mov     ax,dx                   ; DX-ben a H r‚sz van
        call    axdeko                  ; DX ki¡rat sa
        pop     ax                      ; L r‚sz vissza
        call    axdeko                  ; L r‚sz ki¡rat sa
        jmp     kilep                   ; Ha m r ki¡rtuk ut na kil‚pnk
mostnu:
        mov     dx,offset nuhopa        ; Sz”vegc¡m, amit ki¡ratok
        jmp     csaszo                  ; Sz”vegc¡m be ll¡tva, csak ki¡rat s
hibach:
        mov     dx,offset hibaka        ; Sz”vegc¡m, amit ki¡ratok
csaszo:
        mov     ah,9                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
kilep:
	mov	ah,4ch
	int	21h
;
; AX ki¡rat sa £gy t”rt‚nik, hogy el‹sz”r AH, majd AL ki¡r sa t”rt‚nik meg
;
axdeko:
        push    ax                      ; K‚s‹bb m‚g kell
        mov     al,ah                   ; AL k¡r sa miatt AH-t beleteszem
        call    aldeko                  ; AL ki¡rat sa
        pop     ax                      ; Eredeti ‚rt‚k vissza
        call    aldeko                  ; AL ki¡rat sa 
        ret                             ; K‚sz a ki¡rat s
;
; AL ki¡rat sa £gy, hogy el‹sz”r a fels‹ 4 bitje, majd az als¢ 4 bitje
;
aldeko:
        push    ax                      ; Elteszem k‚s‹bbre
        shr     al,1                    ; Lel‚ptetem 1-et
        shr     al,1                    ; Lel‚ptetem 1-et
        shr     al,1                    ; Lel‚ptetem 1-et
        shr     al,1                    ; Lel‚ptetem 1-et (”sszesen n‚gyszer!)
        call    nebiki                  ; AL als¢ n‚gy bitj‚t ki¡ratom
        pop     ax                      ; AL als¢ n‚gy bit (is) vissza
        call    nebiki                  ; AL als¢ n‚gy bitj‚t ki¡ratom
        ret                             ; K‚sz vagyok
;
; AL als¢ n‚gy bitj‚t ki¡ratom HEX ban
;
nebiki:
        and     al,00001111b            ; Csak az als¢ n‚gy bit maradjon
        mov     dl,al                   ; DL-be a kiratand¢ ‚rt‚k
        add     dl,'0'                  ; Karakterr‚ konvert lom
        cmp     dl,'9'                  ; Enn‚l nagyobb?
        jbe     monosz                  ; Nem, akkor most ez sz mjegy
        add     dl,'A' - ('9' + 1)      ; Ez a 10. ‚s az 'A' kl”nbs‚ge
monosz:
        mov     ah,2                    ; A DOS egy karakter ki¡r s k‚r‚s
        int     21h                     ; DOS h¡v s
        ret                             ; Ki¡rat s k‚sz

nuhopa  db      'A parancssorban nincs semmi.$'

hibaka  db      'A parancssorban hib s karakter!$'

code	ends
	end	start

