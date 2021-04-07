code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,13h                  ; MCGA Åzem k¢dja
        int     10h                     ; Elind°tom az MCGA Åzemet
        mov     ax,0a000h               ; Ez az MCGA Åzem terÅlete
        mov     es,ax                   ; ES <- MCGA terÅlet c°me
        mov     si,offset szintbl       ; Itt van a t†bl†zat

        mov     di,(25 * 320) - 40      ; MÇg h†ttÇrrel kezdek
        mov     cx,150                  ; A z†szl¢ ilyen magas legyen
zamagc:
        push    cx                      ; M†sra is haszn†lom, ezÇ' mentem
        mov     al,0                    ; H†ttÇrrel kezdek, ez az †tlÇpÇs
megtob:
        mov     cl,80                   ; Egy elem sz†lessÇge pontban
        rep     stosb                   ; Kimenet a 80 sz°nb†jt
        inc     al                      ; Kîvetkezã sz°n
        cmp     al,4                    ; Ez m†r a 5. sz°n?
        jnz     megtob                  ; Nem, rajtolok tov†bb
        pop     cx                      ; Vissza a magass†g ciklusa
        loop    zamagc                  ; Kirajzolom a z†szl¢ magass†g†t
        call    negysz                  ; NÇgy sz°n defini†l†s, majd v†r†s
        call    negysz                  ; NÇgy sz°n defini†l†s, majd v†r†s
        mov     ax,3                    ; Visszakapcsolaok karekteresre
        int     10h                     ; Visszakapcsol†s
	mov	ah,4ch
	int	21h
negysz:
        mov     cl,4                    ; Ciklusban defini†lok
szinde:
        mov     dx,3c8h                 ; Ez a sz°nsz†m regisztere
        lodsb                           ; Sz°nsz†m beolvas†s
        out     dx,al                   ; KikÅldîm a sz°nsz†mot
        inc     dx                      ; Megnîvelem a sz°nîsszetevãk c°mÇre
        lodsb                           ; Piros îsszetevã beolvas†s
        out     dx,al                   ; KikÅldîm az îsszetevãt
        lodsb                           ; Zîld îsszetevã beolvas†s
        out     dx,al                   ; KikÅldîm az îsszetevãt
        lodsb                           ; KÇk îsszetevã beolvas†s
        out     dx,al                   ; KikÅldîm az îsszetevãt
        loop    szinde                  ; Sz°ndefini†l†s ciklusban
        mov     ah,8                    ; Karakterbeolvas†s nÇm†n k¢dja
        int     21h                     ; DOS h°v†s klavira v†r†sra
        ret                             ; KÇsz, visszatÇrek

szintbl db      0,0,0,63                ; H†ttÇrsz°n kÇk
        db      1,63,0,0                ; 1-es sz°n piros
        db      2,63,63,63              ; 2-es sz°n fehÇr
        db      3,0,63,0                ; 3-as sz°n zîld

        db      0,0,0,0                 ; H†ttÇrsz°n fekete
        db      1,0,63,0                ; 1-es sz°n zîld
        db      2,63,63,63              ; 2-es sz°n fehÇr
        db      3,63,0,0                ; 3-as sz°n piros

code	ends
	end	start

