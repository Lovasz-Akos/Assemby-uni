code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; VIDEO BIOS h°v†sa, m¢dv†lt†shoz
        mov     bx,'99'                 ; Ezzel kezdek
;
; A ciklust ki°rat†ssal kezdem
;
tokici:
        mov     ah,2                    ; Karakterki°rat†s k¢dja
        mov     dl,bh                   ; Az 1. karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,bl                   ; A 2. karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,13                   ; A CR karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,10                   ; Az LF karakter
        int     21h                     ; Megy ki a karakter DOS-sal
;
; A m†sodik sz†mjegyet manipul†lom
;
        dec     bl                      ; Egyel csîkkentem
;
; Figyelek, hogy a '0' karakternÇl nem lehet kisebb
;
        cmp     bl,'0'                  ; Ennel kisebb lett?
        jae     marhat                  ; Nem, akkor maradhatok
;
; Most m†r a '9' kell, de csîkkenteni kell az elsã jegyet is!
;
        mov     bl,'9'                  ; ÷gy most 9 lett belãle
        dec     bh                      ; Egyel csîkkentem
marhat:
        cmp     bx,'00'                 ; ElÇrte?
        jz      kilep                   ; Igen, akkorm befejezem
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; V†rok leÅtÇsre DOS-sal
        cmp     al,27                   ; ESC jîtt?
        jnz     tokici                  ; Nem akkor jîn a tov†bbi ki°rat†s
kilep:
	mov	ah,4ch
	int	21h

code	ends
	end	start

