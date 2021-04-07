code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h


start:
        mov     ax,3                    ; M¢dv†lt†s k¢dja kÇpernyãtîrlÇshez
        int     10h                     ; 80x25-îs sz°nes Åzemm¢dra VGA BIOS
        mov     dx,offset hogyhi        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra
        mov     cx,10                   ; Ennyi karakterbãl †ll
        mov     bx,offset abizne        ; A t†rol¢ c°me
ciklus:
        mov     ah,1                    ; Visszahangos leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        mov     [bx],al                 ; Kitettem a karaktert
        cmp     al,13                   ; êppen az enter?
        jz      ellen0                  ; Ellenîrzîm, hogy volt-e leÅtÇs
        inc     bx                      ; LÇpek a kîvetkezãre
        loop    ciklus                  ; Vissza a kîvetkezã leÅtÇsv†r†sra
rendbe:
        mov     dx,offset sziasz        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra
        mov     cx,10                   ; Ennyi karakterbãl †ll
        mov     bx,offset abizne        ; A t†rol¢ c°me
        mov     ah,2                    ; Karakterki°rat†s k¢dja
kiirat:
        mov     dl,[bx]                 ; Kitettem a karaktert
        cmp     dl,13                   ; êppen az enter?
        jz      befaki                  ; Igen, akkor nincs tov†bb
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        inc     bx                      ; LÇpek a kîvetkezãre
        loop    kiirat                  ; Vissza a kîvetkezã ki°rat†sra
befaki:
        mov     dl,'!'                  ; Karakter a vÇgÇre
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
kilep:
        mov     ah,4ch
        int     21h
ellen0:
        cmp     cx,10                   ; Volt egy†ltal†n leÅtÇs?
        jnz     rendbe                  ; Igen, akkor folytatom
        mov     dx,offset hibasz        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra
        jmp     kilep                   ; Itt be is fejezem

hogyhi  db      'Hogy h°vnak? $'
                 
hibasz  db      'AzÇ'' csak tudod, hogy hogy h°vnak!$'

sziasz  db      13,10,'Szia, $'

abizne  db      10 dup(?)

code	ends
	end	start

