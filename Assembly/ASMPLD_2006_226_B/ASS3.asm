code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
        cld                             ; LODSB-hez ir ny
        mov     ax,3                    ; M¢dv lt s 3-as m¢dra k¢dja
        int     10h                     ; K‚perny‹t”rl‚s lesz
        mov     cx,szodar               ; Ennyi hossz£ a sz”veg
        mov     si,offset szoveg        ; Ez a ki¡rand¢ karakterek c¡me
kiirci:
        mov     dl,' '                  ; Ezt teszem ki
        mov     ah,2                    ; Karakterki¡rat s k¢dja
        push    cx                      ; Elmentem a sz ml l¢t
        mov     cx,40                   ; Ennyi a fele
spkaci:
        int     21h                     ; DOS h¡v s karakter ki¡r sra
        loop    spkaci                  ; Sz¢k”zki¡rat¢ ciklus
        pop     cx                      ; Vissza az eredeti ciklussz ml l¢
        lodsb                           ; AL <- karakter (SI++!!!!!!)
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

szoveg  db      'ASSEMBLY-PROGRAM'

szodar  equ     $ - szoveg

crlf    db      10,13,'$'

code	ends
	end	start

