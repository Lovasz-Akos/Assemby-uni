

code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; M¢dv lt s k¢dja k‚perny‹t”rl‚shez
        int     10h                     ; VIDEO BIOS h¡v sa t”rl‚shez
        mov     cx,hossza               ; A ciklus darabsz ma
        mov     si,offset szoveg        ; A sz”veg kezd‹c¡me
fugcik:
        mov     dx,offset spacek        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; Sz”vegki¡r s DOS-sal
        mov     ah,2                    ; Karakterki¡rat s k¢dja
        mov     dl,[si]                 ; Ezt kell ki¡rni
        int     21h                     ; Karakterki¡rat s DOS-sal
        mov     dl,13                   ; Ezt kell ki¡rni (CR)
        int     21h                     ; Karakterki¡rat s DOS-sal
        mov     dl,10                   ; Ezt kell ki¡rni (LF)
        int     21h                     ; Karakterki¡rat s DOS-sal
        inc     si                      ; L‚pek a pointerrel
        loop    fugcik                  ; Ki¡rat¢ ciklus
        mov     ah,4ch   
        int     21h

szoveg  db      'Assembly-progi'
hossza  equ     $ - szoveg
spacek  db      '                               $'
code	ends
	end	start

