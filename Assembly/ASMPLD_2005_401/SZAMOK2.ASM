code    segment para    public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

parmer  db      ?                       ; Ez a param‚terek hossza karakterben

	org	100h

start:
;
; Param‚ter vizsg lat
;
        mov     si,offset parmer        ; SI <- a hossz c¡me
        mov     cl,[si]                 ; CL <- parancsssor hossza
        mov     ch,0                    ; H r‚sz null z sa miatt CX <- CL
        mov     dx,offset nuhopa        ; Sz”vegc¡m, amit ki¡ratok
        jcxz    szokij                  ; Most nulla lett!
        dec     cx                      ; Az elv laszt¢val kevesebb
        jcxz    szokij                  ; Csak az elv laszt¢ karakter van
;
; A ki¡rat sra kerl‹ ‚rt‚k AX-ben lesz
;
        xor     ax,ax                   ; Kezd‹‚rt‚k
        mov     di,10                   ; Ez lesz a szorz¢/oszt¢
;
; Innen m r a parancssor ‚rdemi r‚sz elemezhet‹ ki
;
        add     si,2                    ; SI <- az els‹ karakter c¡me
;
; Ciklust szervezek a beolvas sra
;
karcik:
        mov     dx,offset hibaka        ; Sz”vegc¡m, amit ki¡ratok
        mov     bl,[si]                 ; Beolvasom a karaktert a sorb¢l
        cmp     bl,'0'                  ; Enn‚l a karaktern‚l kisebb?
        jb      szokij                  ; Ha kisebb, akkor hiba t”rt‚nt
        cmp     bl,'9'                  ; Enn‚l a karaktern‚l nagyobb?
        ja      szokij                  ; Ha nagyobb, akkor hiba t”rt‚nt
;
; Itt m r biztosak lehetnk abban, hogy sz mjegy karakter ‚rkezett
; Az eddigi eredm‚nyt megszorzom 10-el
;
        mul     di                      ; AX <- AX * 10
        mov     dx,offset tunaer        ; Sz”vegc¡m, amit ki¡ratok
        jc      szokij                  ; T£l nagy lett
;
; A BL-ben l‚v‹ karakert BX-ben l‚v‹ sz mm  alak¡tjuk
;
        and     bx,000fh                ; BX <- a karakter numerikus ‚rt‚ke
;
; BX-et hozz adom a AX-hez
;
        add     ax,bx                   ; Hozz adom a BX-et
        jc      szokij                  ; T£l nagy lett
;
; A sz mjegy ki‚rt‚kelve, j”het a k”vetkez‹
;
        inc     si                      ; L‚pek a parancsor k”vetkez‹ elem‚re
        loop    karcik                  ; Ciklus a ki¡rat sra
;
; K‚sz a beolvas s, most j”n a ki¡rat s
;
        push    ax                      ; K‚s‹bb is kell
;
; AX ki¡rat sa decim lisan osztogat ssal
;
        xor     cx,cx                   ; Kezdetben
divcik:
        xor     dx,dx                   ; H r‚sz null z s
        div     di                      ; AX <- h nyados, DX <- marad‚k
        push    dx                      ; Ment‚s
        inc     cx                      ; Darabsz m n”vel‚s
        or      ax,ax                   ; Nulla lett?
        jnz     divcik                  ; Mehet vissza
        mov     ah,2                    ; Karakterki¡rat s k¢dja
kiicik:
        pop     dx                      ; Sz m (marad‚k) vissza
        or      dl,'0'                  ; Karakterr‚ alak¡tom
        int     21h                     ; Kimegy a karakter
        loop    kiicik                  ; Az ”sszeset
        mov     dx,offset spaces        ; Sz”vegc¡m, amit ki¡ratok
        mov     ah,9                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        pop     ax                      ; Az ‚rt‚k r‚sz vissza
;
; AX ki¡rat sa £gy t”rt‚nik, hogy alulra l‚ptetek
;
        mov     cx,4                    ; N‚gy hexa jegy lesz
axfoly:
        rol     ax,1                    ; AX fels‹ bitje alulra 1.
        rol     ax,1                    ; AX fels‹ bitje alulra 2.
        rol     ax,1                    ; AX fels‹ bitje alulra 3.
        rol     ax,1                    ; AX fels‹ bitje alulra 4.
        push    ax                      ; K‚s‹bbre elteszem
        and     al,00001111b            ; Csak az als¢ n‚gy bit maradjon
        or      al,'0'                  ; Karakterr‚ konvert lom
        cmp     al,'9'                  ; Enn‚l nagyobb?
        jbe     monosz                  ; Nem, akkor most ez sz mjegy
        add     al,'A' - ('9' + 1)      ; Ez a 10. ‚s az 'A' kl”nbs‚ge (7)
monosz:
        mov     dl,al                   ; DL-be a ki¡ratand¢ ‚rt‚k
        mov     ah,2                    ; Katrakterki¡rat s
        int     21h                     ; DOS h¡v s
        pop     ax                      ; Vissza a v ltozatlan ‚rt‚k
        loop    axfoly                  ; Mind a n‚gy jegyet
;
; P ross g vizsg lat
;
        shr     ax,1                    ; P ros?
        mov     dx,offset parose        ; Sz”vegc¡m, amit ki¡ratok
        jnc     szokij                  ; Igen p ros, ez a sz”veg marad        
        mov     dx,offset paratl        ; Sz”vegc¡m, amit ki¡ratok
szokij:
        mov     ah,9                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
kilep:
	mov	ah,4ch
	int	21h

parose  db      '   P ros!',10,13,'$'

paratl  db      '   P ratlan!',10,13,'$'

spaces  db      '    $';

nuhopa  db      'A parancssorban nincs semmi.$'

hibaka  db      'A parancssorban hib s karakter!$'

tunaer  db      'T£l nagy a vizsg land¢ ‚rt‚k!$'

code	ends
	end	start

