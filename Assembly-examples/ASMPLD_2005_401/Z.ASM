code    segment para    public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

szeles  equ     180                     ; Ennyi a z†szl¢ szÇlessÇge (pont)
vastag  equ     40                      ; Ennyi egy sz°n vastags†ga (sor)

kezdos  equ     (200 - (3 * vastag)) / 2; Ebben a sorban kezd
kezosz  equ     (320 - szeles) / 2      ; Ebben az oszlopban kezd

start:
;
; KÇpernyã Åzemm¢d be†ll°t†s
;
        mov     ax,13h                  ; MCGA Åzemm¢d k¢dja
        int     10h                     ; Az †tkapcsol†s megtÇtele
;
; String m˚veletek ir†nya
;
        cld                             ; String m˚veletek elãrefele menjenek
;
; A kÇpernyãmem¢ria feltîltÇse a z†szl¢val
;
        mov     ax,0a000h               ; A grafikus terÅlet szegmense
        mov     es,ax                   ; ES <- MCGA terÅlet szegmensc°me
        mov     di,(kezdos * 320) + kezosz; Itt az elsã pont helye
;
; AL-ben nulla van Çppen!!!, kihaszn†lom sz°nsz†mnak
;
megszt:
        mov     cl,vastag               ; Ennyi egy sz°n hossza
        inc     ax                      ; A kîvetkezã sz°n
szinst:
        push    cx                      ; Elrontom
        mov     cl,szeles               ; Egy cs°k hossza
        rep     stosb                   ; Kitettem egy sor
        add     di,320 - szeles         ; R†tÇrek a kîvetkezãre
        pop     cx                      ; Vissza a sz°nszÇlessÇg sz†ml†l¢
        loop    szinst                  ; Ciklusban a sz°n
        cmp     al,3                    ; M†r a h†rmassal rajzoltam?
        jnz     megszt                  ; MÇg nem, kiteszem tov†bb
;
; A h†rom sz°n kialak°t†sa Çs v†rakoz†s
;
        mov     bx, 0101111001001110b   ; A tîmîr°tett paletta ÇrtÇkek

szinbe:
        mov     cl,3                    ; 3 palettasz°n be†ll°t†s lesz
        push    cx                      ; Egyben 80x25-îs Åzemm¢d k¢d
szinde:
        mov     dx,3c8h                 ; Palettasz°n t†rol¢ c°me
        mov     al,cl                   ; CL mint a sz°nsz†m
        out     dx,al                   ; Sz°nsz†m elkÅldÇs
        inc     dx                      ; LÇpek a sz°nt†rol¢kra
        push    cx                      ; Az îsszetevãsz†m rontja
        mov     cl,3                    ; RGB az 3 darab
        stc                             ; ÷gy lesz a kilÇpÇskor zîld
rgbval:
        mov     al,0                    ; A sz°nsz†m 0
        rcl     bx,1                    ; Csupacseles RGB sz†mol†s
        jnc     numehe                  ; Ha CY = 0, akkor marad AL 0
        mov     al,63                   ; EgyÇbkÇnt 63
numehe:
        out     dx,al                   ; Sz°nÇrtÇk elkÅldÇs
        loop    rgbval                  ; RGB, azaz mindh†rom sz°n
        pop     cx                      ; Vissza a sz°nsz†m†l¢
        loop    szinde                  ; Tov†bbi sz°n be†ll°t†s
        mov     ah,8                    ; NÇma bekÇrÇs k¢dja
        int     21h                     ; DOS h°v†s leÅtÇsv†r†sra
        pop     ax                      ; Egyben 80x25-îs Åzemm¢d k¢d
        cmp     bh,0fdh                 ; M†r a m†sodszori †llapot?
        jne     szinbe                  ; Ha nem az, akkor mÇg megy
        int     10h                     ; Az †tkapcsol†s megtÇtele
        int     20h                     ; KilÇpÇs

code	ends
	end	start
