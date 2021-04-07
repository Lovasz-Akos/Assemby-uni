code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

keretl  equ     40                      ; A keret hossza karakterben
keretm  equ     80-keretl               ; Az £jabb poz¡ci¢ig

start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚shez
        int     10h                     ; K‚perny‹t”rl‚s VIDEO BIOS-al
        mov     dx,offset elmozd        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; A string ki¡rat sa DOS-sal
        mov     ah,2                    ; Egy karakter kipakol s k¢dja
        call    sorbao                  ; Egy sor 'O' karakter
        call    eleveo                  ; Elej‚re, v‚g‚re 'O'
        call    eleveo                  ; Elej‚re, v‚g‚re 'O'
        call    eleveo                  ; Elej‚re, v‚g‚re 'O'
        call    sorbao                  ; Egy sor 'O' karakter
	mov	ah,4ch
	int	21h
;
; Egy "sornyi" O karakter kit‚tele, majd sz¢k”z”kkel a k”vetkez‹ poz¡ci¢ra
;
sorbao:
        mov     cx,keretl               ; Ennyi 'O' lesz kit‚ve
        mov     dl,'O'                  ; Ezt tesszk ki
sorbar:
        int     21h                     ; Kiteszem a karaktert
        loop    sorbar                  ; Kitettem ciklusban t”bbsz”r
        mov     cx,keretm               ; Ennyi ' ' lesz kit‚ve
        mov     dl,' '                  ; Ezt tesszk ki
sorbas:
        int     21h                     ; Kiteszem a karaktert
        loop    sorbas                  ; Kitettem ciklusban t”bbsz”r
        ret                             ; K‚sz, ennyi volt, visszat‚rek
;
; Elej‚re, v‚g‚re 'O'
;
eleveo:
        mov     dl,'O'                  ; Ezt tesszk ki
        int     21h                     ; Kiteszem a karaktert
        mov     cx,keretl - 2           ; Ennyi ' ' lesz kit‚ve
        mov     dl,' '                  ; Ezt tesszk ki
sorbes:
        int     21h                     ; Kiteszem a karaktert
        loop    sorbes                  ; Kitettem ciklusban t”bbsz”r
        mov     dl,'O'                  ; Ezt tesszk ki
        int     21h                     ; Kiteszem a karaktert
        mov     cx,keretm               ; Ennyi ' ' lesz kit‚ve
        mov     dl,' '                  ; Ezt tesszk ki
sorbko:
        int     21h                     ; Kiteszem a karaktert
        loop    sorbko                  ; Kitettem ciklusban t”bbsz”r
        ret

elmozd  db      13, 10, 10, 10, '       $'

code	ends
	end	start

