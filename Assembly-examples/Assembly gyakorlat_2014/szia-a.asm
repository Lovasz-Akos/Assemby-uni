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
        mov     bx,offset nevtar        ; A karakterek c°me
        mov     ah,1                    ; Viszhangos leÅtÇsv†r†s k¢dja
nevbek:
        int     21h                     ; DOS h°v†sa beolvas†sra
        mov     [bx],al                 ; Az adott c°mre kiteszem
        inc     bx                      ; A kîvetkezãre lÇpek
        loop    nevbek                  ; A nevet bekÇrã ciklus
;
; NÇvbeolvas†s kÇsz, kezdem a szîveget
;
        mov     dx,offset sziast        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
;
; Megy ki a beolvasott nÇv ut†na
;
        mov     cx,5                    ; Ennyi karakterbãl †ll a nÇv
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        mov     bx,offset nevtar        ; A karakterek c°me
nevkit:
        mov     dl,[bx]                 ; Karekter beolvas†s
        int     21h                     ; DOS h°v†sa katrakter ki°r†sra
        inc     bx                      ; LÇpek a kîvetkezãre
        loop    nevkit                  ; A nevet bekÇrã ciklus
;
; NÇvkivitel kÇsz, lez†r¢ szîveg kikÅldÇs
;
        mov     dx,offset sziave        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
	mov	ah,4ch
	int	21h

mianev  db      'Hogy h°vnak? $'

sziast  db      13, 10,'Szia $'

sziave  db      '!', 13, 10, '$'

nevtar  db      5 dup(?)

















code	ends
	end	start

