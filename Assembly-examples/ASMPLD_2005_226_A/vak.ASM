code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     cx,hossz                ; Ennyi darab kir s
        mov     bx,offset sz + hossz - 1; Az utols¢ c¡me
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
        loop    teljeh                  ; Ciklusban ¡ratgatok ki
        mov     ah,4ch                  ; A kil‚psk‚r‚s k¢dja
        int     21h                     ; DOS h¡v s kil‚p‚sre

sz      db      'VAKµCIà!'              ; Ide j”n a sz”veg
hossz   equ     $-sz

        db      10,13,'$'

code	ends
	end	start

