code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; Video Bios h°v†sa tîrlÇshez
        mov     bx,'99'                 ; Ezzel kezdek
ujrame:
        cmp     bx,'00'                 ; Ez az?
        jz      kilep                   ; Igen, vÇge
        mov     dl,bh                   ; A h†nyados sz†mÇrtÇke
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        int     21h                     ; Ki°r†s DOS-sal
        mov     dl,bl                   ; A maradÇk sz†mÇrtÇke
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        int     21h                     ; Ki°r†s DOS-sal
        mov     dl,13                   ; CR
        int     21h                     ; Ki°r†s DOS-sal
        mov     dl,10                   ; LF
        int     21h                     ; Ki°r†s DOS-sal
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS-sal v†rok
        cmp     al,27                   ; ESC volt?
        jz      kilep                   ; Igen, be is fejezem
        dec     bl                      ; Egyel csîkkentem
        cmp     bl,'0'                  ; EnnÇl kisebb lett?
        jae     ujrame                  ; Nem, megyek tov†bb
        mov     bl,'9'                  ; Èj kezdet
        dec     bh                      ; H rÇsz is csîkken
        cmp     bh,'0'                  ; EnnÇl kisebb lett?
        jae     ujrame                  ; Nem, megyek tov†bb
kilep:
        mov     ah,4ch
        int     21h

kiltxt  db      13,10,'KilÇpjek? (Igen) $'
               

code	ends
	end	start

