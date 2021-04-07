code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K‚perny‹t”rl‚shez m¢dv lt s k¢dja
        int     10h                     ; Video BIOS h¡v sa a t”rl‚shez
        mov     dx,offset szoveg        ; Sz”vegc¡m
        mov     ah,9                    ; String ki¡r s k¢dja
        int     21h                     ; DOS h¡v sa ki¡r sra
ciklus:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; DOS h¡v sa let‚sv r sra
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        cmp     al,27                   ; ppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
;
; Fell‚ptetem az el‹z‹ let‚seket t rol¢ karaktereket,
; azaz a 2.-at a 3.-ra, majd az 1.-t a 2.-ra teszem, a mostanit
; pedig az 1.-re
;
        mov     dl,[elozo + 1]          ; Let‚st r beolvas s (2. karakter)
        mov     [elozo + 2],dl          ; Let‚st r feljebb mozgat s (3.-ra)
        mov     dl,[elozo + 0]          ; Let‚st r beolvas s (1. karakter)
        mov     [elozo + 1],dl          ; Let‚st r feljebb mozgat s (2.-ra)
        mov     [elozo + 0],al          ; Let‚st r kit”lt‚s (1. karakter)
        mov     dl,al                   ; µtteszem a ki¡ratand¢t
        int     21h                     ; DOS h¡v sa ki¡r sra
;
; Ki is ¡rtam, most megvizsg lom, hogy az utols¢ 3 let‚s a k¡v nt volt-e
;
        cmp     [elozo + 0],'c'         ; Az utols¢ 'c' volt?
        jnz     ciklus                  ; Nem, akkor maradok a ciklusban
        cmp     [elozo + 1],'b'         ; Az utols¢ el‹tti 'b' volt?
        jnz     ciklus                  ; Nem, akkor maradok a ciklusban
        cmp     [elozo + 2],'a'         ; Az utols¢ el‹tti el‹tti 'a' volt?
        jnz     ciklus                  ; Nem, akkor maradok a ciklusban
;
; A v‚g‚re CR ‚s LF kit‚tele, hogy eleg nsabban n‚zzen ki. AH m‚g mindig 2!
;
abbaha:
        mov     dl,13                   ; A v‚g‚re CR (hogy szebb legyen)
        int     21h                     ; DOS h¡v sa ki¡r sra
        mov     dl,10                   ; A v‚g‚re LF (hogy szebb legyen)
        int     21h                     ; DOS h¡v sa ki¡r sra
	mov	ah,4ch
	int	21h

szoveg  db      'a, b, c-re vagy  ESC-re v‚ge!',13,10,'$'
;
; T rol¢ az el‹z‹ let‚sekr‹l
;
elozo   db      0,?,?

code	ends
	end	start

