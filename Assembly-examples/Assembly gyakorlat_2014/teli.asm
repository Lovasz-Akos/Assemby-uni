code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        mov     dx,offset szoveg        ; A ki¡ratand¢ sz”veg c¡me
        int     21h                     ; A DOS megh¡v sa ki¡rat sra
        mov     ah,2                    ; Karakterki¡rat s k¢dja
        mov     dl,'$'                  ; A ki¡ratand¢ karakter ‚rt‚ke
        int     21h                     ; A DOS megh¡v sa ki¡rat sra

        mov     ah,4ch
	int	21h

szoveg  db      'Szervusz Jancsi b csi!',13,10
        db      'Ma sz‚p napunk van.$'


code	ends
	end	start

