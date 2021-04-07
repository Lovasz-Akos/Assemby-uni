code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

darabs  db      ?
        db      ?
parsor  db      126 dup(?)

	org	100h

     
start:
        mov     ax,13h                  ; 320x200-as grafika
        int     10h                     ; VIDEO BIOS-sal tîrlÇs
        mov     ax,0a000h               ; Ebben a szegmensben van
        mov     es,ax                   ; ES a grafik†ra mutat
        mov     di,(320 * 40) + 60      ; Itt kezdek
        mov     al,1                    ; 1-es sz°n
        call    csik                    ; Cs°kot rajzolok
        mov     al,2                    ; 2-es sz°n
        call    csik                    ; Cs°kot rajzolok
        mov     al,3                    ; 3-as sz°n
        call    csik                    ; Cs°kot rajzolok
        mov     dx,3c8h                 ; Sz°nsz†m regiszter c°me
        mov     al,0                    ; H†ttÇr sz°n sz†m
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,0                    ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,63                   ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre

        mov     al,1                    ; Sz°n sz†m
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,63                   ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre
        mov     al,2                    ; Sz°n sz†m
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,63                   ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,63                   ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,63                   ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre
        mov     al,3                    ; Sz°n sz†m
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,0                    ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,63                   ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; V†rok DOS-sal

        mov     al,3                    ; Sz°n sz†m
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,63                   ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre
        mov     al,1                    ; Sz°n sz†m
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,0                    ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,63                   ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre
        mov     al,0                    ; Sz°n sz†m (h†ttÇr)
        out     dx,al                   ; KikÅldtem
        inc     dx                      ; A sz°nîsszetevãk c°me
        mov     al,0                    ; R îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; G îsszetevã
        out     dx,al                   ; KikÅldtem
        mov     al,0                    ; B îsszetevã
        out     dx,al                   ; KikÅldtem
        dec     dx                      ; Vissza a sz°nsz†m regiszterre
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; V†rok DOS-sal
        mov     ax,3                    ; TîrlÇshez k¢d
        int     10h                     ; VIDEO BIOS-sal tîrlÇs
        mov     ah,4ch
        int     21h
csik:
        mov     cx,30                   ; Ennyi sor
huz:
        push    cx                      ; El fogom rontani
        mov     cx,200                  ; Ennyi hossz£
        rep     stosb                   ; Kiteszem a cs°kot
        add     di,120                  ; A sor elejÇre      
        pop     cx                      ; Vissza
        loop    huz                     ; Tîbbszîr
        ret                             ; kÇsz

egysem  db      'Egyik sem',13,'$'
balgom  db      'Bal gomb ',13,'$'
jobgom  db      'Jobb gomb',13,'$'
mindke  db      'Mindkettã',13,'$'

code	ends
	end	start

