code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

darabs  db      ?
        db      ?
parsor  db      126 dup(?)

	org	100h

     
start:
        cmp     [darabs],0              ; Van valamennyi?
        jnz     voltso                  ; Igen, van
        mov     dx,offset hibasz        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
        jmp     endaka                  ; KilÇpek
voltso:
        mov     dx,offset kerkar        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
        mov     ah,1                    ; Visszhangos leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS-sal v†rok
        mov     cl,'0'                  ; Kezdã ÇrtÇk
        mov     ch,al                   ; Ezt keresem
        mov     bx,offset parsor        ; T†rol¢ c°me
talszv:
        cmp     [bx],ch                 ; Ez volt az?
        jnz     masvol                  ; Nem, m†s volt
        inc     cl                      ; Az volt, sz†ml†lok
masvol:
        inc     bx                      ; Kîvetkezã
        cmp     byte ptr [bx],13        ; CR volt?
        jnz     talszv                  ; Nem, tov†bb vizsg†lok
        cmp     cl,'0'                  ; Volt valamennyi?
        jz      egysem                  ; Nem volt tal†lat
        mov     dx,offset talsza        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
        mov     ah,2                    ; Egy karakter ki°r†s k¢dja
        mov     dl,cl                   ; Ez jîn ut†na
        int     21h                     ; Ki°rom DOS-sal
        jmp     endaka                  ; Most vÇge
egysem:
        mov     dx,offset nincst        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
endaka:
        mov     ah,4ch
        int     21h

kerkar  db      13,10,'KÇrek egy karaktert! $'
hibasz  db      'Nem lehet Åres a parancs paramÇtere!',13,10,'$'               
talsza  db      13,10,'A tal†latok sz†ma: $'
nincst  db      13,10,'Nincs tal†lat!$'

code	ends
	end	start

