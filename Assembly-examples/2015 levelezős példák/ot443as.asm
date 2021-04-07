code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing
                                                   
	org	100h

     
start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; Video Bios h°v†sa tîrlÇshez
        mov     dx,offset kertxt        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
        mov     bx,offset tarolo        ; T†rol¢ c°me
pakaka:
        mov     ah,1                    ; Visszhangos leÅtÇsv†r†s k¢dja
kokabe:
        int     21h                     ; DOS-sal v†rok
        mov     [bx],al                 ; Kitettem a leÅtîttet
        cmp     al,13                   ; Enter volt?
        jz      azvolt                  ; Igen, nem kÇrek tîbbet
        inc     bx                      ; A t†rol¢ kîvetkezã elemÇre lÇpek
        jmp     kokabe                  ; Èjat olvasok be
azvolt:
        cmp     bx,offset tarolo        ; öres sor volt?
        jnz     voltso                  ; Nem, volt valamennyi
        mov     dx,offset hibasz        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
        jmp     pakaka                  ; Èjra v†rom
voltso:
        mov     dx,offset kerkar        ; Szîveg c°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rom DOS-sal
        mov     ah,1                    ; Visszhangos leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS-sal v†rok
        mov     cl,'0'                  ; Kezdã ÇrtÇk
        mov     ch,al                   ; Ezt keresem
        mov     bx,offset tarolo        ; T†rol¢ c°me
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

kertxt  db      'KÇrek egy stinget! (Enter a vÇge.)',13,10, '$'
kerkar  db      13,10,'KÇrek egy karaktert! $'
hibasz  db      'Nem lehet Åres a sor!',13,10,'$'               
talsza  db      13,10,'A tal†latok sz†ma: $'
nincst  db      13,10,'Nincs tal†lat!$'

tarolo  db      100 dup (?)

code	ends
	end	start

