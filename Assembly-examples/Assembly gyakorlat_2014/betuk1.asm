code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s k¢dja
        int     10h                     ; Video BIOS h°v†sa a tîrlÇshez
        mov     dx,offset szoveg        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
        mov     cx,10                   ; Ennyit v†rok maximum
ciklus:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        cmp     al,27                   ; êppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        cmp     al,'Q'                  ; êppen a 'Q' karakter az?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        cmp     al,'q'                  ; êppen a 'q' karakter az?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Ez volt a leÅtÅtt karakter
        inc     dl                      ; Mivel a kîvetkezãt kell ki°rni
        mov     ah,2                    ; A karakter ki°rat†s k¢dja
        int     21h                     ; A DOS h°v†sa karakter ki°rat†sra
        loop    ciklus                  ; LeÅtÇsv†r†si ciklus
abbaha:
	mov	ah,4ch
	int	21h

szoveg  db      'össsÇl le billenty˚ket, ESC, Q, q kilÇpÇs.',13,10,'$'

code	ends
	end	start

