code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s k¢dja
        int     10h                     ; Video BIOS h°v†sa a tîrlÇshez
        mov     dx,offset mianev        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
;
; Beolvasok nevet 5 karakterben
;
        mov     cx,5                    ; Ennyi karakterbãl †ll a nÇv
        mov     bx,offset holnev        ; A t†rol¢ kezdãc°mÇt be†ll°tom
        mov     ah,1                    ; Visszhangos leÅtÇsv†r†s k¢dja
nevbek:
        int     21h                     ; DOS h°v†s viszhangos leÅtÇsv†r†sra
        mov     [bx],al                 ; Kitettem a leÅtîtt karaktert
        inc     bx                      ; Kîvetkezã karakter c°mÇre
        loop    nevbek                  ; A nevet bekÇrã ciklus
;
; NÇvbeolvas†s kÇsz, kezdem a szîveget
;
        mov     dx,offset sziast        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
	mov	ah,4ch
	int	21h

mianev  db      'Hogy h°vnak? $'

sziast  db      13, 10,'Szia '
holnev  db      5 dup(?)
        db      '!', 13, 10, '$'

code	ends
	end	start

