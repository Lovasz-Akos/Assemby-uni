code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

counte  db      ?                       ; A sz ml l¢ by jt
        db      ?                       ; A hat rol¢ helye
parsor  db      126 dup(?)              ; A parancssor b jtjai

	org	100h


start:
        mov     cl,[counte]             ; CL <- darabsz m
        mov     ch,0                    ; CX <- darabsz m
        jcxz    helple                  ; Ha nincs parancssor, help ki¡rat s
        dec     cx                      ; A hat rol¢ levon sa
        jcxz    helple                  ; Ha nincs parancssor, help ki¡rat s
        xor     di,di                   ; Itt fogom gyûjteni a beolvasottakat
        mov     bx,10                   ; Ezzel szorozgatok
        mov     si, offset parsor       ; Innen olvasok be
;
; Beolvasom a parancsssor karakter‚t
;
beolci:
        lodsb                           ; AL <- parancssor karakter
;
; Ellen‹rz‹m, hogy sz mjegy ASCII karakter-e
;
        cmp     al,'0'                  ; Enn‚l kisebb?
        jb      helple                  ; Igen ez hiba
        cmp     al,'9'                  ; Enn‚l nagyobb?
        ja      helple                  ; Igen ez hiba
;
; µtalak¡tom az ASCII karakter numerikuss 
;
        and     ax,0fh                  ; Csak az als¢ n‚gy ‚rt‚k maradjon
;
; Az eddig t rolt ‚rt‚ket megszorzom 10-el, majd hozz adom a sz mot
;
        xchg    di,ax                   ; AX <- szorzand¢, DI <- sz mjegy
        mul     bx                      ; Megszorzom 10-el
        jc      helple                  ; T£l nagy lett
        add     di,ax                   ; ™sszeadom a beolvasottal
        jc      helple                  ; T£l nagy lett
        loop    beolci                  ; Beolvas¢ ciklus
;
; K‚sz a param‚ter beolvas sa, j”het a sz m¡t s
;
        call    fakter                  ; Kisz m¡tom a faktori list
        jc      helple                  ; T£l nagy lett
;
; DX:AX-ben tal lhat¢ az eredm‚ny. Ki kell ¡rnom
;
        call    dekoki                  ; DX:AX-et ki¡ratom
;
; K‚sz a ki¡r s, kil‚pek
;
        mov     ax,4c00h                ; Sikeres jelz‚ssel l‚pek ki
        int     21h                     ; DOS h¡v s kil‚p‚sre
;
; Vagy nincs param‚ter, vagy nem j¢, vagy t£l nagy az ‚rt‚k
;
helple:
        mov     dx,offset helpsz        ; A help sz”veg c¡me
        mov     ah,9                    ; A ki¡rat s k¢dja
        int     21h                     ; Ki¡rat s a DOS-sal
        mov     ax,4c01h                ; Nem sikeres jelz‚ssel l‚pek ki
        int     21h                     ; DOS h¡v s kil‚p‚sre
;
; Rekurz¡v faktori lis sz m¡t s.
; Input:  DI
; Output: DX:AX
;
fakter:
;
; Megn‚zem, hogy 0, vagy 1-e az
;
        cmp     di,1                    ; Enn‚l nagyobb?
        ja      nagyfa                  ; Igen, sz molni kell
;
; Be ll¡tom mint alap‚rt‚ket 0! ‚s 1! eset‚n
;
        mov     ax,1                    ; 0!, 1! eset‚n ez az L ‚rt‚k
        cwd                             ; DX-be ¡gy 0 kerl, ez a H ‚rt‚k
        ret                             ; K‚sz is vagyok
;
; Egyel kisebbet h¡vok meg, majd megszorzom az eredetivel
;
; K! = (K - 1)! * K
;
nagyfa:
        dec     di                      ; Egyel kisebbet veszek
        call    fakter                  ; Ez kisz m¡tja K-1 faktori list
        inc     di                      ; Ez az eredeti ‚rt‚k
