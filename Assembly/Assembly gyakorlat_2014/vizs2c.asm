code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
        mov     ax,3                    ; K‚perny”t”rl‚s m¢dbe ll¡t ssal k¢d
        int     10h                     ; Video BIOS h¡v sa a t”rl‚shez
        mov     ah,9                    ; String ki¡rat s k¢dja
        mov     dx,offset teendo        ; A sz”veg c¡me
        int     21h                     ; DOS-sal ki¡ratom a stringet
        xor     bx,bx                   ; Kezd‹‚rt‚k (0)
karcik:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r sra
        cmp     al,27                   ; Az ESC volt az?
        jz      kilep                   ; Igen, akkor befejeztem
        cmp     al,' '                  ; A sz¢k”z j”tt ‚ppen?
        jnz     nemaci                  ; Nem, akkor kikerl”m a ford¡t st
        inc     bx                      ; Megford¡tom a legals¢ bitet
;
; Megvizsg lom BX legals¢ bitj‚t
;
nemaci:
        test    bx,1                    ; A legals¢ bitet vizsg lom     
        jnz     karcik                  ; A legals¢ bit 1

        mov     ah,2                    ; Karakterki¡rat s k¢dja
        mov     dl,al                   ; Ez a karaktert kell ki¡rni
        int     21h                     ; DOS h¡v sa karakterki¡rat sra

        jmp     karcik                  ; Vissza a let‚sv r sra
kilep:
	mov	ah,4ch
	int	21h

teendo  db      'šss‚l le billentyûket. Sz¢k”zre felfggeszt. Kil‚p‚s ESC-re.', 13, 10, '$'

code	ends
	end	start

