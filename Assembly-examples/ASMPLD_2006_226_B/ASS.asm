code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
        mov     ax,3                    ; M¢dv lt s 3-as m¢dra k¢dja
        int     10h                     ; K‚perny‹t”rl‚s lesz
        mov     cx,8                    ; Ennyi hossz£ a sz”veg
        mov     si,offset szoveg        ; Ez a ki¡rand¢ karakterek c¡me
kiirci:
        mov     dx,offset spszov        ; A beljebb tol s sz¢k”zeinek c¡me
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; DOS h¡v s string ki¡r sa
        lodsb                           ; AL <- karakter
        mov     dl,al                   ; Ez ¡ratom ki
        mov     ah,2                    ; Karakterki¡rat s k¢dja
        int     21h                     ; A DOS-sal 1 karater ki¡rat sa
        mov     dx,offset crlf          ; A k”vetkez‹ sorba tol s c¡me
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; DOS h¡v s string ki¡r sa
        mov     ah,8                    ; N‚ma bek‚r‚s k¢dja
        int     21h                     ; DOS h¡v sa beolvas sra

        loop    kiirci                  ; A ki¡rat s ciklusa
	mov	ah,4ch
	int	21h

szoveg  db      'ASSEMBLY'
spszov  db      '       $'
crlf    db      10,13,'$'














code	ends
	end	start

