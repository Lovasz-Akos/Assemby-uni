code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        xor     ax,ax                   ; AX <- 0
        int     33h                     ; Eg‚rdriver h¡v sa
        or      ax,ax                   ; Van eg‚rdriver?
        jz      nindrv                  ; Nincs eg‚rdriver
        mov     ax,1                    ; AX <- eg‚rpointer megjelen¡‚s
        int     33h                     ; Eg‚rdriver h¡v sa
;
;V runk egy eg‚rgomb lenyom s ra
;
ninmel:
        mov     ax,3                    ; AX <- eg‚r  lapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,011b                 ; Valamelyik lenyomva
        jz      ninmel                  ; M‚g egyik sincs lenyova
;
; Megv rom m¡g elengedi
;
megvan:
        mov     ax,3                    ; AX <- eg‚r  lapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,011b                 ; Valamelyik lenyomva
        jnz     megvan                  ; M‚g egyik sincs lenyova
;
; Elengedt‚k, kil‚pek
;
        mov     ax,2                    ; AX <- eg‚rpointer kikapcsol s
        int     33h                     ; Eg‚rdriver h¡v sa
        jmp     csakil                  ; Sim n kil‚pek
nindrv:
        mov     dx,offset ninszo        ; Sz”vegc¡m
        mov     ah,9                    ; DOS ki¡rat s k¢dja
        int     21h                     ; DOS h¡v s ki¡r sra
csakil:
	mov	ah,4ch
	int	21h

ninszo  db      'Nincs eg‚rdiver!', 10, 13, '$'

code	ends
	end	start

