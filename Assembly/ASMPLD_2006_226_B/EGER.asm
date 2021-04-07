code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; Hogy az Åzemm¢d ilyen legyen...
        int     10h                     ; Be†ll°tom
        mov     ax,0b800h               ; Ez a szegmens ÇrtÇke
        mov     es,ax                   ; ES <- B800 tîltÇs
        cld                             ; Nîvekvã c°mes stringm˚veletek
        xor     ax,ax                   ; AX <- 0
        int     33h                     ; Van egÇrdriver?
        or      ax,ax                   ; Nulla maradt?
        jz      egerni                  ; Nincs egÇrdriver
;
; Bekapcsolom az egÇrkurzort
;
        mov     ax,1                    ; EgÇr l†that¢v† tÇtel k¢dja
        int     33h                     ; EgÇrdriver megh°v†sa
;
; Szîveg kîzÇpre
;
        mov     dx,offset balfel        ; Bal felsã sor ki°rat†s
        call    sorkii                  ; Kiteszem a kîzepÇre
;
; V†rok egÇrleÅtÇsre, majd a poz°ci¢t kiÇrtÇkelem
;
nemnul:
        call    egerny                  ; EgÇrlenyom†s vizsg†lata
        or      cx,dx                   ; X = Y = 0 helyen nyomta?
        jnz     nemnul                  ; Nem, ismÇtlek
;
; Szîveg kîzÇpre
;
        mov     dx,offset jobfel        ; Jobb felsã sor ki°rat†s
        call    sorkii                  ; Kiteszem a kîzepÇre
;
; V†rok egÇrleÅtÇsre, majd a poz°ci¢t kiÇrtÇkelem
;
nemjof:
        call    egerny                  ; EgÇrlenyom†s vizsg†lata
        or      dx,dx                   ; Y = 0 helyen nyomta?
        jnz     nemjof                  ; Nem, ismÇtlek
        cmp     cx,79 * 8               ; X = 79 helyen nyomta?
        jnz     nemjof                  ; Nem, ismÇtlek
;
; Szîveg kîzÇpre
;
        mov     dx,offset jobals        ; Jobb als¢ sor ki°rat†s
        call    sorkii                  ; Kiteszem a kîzepÇre
;
; V†rok egÇrleÅtÇsre, majd a poz°ci¢t kiÇrtÇkelem
;
nemjoa:
        call    egerny                  ; EgÇrlenyom†s vizsg†lata
        cmp     dx,24 * 8               ; Y = 24 helyen nyomta?
        jnz     nemjoa                  ; Nem, ismÇtlek
        cmp     cx,79 * 8               ; X = 79 helyen nyomta?
        jnz     nemjoa                  ; Nem, ismÇtlek
;
; Szîveg kîzÇpre
;
        mov     dx,offset balals        ; Bal als¢ sor ki°rat†s
        call    sorkii                  ; Kiteszem a kîzepÇre
;
; V†rok egÇrleÅtÇsre, majd a poz°ci¢t kiÇrtÇkelem
;
nembaa:
        call    egerny                  ; EgÇrlenyom†s vizsg†lata
        cmp     dx,24 * 8               ; Y = 24 helyen nyomta?
        jnz     nembaa                  ; Nem, ismÇtlek
        or      cx,cx                   ; X = 0 helyen nyomta?
        jnz     nembaa                  ; Nem, ismÇtlek
;
; A vÇgeÇn ki kell kapcsolni
;

        mov     ax,2                    ; EgÇr neml†that¢v† tÇtel k¢dja
        int     33h                     ; EgÇrdriver megh°v†sa

befprg:
	mov	ah,4ch
	int	21h
egerni:
        mov     ah,9                    ; Szîvegki°rat†s k¢dja
        mov     dx,offset nindri        ; Szîvegc°m
        int     21h                     ; Ki°ratom
        jmp     befprg                  ; Befejezem a programot


;
; EgÇrleÅtÇst kiv†r¢ rutin
;
egerny:
        mov     ax,3                    ; EgÇrkurzor poz°ci¢ lekÇrdezÇs k¢dja
        int     33h                     ; EgÇrdriver megh°v†sa
        test    bx,0000000000000001b    ; Volt bal gomb?
        jz      egerny                  ; Nem, v†rok r†
;
; M†r leÅtîttek, v†rok az elengedÇsre
;
megnyo:
        mov     ax,3                    ; EgÇrkurzor poz°ci¢ lekÇrdezÇs k¢dja
        int     33h                     ; EgÇrdriver megh°v†sa
        test    bx,0000000000000001b    ; Van bal gomb?
        jnz     megnyo                  ; Igen, mÇg nem engedte el
;
; VisszatÇrÇs elãtt hossz ÇrtÇkek maszkol†sa
;
        and     cx,0fff8h               ; Hogy 8-al oszthat¢ legyen az X
        and     dx,0fff8h               ; Hogy 8-al oszthat¢ legyen az Y
        ret                             ; KÇsz
;
; Ki°rat¢ rutin
;
sorkii:
        mov     ax,2                    ; EgÇr neml†that¢v† tÇtel k¢dja
        int     33h                     ; EgÇrdriver megh°v†sa
        mov     di,offset 80 * 12 * 2   ; Itt fogok tîrîlni
        mov     cx,80                   ; Ennyi a hossza a sornak
        mov     ax,es:[di]              ; AH <- sz°nk¢d
        mov     al,' '                  ; Ezzel fogok az elãzãt tîrîlni
        rep     stosw                   ; IsmÇtelt sz¢kîz kitÇtel
        mov     si,dx                   ; Ez a c°m
        lodsb                           ; AL <- hossz b†jt
        mov     ah,0                    ; AX <- hossz ÇrtÇke
        mov     cx,ax                   ; A hosszr¢l m†solat
        neg     ax                      ; AX negat°v legyen
        add     ax,80                   ; AX <- (80 - hossz)
;
; Logikailag lehetne AND AX,0FFFEH m˚velet is!!!!
;
        shr     ax,1                    ; A fele kell csak (°gy kîzÇpre megy)
        shl     ax,1                    ; Dupla a hossza
        add     ax,80 * 12 * 2          ; A sor elejÇre tolom
        mov     di,ax                   ; Ide teszem ki
kamaci:
        lodsb                           ; Beolvastam a programb¢l
        stosb                           ; Kitettem a kÇpernyãre
        inc     di                      ; Sz°nrÇsz †tlÇpÇs
        loop    kamaci                  ; Kim†solom a karaktereket
        mov     ax,1                    ; EgÇr l†that¢v† tÇtel k¢dja
        int     33h                     ; EgÇrdriver megh°v†sa
        ret                             ; KÇsz a karaktersor kitÇtele

balfel  db      balveg - $ - 1          ; Ennyi a szîveg hossza
        db      'Kattints a bal felsã sarokba!'
balveg  equ     $

jobfel  db      jobveg - $ - 1          ; Ennyi a szîveg hossza
        db      'Kattints a jobb felsã sarokba!'
jobveg  equ     $

jobals  db      jobave - $ - 1          ; Ennyi a szîveg hossza
        db      'Kattints a jobb als¢ sarokba!'
jobave  equ     $

balals  db      balave - $ - 1          ; Ennyi a szîveg hossza
        db      'Kattints a bal als¢ sarokba!'
balave  equ     $


nindri  db      'Nincs egÇrdriver!$'

code	ends
	end	start

