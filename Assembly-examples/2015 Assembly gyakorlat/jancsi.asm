code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing
     
	org	100h


start:
        mov     dx,offset janszo        ; A ki¡ratand¢ sz”veg c¡me
        mov     ah,9                    ; A sz”vegki¡rat s k‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     ah,2                    ; Egy karakter ki¡rat sk‚r‚s k¢dja
        mov     dl,'$'                  ; Ez a ki¡ratand¢ karakter
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     dl,'?'                  ; Ez a ki¡ratand¢ karakter
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     dl,13                   ; Ez a ki¡ratand¢ karakter
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     dl,10                   ; Ez a ki¡ratand¢ karakter
        int     21h                     ; A DOS h¡v sa ki¡rat s v‚gett
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r s v‚gett
	mov	ah,4ch
        int     21h

janszo  db      'Szervusz Jancsi bacsi!',13,10
        db      'R‚gen l ttalak!',13,10
        db      'Kell-e neked $'


code	ends
	end	start

