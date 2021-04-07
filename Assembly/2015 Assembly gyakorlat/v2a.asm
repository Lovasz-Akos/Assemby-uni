code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

       
start:  
        mov     ax,3                    ; M¢dbe ll¡t ssal k‚perny‹t”rl‚s k¢d
        int     10h                     ; Let”rl”m a k‚perny‹t
        mov     dx,offset kilker        ; A sz”veg c¡me
        mov     ah,9                    ; String ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
        mov     bx,1                    ; Ezzel az ‚rt‚kkel kezd
ujraka:
        mov     ah,8                    ; N‚ma beolvas s k¢dja
        int     21h                     ; DOS beolvas sk‚r‚s
        cmp     al,27                   ; ppen az ESC a v lasz?
        jz      vege                    ; Igen, akkor kil‚pek
        mov     dl,al                   ; Beleteszem ki¡ratni
        test    bx,1                    ; P ratlan?
        jz      kiikih                  ; Nem ¡rom ki
        mov     ah,2                    ; Egy karakter ki¡rat sa
        int     21h                     ; DOS h¡v sa ki¡rat sra
kiikih:
        cmp     dl,' '                  ; ppen a sz¢k”z volt?
        jnz     ujraka                  ; Megyek tov bb
        inc     bx                      ; A k”vetkez‹ menetben egyel t”bbsz”r
        jmp     ujraka                  ; Vissza £j k‚rd‚z‚sre
vege:                 
	mov	ah,4ch
        int     21h


kilker  db      'šss le billentyûket! Kil‚p‚s ESC-re.',13,10,'$'

code	ends
	end	start

