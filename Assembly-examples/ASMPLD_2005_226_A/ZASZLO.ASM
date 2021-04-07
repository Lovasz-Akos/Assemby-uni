code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        cld                             ; String m˚veletek elãrefele menjenek
;
; KÇpernyã Åzemm¢d be†ll°t†s
;
        mov     ax,13h                  ; MCGA Åzemm¢d k¢dja
        int     10h                     ; Az †tkapcsol†s megtÇtele
;
; A h†rom sz°n kialak°t†sa
;
        mov     al,1                    ; Sz°nsz†m (1 = piros)
        mov     bl,63                   ; Maxim†lis piros
        mov     bh,0                    ; Nincs zîld 
        mov     cl,0                    ; Nincs kÇk
        call    szinde                  ; Sz°nbe†ll°t†s (piros)
        mov     al,3                    ; Sz°nsz†m (3 = zîld)
        xchg    bl,bh                   ; Piros-zîld csere
        call    szinde                  ; Sz°nbe†ll°t†s (zîld)
        mov     al,2                    ; Sz°nsz†m (2 = fehÇr)
        mov     bl,bh                   ; BL-be  (piros) 63 (ami a zîld volt)
        mov     cl,bh                   ; CL-be  (kÇk) 63 (ami a zîld volt)
        call    szinde                  ; Sz°nbe†ll°t†s (fehÇr)
;
; A kÇpernyãmem¢ria feltîltÇse
;
        mov     ax,0a000h               ; A grafikus terÅlet szegmense
        mov     es,ax                   ; ES <- MCGA terÅlet szegmensc°me
;
; Pontok feltîltÇse
;
        mov     di,(40 * 320) + 70      ; Itt az elsã pont helye
        mov     si,180                  ; Ennyi hossz£ egy sz°ncs°k
        mov     bp,320 - 180            ; Ennyi a maradÇk a kîvetkezãig
        mov     cx,40                   ; Ennyi egy sz°n hossza
        mov     al,1                    ; Sz°nsz†m = 1, azaz piros
        call    szinki                  ; Megrajzolom a tetejÇt
        mov     al,2                    ; Sz°nsz†m = 2, azaz fehÇr
        call    szinki                  ; Megrajzolom a tetejÇt
        mov     al,3                    ; Sz°nsz†m = 3, azaz zîld
        call    szinki                  ; Megrajzolom a tetejÇt
;
; Kiv†rok egy leÅtÇst
;
        mov     ah,8                    ; NÇma bekÇrÇs k¢dja
        int     21h                     ; DOS h°v†s leÅtÇsv†r†sra
;
; µtdefini†lom az 1-es Çs 3-as sz°nt
;
        mov     al,3                    ; Sz°nsz†m (3 = zîld)
        mov     bl,63                   ; Maxim†lis piros
        mov     bh,0                    ; Nincs zîld 
        mov     cl,0                    ; Nincs kÇk
        call    szinde                  ; Sz°nbe†ll°t†s (piros) (most a 3-as)
        mov     al,1                    ; Sz°nsz†m (1 = piros)
        xchg    bl,bh                   ; Piros-zîld csere
        call    szinde                  ; Sz°nbe†ll°t†s (zîld) (most az 1-es)
;
; KilÇpÇs elãtti leÅtÇsv†r†s
;
        mov     ah,8                    ; NÇma bekÇrÇs k¢dja
        int     21h                     ; DOS h°v†s leÅtÇsv†r†sra
        mov     ax,3                    ; 80x25-îs sz°nes Åzemm¢d k¢dja
        int     10h                     ; Az †tkapcsol†s megtÇtele
	mov	ah,4ch
	int	21h
;
; Sz°ncsik kipakol¢
;
; Input:  DI <- kezdã poz°ci¢
;         SI <- a kitÇtel hossza (pontban)
;         BP <- A kîvetkezã sor t†vols†ga (pontban)
;         CX <- Cs°kszÇlessÇg
;
szinki:
        push    cx                      ; Ennyi egy sz°n hossza, de kell mÇg
szinst:
        push    cx                      ; Elrontom
        mov     cx,si                   ; Egy cs°k hossza
        rep     stosb                   ; Kitettem egy sort
        add     di,bp                   ; R†tÇrek a kîvetkezãre
        pop     cx                      ; Vissza a sz°nszÇlessÇg sz†ml†l¢
        loop    szinst                  ; Ciklusban a sz°n
        pop     cx                      ; Vissza az eredeti sor darabsz†m
        ret                             ; Kivitel kÇsz
;
; Sz°ndefini†l¢
;
; Input:  AL <- sz°nsz†m
;         BL <- R îsszetevã (piros)
;         BH <- G îsszetevã (zîld)
;         CL <- B îsszetevã (kÇk)
;
szinde:
        mov     dx,3c8h                 ; Palettasz°n t†rol¢ c°me
        out     dx,al                   ; Sz°nsz†m elkÅldÇs
        inc     dx                      ; LÇpek a sz°nt†rol¢kra
        mov     al,bl                   ; R sz°nîsszetevã AL-be
        out     dx,al                   ; ôsszetevã elkÅldÇs
        mov     al,bh                   ; G sz°nîsszetevã AL-be
        out     dx,al                   ; ôsszetevã elkÅldÇs
        mov     al,cl                   ; B sz°nîsszetevã AL-be
        out     dx,al                   ; ôsszetevã elkÅldÇs
        ret                             ; KÇsz

code	ends
	end	start








