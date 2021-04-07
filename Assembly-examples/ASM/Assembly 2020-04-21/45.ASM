code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; KÇpernyãtîrlÇshez m¢dbe†ll°t†s k¢dja
	int 10h					; Video BIOS h°v†s a tîrlÇshez
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; MegnÇzem, hogy "Åres"-a a parancssor.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov si,80h				; A sz†ml†l¢ c°me
	lodsb					; AL <- [80h], majd INC SI is
	mov bl,al				; µtm†solom (CX lesz a sz†ml†l¢)
	mov bh,0				; BX <- darabsz†m
	or bx,bx				; BX nulla lett?
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Lehetne £gy is gondolkozni, hogy:		;
;	mov dx,offset hibast	; Szîvegc°m	;
;	mov ah,9		; String ki°r†s	;
; Çs a "ninika" c°mkÇt az INT 21H elãttre	;
; tesszÅk ki, mert a DEC BX "egybãl" negat°v	;
; BX-et eredmÇnyez, Çs kilÇp. :-)		;
; Persze akkor az itt "ninika" cimke alatti	;
; ît sorra nincs szÅksÇg!			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	jz ninika				; Igen, azaz nincsincs parancssor, hibaki°rat†sra ugrok
	mov ah,2				; EgyenkÇnt °rom ki
kaciki:
	mov dl,[82h + bx]			; Indexelt beolvas†s a parancssorb¢l (82H a karakterek c°me)
	int 21h					; DOS h°v†sa ki°rat†sra
	dec bx					; Visszafele lÇpegetek
	jns kaciki				; Mehet mÇg vissza a ciklusba (nem negat°v)
kilep:
	mov ah,4ch				; A kilÇpÇs k¢dja
	int 21h					; A DOS h°v†sa kilÇpÇsre
ninika:
	mov dx,offset hibast			; Szîvegc°m
	mov ah,9				; String ki°r†s k¢dja
	int 21h					; DOS h°v†sa ki°rat†sra
	jmp kilep				; Ut†na ki is lÇpek

hibast	db	'Nincs ford°tva ki°rand¢ parancsor! KilÇpek!$'

code	ends
	end	start

