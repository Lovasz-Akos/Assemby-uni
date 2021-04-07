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
	mov dx,offset hibast			; Szîvegc°m (a hib†t feltÇtelezem)
	mov ah,9				; String ki°r†s k¢dja
	mov si,80h				; A sz†ml†l¢ c°me
	lodsb					; AL <- [80h], majd INC SI is
	mov cl,al				; µtm†solom (CX lesz a sz†ml†l¢)
	mov ch,0				; CX <- darabsz†m
	jcxz ninika				; Nincs parancssor, hibaki°rat†sra ugrok
	inc si					; SI <- 82h azaz a parancssor c°me
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; BekÇrem a vizsg†land¢ karaktert.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,offset bekerk			; Szîvegc°m
	mov ah,9				; String ki°r†s k¢dja
	int 21h					; DOS h°v†sa ki°rat†sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Itt most lehet a visszhangos beolvas†st 	;
; h°vni.					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov ah,1				; Visszahangos beolvas†s k¢dja
	int 21h					; DOS h°v†sa beolvas†sra
	mov ah,al				; µtm†solom, mert a LODSB AL-be olvas majd be
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A sz†ml†l¢ba egybãl karakter kerÅl.	 	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov bl,'0'				; Kezdã sz†ml†l¢
vizsac:
	lodsb					; Beolvasom a kitett karaktert
	cmp al,0dh				; Az 'Enter' volt?
	jz ittave				; Igen, befejeztem
	cmp al,ah				; Azonosak?
	jnz vizsac				; Nem, akkor nem sz†molom
	inc bl					; Nîvelem a sz†ml†l¢t
	jmp vizsac				; Vissza a nîvelÇs ut†n (nem LOOP !!!!!!)
ittave:
	mov dx,offset nemfor			; Szîvegc°m (ezt feltÇtelezem)
	mov ah,9				; String ki°r†s k¢dja
	cmp bl,'0'				; Maradt a CL 0-ban?
	jz ninika				; Igen, azaz nem fordult elã
	mov dx,offset elofor			; Szîvegc°m (Most m†r ez lesz)
	int 21h					; DOS h°v†sa ki°rat†sra
	mov ah,2				; Karakter ki°r†s k¢dja
	mov dl,bl				; Az elãfordul†sok sz†ma (karakterben!)
ninika:
	int 21h					; DOS h°v†sa ki°rat†sra
	mov ah,4ch				; A kilÇpÇs k¢dja
	int 21h					; A DOS h°v†sa kilÇpÇsre

bekerk	db	'Melyik karaktert vizsg†ljam? $'
elofor	db	13, 10, 'Az elãfordul†sok sz†ma: $'
nemfor	db	13, 10, 'Nem fordult elã!$'
hibast	db	'Nincs elemezendã parancsor! KilÇpek!$'

code	ends
	end	start

