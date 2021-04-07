code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     dx,offset szoveg        ; Szîvegc°m, amit ki kell °rni
        mov     ah,9                    ; Ki°rat†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra
ciklus:
        mov     bl,010b                 ; Ezt teszem ki
        call    ledkit                  ; A LED-ek kitÇtele
        call    idohuz                  ; Idãh£z†s
        mov     bl,000b                 ; Ezt teszem ki
        call    ledkit                  ; A LED-ek kitÇtele
        call    idohuz                  ; Idãh£z†s
        mov     ah,1                    ; Csak kÇrdezÇs k¢dja
        int     16h                     ; Klavi BIOS megsz¢l°t†s
        jz      ciklus                  ; Nincs leÅtve
        mov     ah,0                    ; Beolvas†s k¢dja
        int     16h                     ; Klavi BIOS megsz¢l°t†s
        cmp     al,27                   ; ESC van lenyomva?
        jnz     ciklus                  ; Nem, nem az volt leÅtve
	mov	ah,4ch
	int	21h

ledkit:
        mov     al,0edh                 ; LED megsz¢l°t¢ ÇrtÇk
        out     60h,al                  ; 8042-nek elkÅldÇs
        xor     cx,cx                   ; Null†zom CX-et
ledcik:
        nop                             ; Csak idãh£z†s
        nop                             ; Csak idãh£z†s
        loop    ledcik                  ; Kiv†rok
        mov     al,bl                   ; LED helyzet
        out     60h,al                  ; 8042-nek elkÅldÇs
        ret                             ; KÇsz a LED kipakol†s

idohuz:
        mov     cx,400                  ; Ennyiszer 65536 ciklus
kulcik:
        push    cx                      ; Elmentem, mert mingy†' romlik
        xor     cx,cx                   ; CX <- 0
belido:
        nop                             ; Csak idãh£z†s
        nop                             ; Csak idãh£z†s
        loop    belido                  ; Kiv†rok
        pop     cx                      ; Sz†ml†l¢ vissza
        loop    kulcik
        ret                             ; Idãh£z†s kÇsz


szoveg  db      'KilÇpÇs ESC-re.', 10, 13, '$'

code	ends
	end	start

