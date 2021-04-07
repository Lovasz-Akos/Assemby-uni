code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80x25-”s k‚perny‹ k¢dja
        int     10h                     ; Video Bios h¡v sa t”rl‚shez
nemazi:
        mov     ah,9                    ; String ki¡rat s k¢dja
        mov     dx,offset szoveg        ; A ki¡ratand¢ sz”veg c¡me
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; Let‚sv r s k‚r‚se a DOS-t¢l
        mov     dl,al                   ; Innen fogja k¡rni
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        cmp     al,'I'                  ; ppan az 'I' betû az?
        jz      kilep                   ; ppen az volt, akkor megyek is
        cmp     al,'i'                  ; ppan az 'I' betû az?
        jnz     nemazi                  ; Nem az volt, visszamegyek kiv rni
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'Most ‚ppen let‚sre v rok. "I"-re kil‚pek.', 13, 10, '$'

code	ends
	end	start

