code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; T�rl�shez m�dbe�ll�t�s k�d
        int     10h                     ; T�rl�s VIDEO BIOS-al
        mov     dx,offset mittes        ; Sz�vegc�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rat�s DOS-sal
        mov     cx,10                   ; Ennyi le�t�st v�rok
leucik:
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; Dos-sal olvasok be
        cmp     al,27                   ; �ppen ESC volt?
        jz      kareci                  ; Igen, akkor v�ge
        mov     ah,2                    ; Karakterki�r�s k�dja
        mov     dl,al                   ; Innen fogja ki�rni
        int     21h                     ; Ki�rat�s DOS-sal
        mov     dx,offset emobet        ; Sz�vegc�m
        cmp     al,'9'                  ; Nagyobb mint a '9'?
        ja      marabe                  ; Nagyobb, azaz bet�
        mov     dx,offset emosza        ; Sz�vegc�m
marabe:
        mov     ah,9                    ; Stringki�r�s k�dja
        mov     bl,al                   ; M�solat a le�t�sr�l
        int     21h                     ; Ki�rat�s DOS-sal
        cmp     bl,'q'                  ; �ppen 'q' volt?
        jz      kareci                  ; Igen, akkor v�ge
        cmp     bl,'Q'                  ; �ppen 'Q' volt?
        jz      kareci                  ; Igen, akkor v�ge
        loop    leucik                  ; Ciklusban �jra
kareci:
	mov	ah,4ch
        int     21h

mittes  db      '�ss�n le 10 bet�t vagy sz�mot! ESC, Q, q - v�ge ',13,10,'$'
emobet  db      '-bet�',13,10,'$'
emosza  db      '-sz�m',13,10,'$'

code	ends
	end	start

