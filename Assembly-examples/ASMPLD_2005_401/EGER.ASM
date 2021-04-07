code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        xor     ax,ax                   ; AX <- 0
        int     33h                     ; Eg‚rdriver h¡v sa
        or      ax,ax                   ; Nulla maradt?
        jz      ninege                  ; Igen, nincs eg‚r
        mov     ax,1                    ; Kurzor l that¢v  t‚tel k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
nemvan:
        mov     ax,3                    ; µllapotlek‚rdez‚s k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,000111b              ; Van lenyomva?
        jz      nemvan                  ; Nem, nincs lenyomva
;
; Valamelyik gombot lenyomt k, megv rom, hogy elengedj‚k
;
megvan:
        mov     ax,3                    ; µllapotlek‚rdez‚s k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,000111b              ; Van lenyomva?
        jnz     megvan                  ; Igen, le van nyomva
;
; Mindegyiket elengedt‚k, eltntetem a kurzort, majd kil‚pek
;
        mov     ax,2                    ; Kurzor neml that¢v  t‚tel k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        jmp     kilep                   ; Kil‚p‚sre
;
; Nincs eg‚rdriver ki¡rat sa, majd kil‚p‚s
;
ninege:
        mov     dx,offset nindrv        ; Sz”vegc¡m
        mov     ah,9                    ; Ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
kilep:
	mov	ah,4ch
	int	21h

nindrv  db      'Nincs eg‚rdriver!', 10, 13, '$'

code	ends
	end	start

