code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K‚perny‹m¢d be ll¡t s k¢dja
        int     10h                     ; Ögy let”rli (alaphelyztbe hozza)
ujkerd:
        mov     dx,offset atmegy        ; Sz”vegc¡m
        mov     ah,9                    ; Ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
        mov     ah,1                    ; Visszhangos!!! bek‚r‚s k¢dja
        int     21h                     ; DOS h¡v sa let‚sv r sra
        cmp     al,'I'                  ; A let‚s 'I' volt?
        jz      vegcim                  ; Igen, v‚ge a dalnak
        cmp     al,'i'                  ; A let‚s 'i' volt?
        jnz     ujkerd                  ; Nem, £j k‚rd‚s j”n
vegcim:
	mov	ah,4ch
	int	21h

atmegy  db      10,13, 'µtmentem? (I/m s) $'

code	ends
	end	start

