code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
;
; Be ll¡tom a kezd‹ karaktert
;
        mov     bl,'0'                  ; Ez a kezdet L r‚sz
        mov     bh,'0'                  ; Ez a kezdet H r‚sz
;
; Karakter ki¡rat s, majd v r s ciklusban
;
kaciki:
        mov     ah,2                    ; A ki¡r sk‚r‚s k¢dja
        cmp     bh,'0'                  ; H r‚sz nulla?
        jz      hrenek                  ; Igen, nem ¡rom ki
        mov     dl,bh                   ; M solatban, mert innen ¡rok ki (H)
        int     21h                     ; Kiteszem a k‚perny‹re
hrenek:
        mov     dl,bl                   ; M solatban, mert innen ¡rok ki (L)
        int     21h                     ; Kiteszem a k‚perny‹re
        mov     dl,10                   ; LF lesz a k”vetkez‹
        int     21h                     ; Kiteszem a k‚perny‹re
        mov     dl,13                   ; CR lesz a k”vetkez‹
        int     21h                     ; Kiteszem a k‚perny‹re
;
; DOS-os n‚ma let‚sk‚r‚s
;
        mov     ah,8                    ; "N‚ma" bek‚r‚s k¢dja
        int     21h                     ; DOS h¡vs beolvas sra
        inc     bl                      ; BL n”vel‚se
        cmp     bl,'9'                  ; Nagyobb lett mint a 9-es karakter?
        jbe     kaciki                  ; M‚g kisebb, vagy ‚ppen a 9-es
        mov     bl,'0'                  ; L r‚sz £jra 0 karakter
        inc     bh                      ; H r‚sz n”vel‚se
        cmp     bh,'9'                  ; Nagyobb lett mint a 9-es karakter?
        jbe     kaciki                  ; M‚g kisebb, vagy ‚ppen a 9-es

;
; A kil‚p‚s k‚r‚se a DOS-t¢l
;
	mov	ah,4ch
	int	21h

code	ends
	end	start

