code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h


start:
        mov     ax,3                    ; M¢dv†lt†s k¢dja kÇpernyãtîrlÇshez
        int     10h                     ; 80x25-îs sz°nes Åzemm¢dra VGA BIOS
        mov     dx,offset hogyhi        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra
        mov     cx,5                    ; Ennyi karakterbãl †ll
        mov     bx,offset abizne        ; A t†rol¢ c°me
ciklus:
        mov     ah,1                    ; Visszahangos leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        mov     [bx],al                 ; Kitettem a karakter
        inc     bx                      ; LÇpek a kîvetkezãre
        loop    ciklus                  ; Vissza a kîvetkezã leÅtÇsv†r†sra

        mov     dx,offset sziasz        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra

        mov     ah,4ch
        int     21h               

hogyhi  db      'Hogy h°vnak? $'

sziasz  db      13,10,'Szia, '

abizne  db      5 dup(?)

        db      '!$'

code	ends
	end	start

