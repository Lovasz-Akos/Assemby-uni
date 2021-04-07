code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; TîrlÇshez m¢dbe†ll°t†s k¢d
        int     10h                     ; TîrlÇs VIDEO BIOS-al
        mov     dx,offset mittes        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; Ki°rat†s DOS-sal
        mov     cx,10                   ; Ennyi leÅtÇst v†rok
leucik:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; Dos-sal olvasok be
        cmp     al,27                   ; êppen ESC volt?
        jz      kareci                  ; Igen, akkor vÇge
        mov     ah,2                    ; Karakterki°r†s k¢dja
        mov     dl,al                   ; Innen fogja ki°rni
        int     21h                     ; Ki°rat†s DOS-sal
        mov     dx,offset emobet        ; Szîvegc°m
        cmp     al,'9'                  ; Nagyobb mint a '9'?
        ja      marabe                  ; Nagyobb, azaz bet˚
        mov     dx,offset emosza        ; Szîvegc°m
marabe:
        mov     ah,9                    ; Stringki°r†s k¢dja
        mov     bl,al                   ; M†solat a leÅtÇsrãl
        int     21h                     ; Ki°rat†s DOS-sal
        cmp     bl,'q'                  ; êppen 'q' volt?
        jz      kareci                  ; Igen, akkor vÇge
        cmp     bl,'Q'                  ; êppen 'Q' volt?
        jz      kareci                  ; Igen, akkor vÇge
        loop    leucik                  ; Ciklusban £jra
kareci:
	mov	ah,4ch
        int     21h

mittes  db      'össîn le 10 bet˚t vagy sz†mot! ESC, Q, q - vÇge ',13,10,'$'
emobet  db      '-bet˚',13,10,'$'
emosza  db      '-sz†m',13,10,'$'

code	ends
	end	start

