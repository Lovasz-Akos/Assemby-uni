code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

                                       
start:
        mov     ax,3                    ; 80 x 25-”s sz¡nes m¢d k¢dja
        int     10h                     ; VIDEO BIOS h¡v s be ll¡t sra
        mov     cx,vakhos               ; Pontosan ennyi
        mov     si,offset szoveg + vakhos - 1; A sz”veg v‚g‚nek c¡me
        mov     di,offset spater + vakhos - 1; A sz¢k”z”k v‚g‚nek c¡me
sacikl:
        mov     al,[si]                 ; AL <- sz”veg karakter
        mov     [di],al                 ; Kiteszem a sz¢k”z hely‚re
        dec     si                      ; A forr s a k”vetkez‹re
        dec     di                      ; A c‚l terlete is a k”vetkez‹
        mov     ah,9                    ; Ki¡rat sk‚r‚s k¢dja
        mov     dx,offset spater        ; A sz”veg c¡me
        int     21h                     ; A DOS megh¡v sa ki¡r sk‚r‚ssel
        mov     ah,8                    ; Let‚skiv r s, majd beolvas s k¢dja
        int     21h                     ; A DOS megh¡v sa beolvas sra
        loop    sacikl                  ; Kezdje £jra a ciklust
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'VAKµCIà!'
vakhos  equ     $ - szoveg
spater  db      vakhos dup(' '),10,13,'$'

                                              
code	ends
	end	start

