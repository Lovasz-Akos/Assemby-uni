code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     bx,80h                  ; Itt a parancsssor sz ml l¢ja
        mov     cl,[bx]                 ; Sz ml l¢ beolvas s
        mov     ch,0                    ; CX <- sz ml l¢
        jcxz    nulpar                  ; Nincs param‚ter
        add     bx,cx                   ; Az utols¢ c¡me
        dec     cx                      ; A bevezet‹ SPACE nem kell
        jcxz    nulpar                  ; Csak egy sz¢k”z a param‚ter
        mov     byte ptr [bx + 1],'$'   ; Hogy a kii¡r snak legyen v‚ge
teljeh:
        push    cx                      ; Elrontom mindj rt
        dec     cx                      ; Egyel kevesebbet
        jcxz    elfosp                  ; Nincs m r mi kitenni
        mov     dl,' '                  ; Ezt eszem ki
        mov     ah,2                    ; Karakterki¡rat¢ k¢d
spcikl:
        int     21h                     ; DOS-sal sz¢k”z ki¡rat s
        loop    spcikl                  ; A sz¢k”z kitev‹ ciklus
elfosp:
        pop     cx                      ; Eredeti ciklussz m vissza
        mov     dx,bx                   ; DX <- a ki¡ratand¢ c¡me
        mov     ah,9                    ; Sz”vekki¡r s k¢dja
        int     21h                     ; DOS-sal ki¡rt s
        dec     bx                      ; L‚pegetek visszafele
        mov     dl,10                   ; Ezt eszem ki
        mov     ah,2                    ; Karakterki¡rat¢ k¢d
        int     21h                     ; DOS-sal sz¢k”z ki¡rat s
        mov     dl,13                   ; Ezt eszem ki
        int     21h                     ; DOS-sal sz¢k”z ki¡rat s
        loop    teljeh                  ; Ciklusban ¡ratgatok ki
vegeso:
        mov     ah,4ch                  ; A kil‚psk‚r‚s k¢dja
        int     21h                     ; DOS h¡v s kil‚p‚sre
nulpar:
        mov     dx,offset fafeju        ; Sz”vegc¡m
        mov     ah,9                    ; A ki¡rat s k¢dja
        int     21h                     ; DOS a ki¡rat sra
        jmp     vegeso                  ; Kil‚p‚s

fafeju  db      'Nincs megadva param‚ter!$'
        
code	ends
	end	start

