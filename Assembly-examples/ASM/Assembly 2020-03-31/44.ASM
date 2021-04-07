code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

maxstr	EQU	20				; Ennyi lehet a leghosszabb string


start:
	mov ax,3				; KÇpernyãtîrlÇshez m¢dbe†ll°t†s k¢dja
	int 10h					; Video BIOS h°v†s a tîrlÇshez
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Elãszîr bekÇrem a stringet.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,offset bekero			; Szîvegc°m
	mov ah,9				; String ki°r†s k¢dja
	int 21h					; DOS h°v†sa ki°rat†sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Itt most lehet a nÇma beolvas†st h°vom	;
; Çs ki°rom a leÅtîttet.		 	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov cx,maxstr				; Legfeljebb ennyi hossz£ lehet
	mov di,offset bekstr			; Ide pakolom le a beolvasottakat
bekcik:
	mov ah,8				; Visszahangos beolvas†s k¢dja
	int 21h					; DOS h°v†sa beolvas†sra
	stosb					; Ki is teszem a t†rol¢ba
	cmp al,0dh				; 'Enter' volt?
	jz enyvol				; Igen, vÇge a beolvas†snak
	mov ah,2				; Karakter ki°r†s k¢dja
	mov dl,al				; Ez volt a karakter
	int 21h					; DOS h°v†sa ki°rat†sra
	loop bekcik				; Legfeljebb ennyiszer
	mov al,0dh				; Az 'Enter' k¢dja
	stosb					; Kimegy egy befejezã Enter
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; BekÇrem a vizsg†land¢ karaktert.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enyvol:
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
	mov cl,'0'				; Kezdã sz†ml†l¢
	mov si,offset bekstr			; Itt vizsg†lok
vizsac:
	lodsb					; Beolvasom a kitett karaktert
	cmp al,0dh				; Az 'Enter' volt?
	jz ittave				; Igen, befejeztem
	cmp al,ah				; Azonosak?
	jnz vizsac				; Nem, akkor nem sz†molom
	inc cl					; Nîvelem a sz†ml†l¢t
	jmp vizsac				; Vissza a nîvelÇs ut†n (nem LOOP !!!!!!)
ittave:
	mov dx,offset nemfor			; Szîvegc°m (ezt feltÇtelezem)
	mov ah,9				; String ki°r†s k¢dja
	cmp cl,'0'				; Maradt a CL 0-ban?
	jz ninika				; Igen, azaz nem fordult elã
	mov dx,offset elofor			; Szîvegc°m (Most m†r ez lesz)
	int 21h					; DOS h°v†sa ki°rat†sra
	mov ah,2				; Karakter ki°r†s k¢dja
	mov dl,cl				; Az elãfordul†sok sz†ma (karakterben!)
ninika:
	int 21h					; DOS h°v†sa ki°rat†sra
	mov ah,4ch				; A kilÇpÇs k¢dja
	int 21h					; A DOS h°v†sa kilÇpÇsre

bekero	db	'Add meg a vizsg†land¢ stringet! (BefejezÇs ''Enter'')$'
bekerk	db	13, 10, 'Melyik karaktert vizsg†ljam? $'
elofor	db	13, 10, 'Az elãfordul†sok sz†ma: $'
nemfor	db	13, 10, 'Nem fordult elã!$'
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Egyel tîbbet foglalok a befejezã ENTER-hez.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
bekstr	db	maxstr + 1 dup (?)		; Kitîltetlen mem¢riahely kÇsz°tÇs

code	ends
	end	start

