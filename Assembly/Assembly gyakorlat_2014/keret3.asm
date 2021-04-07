code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

keretl  equ     40                      ; A keret hossza karakterben
keretm  equ     (80-keretl) / 2         ; A kezd‹pontig ennyi sz¢k”z

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
; Egy "sornyi" O karakter kit‚tele, majd CR LF
;
sorbao:
        call    elejes                  ; Az elej‚re sz¢k”z
        mov     cx,keretl               ; Ennyi 'O' lesz kit‚ve
        mov     dl,'O'                  ; Ezt tesszk ki
        call    sorbel                  ; Kipakol s ciklusban
        jmp     crlf                    ; CR ‚s LF kit‚tel


eleveo:
        call    elejes                  ; Az elej‚re sz¢k”z
        mov     dl,'O'                  ; Ezt tesszk ki
        int     21h                     ; Kiteszem a karaktert
        mov     cx,keretl - 2           ; Ennyi ' ' lesz kit‚ve
        call    sorbes                  ; Kipakol s ciklusban
        mov     dl,'O'                  ; Ezt tesszk ki
        int     21h                     ; Kiteszem a karaktert
crlf:
        mov     dl,13                   ; CR karakter
        int     21h                     ; Kiteszem a karaktert
        mov     dl,10                   ; LF karakter
        int     21h                     ; Kiteszem a karaktert
        ret                             ; K‚sz a CR ‚s LF

elejes:
        mov     cx,keretm               ; Ennyi ' ' lesz az elej‚re kit‚ve
sorbes:
        mov     dl,' '                  ; Ezt tesszk ki
sorbel:
        int     21h                     ; Kiteszem a karaktert
        loop    sorbel                  ; Kitettem ciklusban t”bbsz”r
        ret                             ; Visszt‚r‚s mert csak ennyi volt


elmozd  db      13, 10, 10, 10, '$'

code	ends
	end	start

