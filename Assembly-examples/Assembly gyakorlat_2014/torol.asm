code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:

        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚s v‚gett k¢d
        int     10h                     ; Video Bios h¡v sa
nemazi:
        mov     dx,offset szoveg        ; A ki¡ratand¢ sz”veg c¡me
        mov     ah,9                    ; A string ki¡rat s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r sra
        mov     cl,al                   ; M solat
        mov     ah,2                    ; Ki¡rat s k¢dja
        cmp     al,27                   ; ppen az ESC let‚se volt?
        jz      kihagy                  ; Ha ‚ppen az volt, akkor befejeztem
        mov     dl,al                   ; Innen ¡rok ki
        int     21h                     ; DOS h¡v sa ki¡rat sra
kihagy:
        mov     dl,13                   ; Innen ¡rom ki a CR-t
        int     21h                     ; DOS h¡v sa ki¡rat sra
        mov     dl,10                   ; Innen ¡rom ki az LF-et
        int     21h                     ; DOS h¡v sa ki¡rat sra
        cmp     cl,27                   ; ppen az ESC let‚se volt?
        jz      kilep                   ; Ha ‚ppen az volt, akkor befejeztem
        cmp     cl,'i'                  ; ppen az 'i' let‚se volt?
        jz      kilep                   ; Ha ‚ppen az volt, akkor befejeztem
        cmp     cl,'I'                  ; ppen az 'I' let‚se volt?
        jnz     nemazi                  ; Nem, akkor vissza a let‚sv r sra
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'Kil‚pjek? Csak "I" let‚se est‚n l‚pek  m ki!  $'

code	ends
	end	start

