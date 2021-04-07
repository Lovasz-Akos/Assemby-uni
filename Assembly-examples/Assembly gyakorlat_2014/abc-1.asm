code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s k¢dja
        int     10h                     ; Video BIOS h°v†sa a tîrlÇshez
        mov     dx,offset szoveg        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
        mov     cx,26                   ; Ennyi bet˚bãl †ll
        mov     dl,'a'                  ; Kezdã karakter
ciklus:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        cmp     al,27                   ; êppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
        inc     dl                      ; A kîvetkezãre
        loop    ciklus                  ; LeÅtÇsv†r†si ciklus
abbaha:
	mov	ah,4ch
	int	21h

szoveg  db      'ESC-vÇge!',13,10,'$'

code	ends
	end	start

