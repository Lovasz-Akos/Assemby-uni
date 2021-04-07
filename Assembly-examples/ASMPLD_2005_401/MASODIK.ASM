code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

                                       
start:
        mov     ah,9                    ; Ki¡rat sk‚r‚s k¢dja
        mov     dx,offset szoveg        ; A sz”veg c¡me
        int     21h                     ; A DOS megh¡v sa ki¡r sk‚r‚ssel
        mov     cx,10                   ; Maximum ennyi
ciklus:
        mov     ah,8                    ; Let‚skiv r s, majd beolvas s k¢dja
        int     21h                     ; A DOS megh¡v sa beolvas sra
        cmp     al,27                   ; A let‚s k¢dja ESC volt?
        jz      kilep                   ; Igen, akkor a kil‚p‚s j”n
        cmp     al,'Q'                  ; A let‚s k¢dja Q volt?
        jz      kilep                   ; Igen, akkor a kil‚p‚s j”n
        cmp     al,'q'                  ; A let‚s k¢dja q volt?
        jz      kilep                   ; Igen, akkor a kil‚p‚s j”n
        mov     ah,2                    ; Egy karakter ki¡rat sk‚r‚s k¢dja
        mov     dl,al                   ; Mivel DL-b‹l tudok ki¡rni
        dec     dl                      ; El‹tte l‚v‹ k¢dja
        int     21h                     ; A DOS megh¡v sa karakterki¡rat sra
;
; Mivel sem DL sem AH nem v ltozik, nem kell m‚gegyszer kit”lteni
;
        inc     dl                      ; Ögy az eredeti lett
        int     21h                     ; A DOS megh¡v sa karakterki¡rat sra
        inc     dl                      ; Egyel nagyobb a k”vetkez‹
        int     21h                     ; A DOS megh¡v sa karakterki¡rat sra
        mov     dl,10                   ; Az LF k¢dja
        int     21h                     ; A DOS megh¡v sa karakterki¡rat sra
        mov     dl,13                   ; A CR k¢dja
        int     21h                     ; A DOS megh¡v sa karakterki¡rat sra
        loop    ciklus                  ; Kezdje £jra a ciklust
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'šss”n le billenytyûket, kil‚p‚s ESC-re!', 10,13, '$'
                                              
code	ends
	end	start

