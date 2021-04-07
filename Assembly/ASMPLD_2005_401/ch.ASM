code    segment para    public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        mov     dx,offset szoveg        ; Sz”vegc¡m DX-be
        int     21h                     ; DOS h¡v sa ki¡rat sra
        mov     cx,10                   ; Maximum ennyit
ciklus:
        mov     ah,8                    ; N‚ma bek‚r‚s k¢dja
        int     21h                     ; DOS h¡v s beolvas sra
        cmp     al,27                   ; ESC volt?
        jz      kilepes                 ; Igen, befejezem
        cmp     al,'q'                  ; A let‚s 'q' volt?
        jz      kilepes                 ; Igen, befejezem
        cmp     al,'Q'                  ; A let‚s 'Q' volt?
        jz      kilepes                 ; Igen, befejezem
        mov     dl,al                   ; Most innen ¡rom ki
        mov     ah,2                    ; Egy karakter kit‚tele
        int     21h                     ; DOS mûvelet k‚r‚s
        cmp     dl,'9'                  ; Enn‚l nagyobb?
        mov     dx,offset betszo        ; Sz”vegc¡m
        ja      aksiki                  ; Sim n mehet ki, mert nagyobb
        mov     dx,offset szaszo        ; Sz”vegc¡m
aksiki:
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        int     21h                     ; DOS mûvelet k‚r‚s
        loop    ciklus                  ; Ha maradt m‚g, visszal‚pek
kilepes:
	mov	ah,4ch
	int	21h

szoveg  db      'šss”n le sz mokat, vagy betûket!',10,13,'$'
betszo  db      '-BETë',10,13,'$'
szaszo  db      '-SZµM',10,13,'$'

code	ends
	end	start

