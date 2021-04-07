code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; M¢dv†lt†s a VIDEO BIOS seg°tsÇgÇvel
        mov     dx,offset mitcsi        ; Szîvegc°m
        mov     ah,9                    ; String ki°rat†s k¢dja
        int     21h                     ; A DOS h°v†sa ki°rat†sra
        mov     cx,10                   ; Ennyi a ciklussz†m
ciklus:
        mov     ah,8                    ; NÇma leÅtÇsvr†s k¢dja
        int     21h                     ; DOS-sal beolvas†s
        cmp     al,27                   ; Az ESC az?
        jz      kilep                   ; Igen, akkor abba-fejezem
        cmp     al,'Q'                  ; A 'Q' az?
        jz      kilep                   ; Igen, akkor abba-fejezem
        cmp     al,'q'                  ; A 'q' az?
        jz      kilep                   ; Igen, akkor abba-fejezem
        cmp     al,'9'                  ; EnnÇl nagyobb?
        ja      ciklus                  ; Igen, akkor nem °rok ki semmit
        mov     dl,al                   ; Karakter a ki°rat†s helyÇre
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        int     21h                     ; Ki°rat†s a DOS-al
        loop    ciklus                  ; Vissza ciklusban
kilep:
	mov	ah,4ch
	int	21h

mitcsi  db      'öss sz†mokat Çs bet˚ket. ESC, Q vagy q esetÇn kilÇp.', 13, 10, '$'

code	ends
	end	start

