code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h
darpar  db      ?
        db      ?
parbyt  db      125 dup(?)

	org	100h

start:
        cld                             ; LODSB-hez ir ny
        mov     ax,3                    ; M¢dv lt s 3-as m¢dra k¢dja
        int     10h                     ; K‚perny‹t”rl‚s lesz
        mov     cl,[darpar]             ; Ennyi hossz£ a sz”veg
        mov     ch,0                    ; Darabsz m
        jcxz    mohelp                  ; HELP-et ¡rok ki
        dec     cx                      ; A sz¢k”z levonva
        mov     si,offset parbyt        ; Ez a ki¡rand¢ karakterek c¡me
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
kilep:
	mov	ah,4ch
	int	21h
mohelp:
        mov     dx,offset helpsz        ; Sz”vegc¡m
        mov     ah,9                    ; DIOS-ban string ki¡rat s
        int     21h                     ; Kiviszem a sz”veget
        jmp     kilep                   ; V‚ge

crlf    db      10,13,'$'
helpsz  db      'A parancssorban adott sz”veget fgg‹legesen ¡rja ki.$'
code	ends
	end	start

