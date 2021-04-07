code    segment para    public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80 x 25-”s zemmd k¢dja
        int     10h                     ; Ez e k‚perny‹t”rl‚s
;
; Az elej‚re ki¡rom a t j‚koztat¢ sz”veget
;
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        mov     dx,offset szoveg        ; A sz”veg c¡me
        int     21h                     ; DOS h¡v s
;
; Elind¡tom a ciklust
;
        mov     cx,10                   ; Ennyit v rok maximum
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
        mov     ah,2                    ; Egy karkter ki¡rat s nak k¢dja
        mov     dl,al                   ; Mivel DL-b‹l ¡r ki
        int     21h                     ; A DOS h¡v sa mûveletre
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        cmp     dl,'9'                  ; Enn‚l kisebb?
        mov     dx,offset szaszo        ; A sz”veg c¡me
        jbe     szomak                  ; Most kisebb vagy egyenl‹
        mov     dx,offset betszo        ; A sz”veg c¡me
szomak:
        int     21h                     ; DOS h¡v s
        loop    ciklus                  ; Kiv rom, ha m‚g lenne

kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'šss”n le billenytyûket!',10,13,'$'
betszo  db      '-betû',10,13,'$'
szaszo  db      '-sz m',10,13,'$'


code	ends
	end	start