;
; AX DX-ben benne az ‚rt‚k, meg kell szorozni DI-vel
;
        mov     cx,ax                   ; L r‚sz k‚s‹bbre eltesz
        mov     ax,dx                   ; El‹sz”r H r‚szt kell szoroznom
        mul     di                      ; H r‚sz megszorozva
        jc      bajret                  ; Nem f‚rt el az eredm‚ny
        xchg    cx,ax                   ; AX <- L r‚sz, CX <- eredm‚ny
        mul     di                      ; Megszorzom L r‚szt is
        add     dx,cx                   ; H r‚sz ezeknek az ”sszege
bajret:
        ret                             ; K‚sz az eredm‚yn
;
; DX:AX ki¡rat sa decim lisan                              
;
dekoki:
;
; El‹sz”r elosztom 2-vel, majd 50 000-el, azaz
; ”sszesen 100 000-el.
;
        shr     dx,1                    ; A H r‚sz oszt sa 2-vel
        rcr     ax,1                    ; Az L r‚szbe CY bel‚ptet‚ssel
        pushf                           ; A k¡l‚p‹ CY kell majd a marad‚khoz
        mov     bx,50000                ; Ez az oszt¢
        div     bx                      ; DX <- marad‚k, AX <- h nyados
        mov     si,ax                   ; A h nyados m solata
        xor     ax,ax                   ; Null zom
        popf                            ; CY vissza
        rcl     dx,1                    ; CY bel‚ptet‚se a marad‚kba
        shl     ax,1                    ; AX:DX-ben a 100 000-es marad‚k
        xchg    ax,dx                   ; DX:AX-ben a 100 000-es marad‚k
        mov     bx,10                   ; Ez az oszt¢ a tov bbiakban
        xor     cx,cx                   ; CX <- 0, azaz ennyi a sz ml l¢
;
; Elind¡tom az osztogat st
;
        or      dx,dx                   ; Nulla?
        jnz     osztog                  ; Nem, osztani fogok
martoo:
        or      ax,ax                   ; Nulla?
        jz      kezsma                  ; Igen, k‚sz a marad‚k
osztog:
        div     bx                      ; AX <- £j h nyados, DX <- £j marad‚k
        push    dx                      ; Marad‚k ment‚s
        inc     cx                      ; Sz molom a karaktereket
        xor     dx,dx                   ; A H r‚szen nem lehet semmi
        jmp     martoo                  ; Osztogatok tov bb
kezsma:
        or      si,si                   ; A 100 000-es ‚rv‚nyes?
        jz      nemmus                  ; Nem, mehet tov bb
ujhovi:
        cmp     cx,5                    ; ppen 5 a karakterek sz ma?
        jz      megtov                  ; M r k‚sz is
        push    ax                      ; Elteszek 0-t
        inc     cx                      ; N”velem a darabot
        jmp     ujhovi
megtov:
        xchg    ax,si                   ; SI <- 0, AX <- 100 000-es ‚rt‚k
        jmp     martoo                  ; K‚sz is van
nemmus:
        or      cx,cx                   ; Van benne?
        jnz     vanben                  ; Igen, mehet a ki¡rat¢ ciklus
        push    ax                      ; Egy nulla kerlj”n bele
        inc     cx                      ; Mehet ki 1-es benne
vanben:
        mov     ah,2                    ; Ki¡r sk‚r‚s k¢dja
kakici:
        pop     dx                      ; Sz mjegy vissza
        or      dl,'0'                  ; Karakterr‚ alak¡tva
        int     21h                     ; DOS h¡v s a ki¡rat shoz
        loop    kakici                  ; Az ”sszes ki¡rat sa
        ret                             ; K‚szt a ki¡r s


helpsz  db      'Faktori lis sz mit¢.',10,13
        db      'Haszn lata: FAKT ‚rt‚k', 10, 13, '$'
code	ends
	end	start

