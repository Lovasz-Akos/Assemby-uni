code    segment para    public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80 x 25-”s zemmd k¢dja
        int     10h                     ; Ez e k‚perny‹t”rl‚s
;
; Az elej‚re ki¡rom a tj‚koztat¢ sz”veget
;
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        mov     dx,offset szoveg        ; A sz”veg c¡me
        int     21h                     ; DOS h¡v s
;
; Elind¡tom a ciklust
;
        mov     cx,10                   ; Ennyit v rok maximu
;
; Ez a 10-es v r¢ ciklus
;
ciklus:
        mov     ah,8                    ; N‚ma bek‚r‚s k¢dja
        int     21h                     ; DOS h¡v s karkter bek‚r‚sre
        cmp     al,'q'                  ; A let‚s 'q' volt?
        jz      kilep                   ; Igen, ki is l‚pek
        cmp     al,'Q'                  ; A let‚s 'Q' volt?
        jz      kilep                   ; Igen, ki is l‚pek
        cmp     al,27                   ; A let‚s ESC volt?
        jz      kilep                   ; Igen, ki is l‚pek
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        mov     dx,offset egyszo        ; A sz”veg c¡me
        cmp     al,'1'                  ; A let‚s '1' volt?
        jz      szovva                  ; Igen, ki is ¡rom
        mov     dx,offset ketszo        ; A sz”veg c¡me
        cmp     al,'2'                  ; A let‚s '2' volt?
        jz      szovva                  ; Igen, ki is ¡rom
        mov     dx,offset harszo        ; A sz”veg c¡me
        cmp     al,'3'                  ; A let‚s '3' volt?
        jz      szovva                  ; Igen, ki is ¡rom
        mov     ah,2                    ; Egy karkter ki¡rat s nak k¢dja
        mov     dl,al                   ; Mivel DL-b‹l ¡r ki
szovva:
        int     21h                     ; A DOS h¡v sa mûveletre
        loop    ciklus                  ; Kiv rom, ha m‚g lenne
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'šss”n le billenytyûket!',10,13,'$'
egyszo  db      'egy$'
ketszo  db      'kett‹$'
harszo  db      'h rom$'


code	ends
	end	start

