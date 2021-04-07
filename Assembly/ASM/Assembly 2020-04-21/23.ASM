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
	mov cl,al				; µtm†solom (CX lesz a sz†ml†l¢)
	mov ch,0				; CX <- darabsz†m
	jcxz ninika				; Nincsincs parancssor, hibaki°rat†sra ugrok
	mov ah,2				; EgyenkÇnt °rom ki
	mov bx,2				; Ennyivel "beljebb" kezdek
	inc si					; µtlÇpek a parancssor elsã karakterÇre
kaciki:
	push cx					; Ne ronmoljon, ezÇ' mentem
	mov cx,bx				; Ennyivel menjen beljebb
	mov dl,' '				; Ezt teszem ki ciklusban
kezcik:
	int 21h					; DOS h°v†sa ki°rat†sra
	loop kezcik				; Mehet beljebb
	inc bx					; A kîvetkezã sorban egyel tîbbet teszek (majd) ki
	mov dl,[si]				; A parancssor karaktere
	int 21h					; DOS h°v†sa ki°rat†sra
	inc si					; LÇpek a kîvetkezãre
	mov dl,13				; CR karakter
	int 21h					; DOS h°v†sa ki°rat†sra
	mov dl,10				; LF karakter
	int 21h					; DOS h°v†sa ki°rat†sra
	pop cx					; Vissza a sz†ml†l¢
	loop kaciki				; Mehet mÇg vissza a ciklusba
kilep:
	mov ah,4ch				; A kilÇpÇs k¢dja
	int 21h					; A DOS h°v†sa kilÇpÇsre
ninika:
	mov dx,offset hibast			; Szîvegc°m
	mov ah,9				; String ki°r†s k¢dja
	int 21h					; DOS h°v†sa ki°rat†sra
	jmp kilep				; Ut†na ki is lÇpek

hibast	db	'Nincs ki°rand¢ parancsor! KilÇpek!$'

code	ends
	end	start

