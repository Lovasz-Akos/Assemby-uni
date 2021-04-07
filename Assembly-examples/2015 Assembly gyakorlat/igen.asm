code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:  
        mov     ax,3                    ; M¢dbe ll¡t ssal k‚perny‹t”rl‚s k¢d
        int     10h                     ; Let”rl”m a k‚perny‹t
kerdis:
        mov     dx,offset kilker        ; A sz”veg c¡me
        mov     ah,9                    ; String ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
        mov     ah,1                    ; Visszhangos beolvas s k¢dja
        int     21h                     ; DOS beolvas sk‚r‚s
        cmp     al,'I'                  ; ppen az 'I' a v lasz?
        jz      vege                    ; Igen, akkor kil‚pek
        cmp     al,'i'                  ; ppen az 'i' a v lasz?
        jz      vege                    ; Igen, akkor kil‚pek
        mov     dx,offset crlf          ; A sz”veg c¡me
        mov     ah,9                    ; String ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
        jmp     kerdis                  ; Vissza £j k‚rd‚z‚sre
vege:
	mov	ah,4ch
        int     21h


kilker  db      'Kil‚pjek? $'

crlf    db      13,10,'$'

code	ends
	end	start

