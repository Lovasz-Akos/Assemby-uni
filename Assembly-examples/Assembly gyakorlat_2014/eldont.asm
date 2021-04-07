code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚shez
        int     10h                     ; K‚perny‹t”rl‚s VIDEO BIOS-al
        mov     dx,offset bemuta        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; A string ki¡rat sa DOS-sal
        mov     cx,10                   ; Maximum ennyi let‚s
ciklus:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; Let‚sv r s DOS-sal
        cmp     al,'Q'                  ; ppen 'Q' volt?
        jz      kilep                   ; Igen, ki is l‚pek
        cmp     al,'q'                  ; ppen 'q' volt?
        jz      kilep                   ; Igen, ki is l‚pek
        cmp     al,27                   ; ppen ESC volt?
        jz      kilep                   ; Igen, ki is l‚pek
        mov     dl,al                   ; Ezt ki is kell ¡rni
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        int     21h                     ; A karakter ki¡rat sa DOS-sal
        cmp     dl,'9'                  ; Nagyobb mint a sz mjegy
        mov     dx,offset habetu        ; Sz”vegc¡m betû eset‚re
        ja      nemasz
        mov     dx,offset haszam        ; Sz”vegc¡m sz m eset‚re
nemasz:
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; A string ki¡rat sa DOS-sal
        loop    ciklus                  ; Vissza a let‚sv r sra ciklusban
kilep:
	mov	ah,4ch
	int	21h

bemuta  db      'šss le sz mokat ‚s betûket! Kil‚p‚s ESC, Q vagy q.', 13, 10, '$'
habetu  db      '-betû', 13, 10, '$'
haszam  db      '-sz m', 13, 10, '$'

code	ends
	end	start

