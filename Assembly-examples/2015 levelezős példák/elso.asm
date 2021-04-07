code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; K‚perny‹t”rl‚shez m¢dv lt s
        int     10h                     ; Video Bios h¡v sa t”rl‚shez
        mov     dx,offset szervu        ; A sz”veg c¡me
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
        mov     ah,4ch
        int     21h

szervu  db      'Szervusz Jancsi b csi!$'


code	ends
	end	start

