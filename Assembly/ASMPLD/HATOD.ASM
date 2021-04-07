code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

parmer  db      ?                       ; Ez a param‚terek hossza karakterben
        db      ?                       ; Az elv laszt¢ karakter helye
parsor  db      125 dup(?)              ; A parancssor ‚rdemi r‚sz

	org	100h


start:
        mov     al,[parmer]             ; AL <- parancsssor hossza
        or      al,al                   ; Nulla lett?
        jz      mostnu                  ; Igen, most nulla lett!
;
; Itt most nem nulla a hossz, megvizsg lom
;
        mov     cl,al                   ; µtm solom CL-be
        mov     ch,0                    ; H r‚sz null z sa miatt CX <- AL
        dec     cx                      ; Csak az elv laszt¢ van?
        jcxz    mostnu                  ; Igen, csak az elv laszt¢ karakter
;
; Innen m r a parancssor ‚rdemi r‚sz elemezhet‹ ki
;
        mov     bx,offset parsor        ; BX <- a param‚tersor els‹
                                        ; karakter‚nek c¡me
;
; Ciklust szervezek a k¡rat sra
;
        mov     ah,2                    ; Ki¡rat sk‚r‚s k¢dja
karcik:
        mov     dl,[bx]                 ; DL <- a parancssor k”vetkez‹ b jtja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        inc     bx                      ; L‚pek a parancsor k”vetkez‹ elem‚re
        loop    karcik                  ; Ciklus a ki¡rat sra
        jmp     kilep                   ; Ha m r ki¡rtuk ut na kil‚pnk
mostnu:
        mov     dx,offset nuhopa        ; Sz”vegc¡m, amit ki¡ratok
        mov     ah,9                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
kilep:
	mov	ah,4ch
	int	21h

nuhopa  db      'A parancssorban nincs semmi.$'

code	ends
	end	start

