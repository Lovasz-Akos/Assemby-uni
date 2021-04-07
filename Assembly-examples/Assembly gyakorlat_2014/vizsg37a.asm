code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; VIDEO BIOS h°v†sa, m¢dv†lt†shoz
;
; A ciklust ki°rat†ssal kezdem
;
tokici:
        mov     dx,offset amitki        ; Szîvegc°m
        mov     ah,9                    ; Stringki°rat†s k¢dja
        int     21h                     ; Megy ki a szîveg DOS-sal
;
; A m†sodik sz†mjegyet manipul†lom
;
        mov     bx,offset amitki + 1    ; Szîvegc°m a m†sodik jegyhez
        dec     byte ptr [bx]           ; Egyel csîkkentem
;
; Figyelek, hogy a '0' karakternÇl nem lehet kisebb
;
        cmp     byte ptr [bx],'0'       ; Ennel kisebb lett?
        jae     marhat                  ; Nem, akkor maradhatok
;
; Most mÇr a '9' kell, de csîkkenteni kell az elsã jegyet is!
;
        mov     byte ptr [bx],'9'       ; ÷gy most 9 lett belãle
        dec     bx                      ; µlÇpek az elsã jegyre
        dec     byte ptr [bx]           ; Egyel csîkkentem
marhat:
        mov     bx,offset amitki        ; Szîvegc°m a sz†mokhoz
        cmp     [bx],'00'               ; ElÇrte?
        jz      kilep                   ; Igen, akkorm befejezem
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; V†rok leÅtÇsre DOS-sal
        cmp     al,27                   ; ESC jîtt?
        jnz     tokici                  ; Nem akkor jîn a tov†bbi ki°rat†s
kilep:
	mov	ah,4ch
	int	21h

amitki  db      '99',13,10,'$'

code	ends
	end	start

