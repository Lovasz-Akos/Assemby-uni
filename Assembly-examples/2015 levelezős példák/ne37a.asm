code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; K‚perny‹t”rl‚shez m¢dv lt s
        int     10h                     ; Video Bios h¡v sa t”rl‚shez
        mov     bl,99                   ; Ezzel kezdek
ujrame:
        mov     al,bl                   ; Ezt dek¢dolom
        mov     ah,0                    ; H r‚szt null zni kell
        mov     cl,10                   ; Ennyivel osztom
        div     cl                      ; AL <- h nyados AH <- marad‚k
        push    ax                      ; Elementem
        mov     dl,al                   ; A h nyados sz m‚rt‚ke
        or      dl,'0'                  ; Karakterr‚ alak¡tom
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        int     21h                     ; Ki¡r s DOS-sal
        pop     ax                      ; Marad‚k vissza
        mov     dl,ah                   ; A marad‚k sz m‚rt‚ke
        or      dl,'0'                  ; Karakterr‚ alak¡tom
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        int     21h                     ; Ki¡r s DOS-sal
        mov     dl,13                   ; CR
        int     21h                     ; Ki¡r s DOS-sal
        mov     dl,10                   ; LF
        int     21h                     ; Ki¡r s DOS-sal
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; DOS-sal v rok
        cmp     al,27                   ; ESC volt?
        jz      kilep                   ; Igen, be is fejezem
        dec     bl                      ; Egyel cs”kkentem
        jnz     ujrame                  ; Vissza a k”vetkez‹re
kilep:
        mov     ah,4ch
        int     21h

kiltxt  db      13,10,'Kil‚pjek? (Igen) $'
               

code	ends
	end	start

