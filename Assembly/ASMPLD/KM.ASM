code	segment para	public	'code'

	.386

assume cs:code, ds:code, es:nothing, ss:nothing

emsmer	equ	256 * 4 		; Ennyi terÅlet kell az EMS-nek
xmsmer	equ	256 * 8 + 10 + 2	; Ennyi terÅlet kell az XMS-nek
stackh	equ	512			; Stack-hossz

igeny	equ	emsmer + xmsmer + stackh; Ennyi terÅlet a plusz igÇny

	org	100h
start:
	cld				; Nîvekvî stringmÅveletek legyenek
	mov	dx,offset ctrlbr	; Ez a CTRL-BREAK rutin c°me
	mov	ax,2523h		; IT. vektor m¢dos°t†s
	int	21h			; DOS h°v†s
	mov	ax,3528h		; LekÇrdezem
	int	21h			; DOS h°v†s
	mov	word ptr [int28t],bx	; Offszet
	mov	word ptr [int28t + 2],es; Paragrafus
	mov	dx,offset int28r	; Ide mutasson
	mov	ax,2528h		; Be†ll°tom
	int	21h			; DOS h°v†s
	mov	ah,30h			; Verzi¢sz†m kÇrdezÇs k¢dja
	int	21h			; DOS h°v†s
	cmp	al,2			; ElÇg nagy a DOS verzi¢sz†m ?
	ja	short mehdot		; Igen, menjÅnk tov†bb
	mov	dx,offset versba	; Szîvegc°m
kilsok:
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	mov	ax,4c01h		; KilkÇpÇs k¢dja, hibak¢d:1
	jmp	kilvim			; DOS h°v†s (kilÇpÇs)
mehdot:
	mov	dx,offset emmszo	; Ezt a file-t nyitjuk
	mov	ax,3d00h		; Megnyitjuk olvas†sra
	int	21h			; DOS h°v†s
	jc	short hivite		; Ha nem nyitja meg nincs
	mov	bx,ax			; File-sz†m †tpakol†s
	mov	ax,4400h		; IOCTL h°v†s k¢dja
	int	21h			; DOS h°v†s
	test	dl,80h			; Eszkîz ?
	je	short hivite		; Ez file, nincs EMS
	mov	ax,4407h		; IOCTL h°v†s k¢dja
	int	21h			; DOS h°v†s
	or	al,al			; Van EMS ?
	je	short hivite		; Nincs EMS
	mov	ah,3eh			; CLOSE k¢dja
	int	21h			; DOS h°v†s
	mov	ah,46h			; EMS verzi¢ kÇrdÇs
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres a h°v†s ?
	jne	short hivite		; Ha hib†s
	mov	[emsver],al		; Verzi¢ elpakol†s
hivite:
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	mov	bx,0ffffh		; Ennyi biztos nincs neki
	mov	ah,4ah			; Mem¢riablokk m¢dos°t†s k¢dja
	int	21h			; DOS h°v†s
	test	bx,0f000h		; Nagyobb mint 64K ?
	jne	short namiha		; Igen, nincs problÇma
	mov	cl,4			; Ennyit lÇptetek
	shl	bx,cl			; Igy byte
	cmp	bx,offset memveg + igeny; ElÇg ennyiben ?
	mov	dx,offset tulsoh	; Szîvegc°m
	jb	short kilsok		; Hibaki°rat†s
namiha:
	mov	sp,offset memveg + igeny; Ide mutasson ezut†n
	mov	bx,[xmscim]		; Ide mutat most
	mov	word ptr [bx],0ffffh	; Nincs tov†bb jel kitÇtel
	mov	ax,4300h		; Ez a kÇrdezÇs k¢dja
	int	2fh			; MULTIPLEX
	xor	al,80h			; Sikeres ?
	jne	short netxms		; Nincs, vissza is tÇrek
	mov	byte ptr [xmsexi],al	; XMS jelzî <- 0
	mov	ax,4310h		; Vektor kÇrÇs k¢dja
	int	2fh			; MULTIPLEX
	mov	[xmsrut],bx		; XMS kezelî offszet
	mov	[xmsrut + 2],es 	; XMS kezelî paragrafus
	mov	word ptr [xmshnd],0	; XMS kezdî handle
netxms:
	mov	ax,4400h		; IOCTL h°v†s k¢dja
	xor	bx,bx			; STDIN handle
	int	21h			; DOS h°v†s
	rcl	dl,1			; KÇpernyî ?
	jnc	short nemkep		; Nem, mehet sim†n
	mov	ax,4400h		; IOCTL h°v†s k¢dja
	mov	bx,1			; STDOUT handle
	int	21h			; DOS h°v†s
	rcl	dl,1			; KÇpernyî ?
	jnc	short nemkep		; Nem, mehet sim†n
	push	ds			; Elrontom-bontom
	xor	ax,ax			; AX <- 0
	mov	ds,ax			; BIOS terÅlet
	mov	ax,ds:[44ch]		; Byte-sz†m
	mov	cx,ds:[44ah]		; Ennyi oszlopos
	add	cx,cx			; A st†tusz miatt dupla hossz
	xor	dx,dx			; H sz¢ <- 0
	div	cx			; AX <- sorsz†m
	cmp	ax,25			; êppen 25 ?
	je	short epnema		; Igen, mehet
	mov	ax,ds:[44ch]		; A hossz mÇgegyszer
	dec	ah			; AX <- AX - 256
	xor	dx,dx			; H sz¢ <- 0
	div	cx			; AX <- sorsz†m
epnema:
	mov	cx,ds:[44ah]		; Ennyi oszlopos
	pop	ds			; DS vissza
	mov	byte ptr [sordar],al	; Ennyi darab lehet
	dec	al			; Egyel kevesebbet lehet
	mov	byte ptr [mardar],al	; Ennyi darab lehet
	sub	cx,50			; Ennyi a minimum
	jbe	short nemkep		; Ha kisebb
	mov	ax,cx			; Ez a maradÇk
	mov	cx,3			; Ennyi egy vektor hossza
	xor	dx,dx			; H sz¢ <- 0
	div	cx			; Ennyi vektornak van hely
	mov	[darabv],ax		; Darabsz†m
nemkep:
	mov	ah,52h			; Elsî blokk keresÇs k¢dja
	int	21h			; DOS h°v†s
	mov	ax,es:[bx - 2]		; Itt az elsî blokk paragrafusa
	mov	bp,ax			; Ez az eredeti indul†s
	mov	dx,offset merror	; Szîvegc°m
ujelke:
	call	xmsido			; Beolvasunk
	mov	es,ax			; Ez a kîvetkezî
	add	ax,es:[3]		; MCB hossz
	inc	ax			; Igy a kîvetkezî MCB
	cmp	byte ptr es:[0],4dh	; Mem¢ria blokk ?
	je	short ujelke		; Igen, ez az
	cmp	byte ptr es:[0],5ah	; Utols¢ blokk ?
	je	short utblta		; Igen, megvan
	jmp	kilsok			; Nem, hiba
utblta:
	push	es			; Ez volt az elîzî
	push	ax			; Ez a kîvetkezî
ujelkm:
	mov	es,ax			; Ez a kîvetkezî
	add	ax,es:[3]		; MCB hossz
	inc	ax			; Igy a kîvetkezî MCB
	cmp	byte ptr es:[0],4dh	; Mem¢ria blokk ?
	je	short ujelkm		; Igen, ez az
	cmp	byte ptr es:[0],5ah	; Utols¢ blokk ?
	jne	short megloa		; Nem, hiba
	push	es			; Ez volt
	mov	es,ax			; Ez lenne a kîvetkezî
	cmp	byte ptr es:[0],4dh	; Ez blokk ?
	pop	es			; ES vissza
	je	short ramtal		; Ez RAM !
	push	es			; Ez volt
	mov	es,ax			; Ez lenne a kîvetkezî
	cmp	byte ptr es:[0],5ah	; Ez blokk ?
	pop	es			; ES vissza
	jne	short mekovv		; A kîvetkezî nem az
	cli				; Nem jîhet IT.
	mov	byte ptr es:[0],0	; Ha ez RAM, akkor be°rom
	cmp	byte ptr es:[0],0	; Ez RAM ?
	mov	byte ptr es:[0],5ah	; Vissza°rom ak†rmi volt
	sti				; Most m†r lehet IT.
	jne	short mekovv		; Ez nem RAM, befejeztem
ramtal:
	mov	byte ptr es:[0],4dh	; Vissza°rom hogy van kîvetkezî
	jmp	ujelkm			; Ez RAM, itt is vizsg†lom
mekovv:
	pop	cx			; Stack År°tÇs
	pop	[hatart]		; Ez lesz a hat†rol¢
	push	ax			; Ez a kîvetkezî
	push	es			; Ez volt az elîzî
	jmp	short vimenn		; Vissza UMB esetÇn
megloa:
	mov	ax,bp			; Kezdî blokk
holhak:
	cmp	ax,9fffh		; Ez a hat†r ?
	jb	short megyen		; Nem, mehetÅnk tov†bb
	mov	[hatart],ax		; Elpakoljuk
	jmp	short hatalm		; Megvan
megyen:
	mov	es,ax			; Ez a kîvetkezî
	add	ax,es:[3]		; MCB hossz
	inc	ax			; Igy a kîvetkezî MCB
	cmp	byte ptr es:[0],4dh	; Mem¢ria blokk ?
	je	short holhak		; Igen, mehet
hatalm:
	pop	es			; Ez a mostani
	pop	cx			; Ez volt az elîzî
	jmp	short vimenf		; Vissza ha nincs UMB
vimenn:
	pop	cx			; Ez volt az elîzî
	pop	es			; Ez a mostani
vimenf:
	cmp	byte ptr es:[0],5ah	; Utols¢ blokk ? (LOADHI !!!)
	jne	short mekovi		; Nem, nem nÇzem tov†bb
	cli				; Nem jîhet IT.
	mov	byte ptr es:[0],0	; Ha ez RAM, akkor be°rom
	cmp	byte ptr es:[0],0	; Ez RAM ?
	mov	byte ptr es:[0],5ah	; Vissza°rom ak†rmi volt
	sti				; Most m†r lehet IT.
	jne	short mekovi		; Ez nem RAM, befejeztem
	mov	es,cx			; Ez az elîzî
	mov	byte ptr es:[0],4dh	; Vissza°rom hogy van kîvetkezî
	jmp	ujelke			; Ez RAM, itt is vizsg†lom
mekovi:
	mov	dx,offset fejlec	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	cx,[darabv]		; Darabsz†m
	sub	cx,7			; Ennyivel kevesebb
	jbe	short nemjos		; Ha nem kell tîbbet
minkiv:
	call	xmsido			; Beolvasunk
	mov	dx,offset spdrss	; FejlÇc szîveg p¢tl†s
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	loop	minkiv			; Folytat†s
nemjos: 				; Megfelel
	mov	dx,offset fejlev	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	cx,[darabv]		; Darabsz†m
	dec	cx			; Ennyivel kevesebb
	jcxz	short nemjom		; Ha nem kell tîbbet
minkii:
	call	xmsido			; Beolvasunk
	mov	dx,offset minuss	; FejlÇc szîveg p¢tl†s
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	loop	minkii			; Folytat†s
nemjom: 				; Megfelel
	mov	cx,1			; Kezdî tulajdonos
tulviz:
	mov	bl,1			; Nem fÅggetlen blokk
	xor	ax,ax			; AX <- 0
	mov	[mcbblk],ax		; Lenull†zzuk
	mov	dx,0ffffh		; Nincs tulajdonos
	xor	di,di			; Nincs hossz
	xor	si,si			; Nincs blokksz†m
	mov	ax,bp			; Ez a kezdî blokk
	jcxz	short valava		; A szabadot a rutin gyÅjti
vakobo:
	mov	es,ax			; Ez az elîzî tulajdonos
	add	ax,es:[3]		; MCB hossz
	inc	ax			; Igy a kîvetkezî MCB
	cmp	es:[1],cx		; Ez a tulajdonos ?
	jne	short ntutal		; Nem, ez nem a tulajdonos
	mov	bl,0			; FÅggetlen blokk
	cmp	bp,[nagytu]		; Nagy a tulajdonos ?
	jae	short hasame		; Igen, nagy
	push	ax			; Nem rontjuk
	mov	ax,es			; Ez a paragrafus van
	cmp	ax,[nagytu]		; UMB hat†r
	pop	ax			; Vissza
	jae	short kiakad		; Nem adjuk hozz†
hasame:
	add	di,es:[3]		; Ez a blokkhossz
	inc	si			; + 1 a blokkok sz†ma
kiakad:
	push	ax			; Nem rontjuk
	mov	ax,es			; Ez az MCB
	inc	ax			; Igy a blokk
	cmp	es:[1],ax		; Ez a tulajdonos ?
	jne	short mtuvai		; Igen, m†s a tulajdonos
	mov	[mcbblk],es		; Ez az MCB kijelzÇs
mtuvai:
	cmp	[mcbblk],0		; Lenull†ztuk ?
	jne	short tuszap		; A vizsg†latot †tlÇpjÅk
	mov	[mcbblk],es		; Ez az MCB kijelzÇs
tuszap:
	pop	ax			; AX vissza
	jmp	short tuszav		; A vizsg†latot †tlÇpjÅk
ntutal:
	mov	bl,1			; Nem fÅggetlen blokk
	jb	short tuszav		; Ha nagyobb volt a tulajdonos
	cmp	word ptr es:[1],0	; Nincs tulajdonos ?
	je	short tuszav		; Ha nincs tulajdonos
	cmp	dx,es:[1]		; Az elt†roltn†l kisebb ?
	jbe	short tuszav		; Ha nem kisebb
	mov	dx,es:[1]		; Ez lesz a kîvetkezî
tuszav:
	cmp	byte ptr es:[0],5ah	; Utols¢ blokk ?
	jne	short vakobs		; Nem, folytassuk
	push	ax			; Elrontan†m
	mov	ax,es			; Ez a paragrafus most
	cmp	ax,[hatart]		; Ez a lapoz†si hat†r ?
	pop	ax			; Kîvetkezî vissza
	jne	short elerha		; ElÇrte a hat†rt
vakobs:
	jmp	vakobo			; VisszamegyÅnk
elerha:
	or	si,si			; Van darab ?
	jne	short taldar		; Igen, tal†ltam
nidaer:
	jmp	nidaes			; Nincs egy darab sem ebbîl
taldar:
	mov	ax,cs			; Ez a saj†tom
	cmp	ax,cx			; Ezt °rn† ki Çppen ?
	je	short nidaer		; Igen, ezt nem engedem
valava:
	push	bp			; Ez kell mÇg
	mov	bp,sp			; Hogy elÇrhessÅk
	push	cx			; Tulajdonos mentÇs
	push	dx			; Kîvetkezî tulajdonos mentÇs
	push	di			; Elrontom a hosszat is
	push	es			; Ez is romlik
	call	crlfki			; Uj sor ind°t†s
	mov	ax,cx			; Ez a PSP c°m
	or	ax,ax			; Ez a szabad ?
	je	short szablt		; Igen, szabad
	jmp	neszbl			; Nem, ez nem a szabad
szablt:
	mov	ax,[bp + 0]		; Ez az eredeti bp
	xor	dx,dx			; Eddig ez a legnagyobb
kovsab:
	mov	es,ax			; Ez a kezdî
	cmp	word ptr es:[1],0	; Szabad ?
	je	short sabtal		; Igen, szabadot tal†ltam
	mov	ax,cs			; Ez a saj†t blokkom
	cmp	es:[1],ax		; Saj†tom ?
	jne	short kovblv		; Nem, nem lehet nÇzni
sabtal:
	push	ax			; Ebbe fogom tenni
	mov	ax,[bp + 0]		; Ezzel kell îsszehasonl°tani
	cmp	ax,[nagytu]		; Ez az UMB ?
	pop	ax			; AX vissza
	jae	short nenezd		; Igen, nem baj
	cmp	ax,[nagytu]		; Nagyobb ?
	jae	short kovblv		; Igen, nem baj
nenezd:
	mov	cx,es			; Ez az MCB
	push	dx			; Ez a rÇgi
	mov	dx,es:[3]		; Ez a blokk hossza
	inc	si			; A szabad nîvelÇse
	add	di,es:[3]		; Ez a blokk hossza
folyho:
	push	es			; Ez a rÇgi
sabkov:
	cmp	byte ptr es:[0],5ah	; Utols¢ blokk ?
	je	short nesabk		; Igen, nem nÇzem tov†bb
	mov	ax,es			; Ez a kîvetkezî
	add	ax,es:[3]		; Ez a blokk hossza
	inc	ax			; Ez lesz a kîvetkezî
	mov	es,ax			; Ez a kezdî
	cmp	word ptr es:[1],0	; Szabad ?
	je	short sabbel		; Igen, szabadot tal†ltam
	mov	ax,cs			; Ez a saj†t blokkom
	cmp	es:[1],ax		; Saj†tom ?
	jne	short nesabk		; Nem, akkor nem szabad
sabbel:
	inc	dx			; Ez a le°r¢
	inc	di			; Ez a le°r¢
	add	dx,es:[3]		; Ez a blokk hossza
	add	di,es:[3]		; Ez a blokk hossza
	pop	ax			; ES eltÅntetÇse
	jmp	short folyho		; Uj szabadciklus
nesabk:
	pop	es			; Ez a blokk a jelenlegi
	pop	ax			; Ez az eredeti DX
	cmp	ax,dx			; Melyik a nagyobb ?
	xchg	dx,ax			; Ez az £j hossz
	jae	short kovblv		; Nem a rÇgi a nagyobb
	xchg	dx,ax			; Ez az £j hossz
	mov	[mcbblk],cx		; Ez most az MCB
kovblv:
	mov	ax,es			; Ez a kîvetkezî
	add	ax,es:[3]		; Ez a blokk hossza
	inc	ax			; Ez lesz a kîvetkezî
	cmp	byte ptr es:[0],4dh	; Van kîvetkezî ?
	jne	short vakobl		; Nincs, vÇge
	jmp	kovsab			; Igen, keressÅk is
vakobl:
	push	dx			; Ennyi a folytonos hossz
	mov	ax,[mcbblk]
	dec	ax
neszbl:
	call	hexaax			; Hexadicim†lis ki°rat†s
	call	spkii1			; Ki°runk sz¢kîzt
	mov	ax,si			; Ennyi darab
	mov	dx,2			; Ennyi hosszan, nincs 0
	call	deckbp			; Ki°rjuk
	mov	cl,2			; Ennyit °rjon ki sz¢kîzbîl
	call	spkiir			; Ki°runk sz¢kîzt
	mov	ax,[mcbblk]		; Ez az MCB
	call	hexaax			; Hexadicim†lis ki°rat†s
	call	spkii1			; Ki°runk sz¢kîzt
	mov	ax,di			; Ez a paragrafushossz volt
	mov	dx,16			; Ennyi a szorz¢
	mul	dx			; Ennyi byte lesz
	push	bp			; Ez kell mÇg
	mov	cx,6			; Ennyi a hossza
	call	declon			; DX:AX ki°rat†s
	call	spkii1			; Ki°runk sz¢kîzt
	pop	bp			; Pointer vissza
	mov	ax,[bp - 2]		; Ez a tulajdonos
	or	ax,ax			; Ez a szabad ?
	jne	short neszat		; Nem, ez nem aszabad
	mov	dx,offset freszo	; Ez a szabadok szîvege
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	pop	ax			; Ez a paragrafussz†m
	mov	bx,16			; Ez a paragrafus hossza
	mul	bx			; Igy DX:AX-be byte-sz†m
	mov	cl,1			; Ilyen hosszan
	call	declon			; Ki°rjuk
	mov	dx,offset frekov	; Ez a szabadok szîvege
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	jmp	befeve			; Ki°rtam m†r
neszat:
	mov	es,ax			; Akkor ez PSP
	mov	cx,ax			; PSP m†solat
	mov	bx,es:[2ch]		; Ez az environmentje
	or	bx,bx			; Van neki ?
	je	short ninenv		; Nem, csak tulaj lehet
	dec	bx			; Igy MCB lett belîle
	mov	ax,[bp] 		; Ez az eredeti kezdet
kercia:
	mov	es,ax			; Ez a kîvetkezî
	cmp	ax,bx			; Azonos ?
	je	short talenv		; Igen, ez lehet environment
	add	ax,es:[3]		; MCB hossz
	inc	ax			; Igy a kîvetkezî MCB
	cmp	byte ptr es:[0],4dh	; Mem¢ria blokk ?
	je	short kercia		; Igen, ez az
ninenv:
	mov	ax,[bp - 2]		; Ez a tulajdonos
	dec	ax			; A tulajdonos MCB-je
	mov	es,ax			; Ez a paragrafus
	mov	di,7			; Itt lehet
	mov	dx,offset naszoc	; Ez a szabadok szîvege
	cmp	byte ptr es:[di + 1],'0'; Megfelelî karakter ?
	jb	short naszok		; Nem, szîveget °runk
	cmp	byte ptr es:[di + 1],'Z'; Megfelelî karakter ?
	jbe	short talhak		; Igen, ki°ratjuk
	cmp	byte ptr es:[di + 1],'a'; Megfelelî karakter ?
	jb	short naszok		; Nem, szîveget °runk
	cmp	byte ptr es:[di + 1],'z'; Megfelelî karakter ?
	jbe	short talhak		; Igen, ki°ratjuk
naszok:
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	jmp	voltul			; Ki°rtam m†r
talenv:
	cmp	es:[1],cx		; ês azÇ a PSP-Ç ?
	jne	short ninenv		; Nem, akkor nem environment
	mov	ax,16			; Ennyi hossz£ egy paragrafus
	mov	di,ax			; DI <- kezdet
	mul	word ptr es:[3] 	; Ennyin belÅl lenni kell !
	or	dx,dx			; Hossz£ ?
	jne	short ninenv		; Ha hossz£, nem environment
	mov	cx,ax			; CX <- hossz
	dec	ax			; Hossz£ vagy 0 ?
	js	short ninenv		; Ha nem environment
	mov	al,0			; Ezt keresek
ujeker:
	repnz	scasb			; MegkeressÅk
	jne	short ninenv		; Ha elfogyott
	scasb				; MegkeressÅk
	jne	short ujeker		; Ez mÇg nem az
	mov	ax,1			; Ennek kell lennie
	scasw				; Kettît †tlÇpÅnk
	jnz	ninenv			; Ha nem le°r¢
	mov	dx,di			; Itt kezdîdik
	cmp	byte ptr es:[di],0	; Eredetileg nulla ?
	jz	short ninenv		; Ha elfogyott
kerenc:
	mov	al,es:[di]		; Beolvasom a karaktert
	inc	di			; Kîvetkezîre lÇpek
	or	al,al			; Hat†rol¢ ?
	jz	short ralepe		; Igen, b†r furcs, hogy nulla
	cmp	al,'.'                  ; Ezt keressÅk
	jz	short ralepe		; Igen, kiterjesztÇst tal†ltam
	loop	short kerenc		; MegkeressÅk
ninens:
	jmp	short ninenv		; Ha elfogyott
ralepe:
	sub	di,2			; Itt az utols¢ karakter
karkec:
	mov	al,es:[di]		; Ez a karakter
	cmp	al,'\'                  ; Hat†rol¢ ?
	je	short talhak		; Igen, itt az eleje
	dec	di			; Elîzîre
	cmp	di,dx			; ElÇrte az elejÇt ?
	jnz	karkec			; KeressÅk tov†bb
	dec	di			; MÇg egyet vissza
talhak:
	mov	cx,8			; Ennyi lehet
	cmp	byte ptr es:[di + 1],'z'; EnnÇl nagyobb ?
	ja	ninens			; Igen, nem megy ki
	cmp	byte ptr es:[di + 1],'a'; EnnÇl kisebb ?
	jae	short tulkic		; Nem, mehet
	cmp	byte ptr es:[di + 1],'_'; EnnÇl nagyobb ?
	ja	short ninens		; Ha elfogyott
	cmp	byte ptr es:[di + 1],'!'; EnnÇl kisebb ?
	jb	short ninens		; Ha elfogyott
tulkic:
	inc	di			; A hat†rol¢-t †tlÇpjÅk
	mov	dl,es:[di]		; Ez a ki°ratand¢
	cmp	dl,'.'                  ; KiterjesztÇhat†r ?
	je	short befeka		; Igen, nem °rjuk tov†bb
	cmp	dl,'z'                  ; EnnÇl nagyobb ?
	ja	short befeka		; Igen, nem °rjuk tov†bb
	cmp	dl,'a'                  ; EnnÇl nagyobb ?
	jae	short kirari		; Igen, °rjuk tov†bb
	cmp	dl,'!'                  ; EnnÇl kisebb ?
	jb	short befeka		; Igen, nem °rjuk tov†bb
	cmp	dl,'_'                  ; EnnÇl nagyobb ?
	ja	short befeka		; Igen, nem °rjuk tov†bb
kirari:
	call	kidosc			; Ki°rjuk DL-t.
	loop	short tulkic		; Ennyi lehet a ciklus
befeka:
	inc	cl			; Egyel tîbb sz¢kîz
	call	spkiir			; Ki°runk sz¢kîzt
voltul:
	mov	cx,19			; Stringki°rat†s hossza
	mov	ax,[bp - 2]		; Ez a tulajdonos
	or	ax,ax			; Ez a szabad ?
	je	short volfre		; Ki°rok sz¢kîzt
	mov	es,ax			; Itt a PSP
	cmp	word ptr es:[3],10h	; Legal†bb egy PSP-nyi van ?
	jb	short volfre		; Nincs, nem PSP
	mov	di,81h			; Itt van a parancssor
	mov	al,es:[di - 1]		; Ez a hossz
	cbw				; ètalak°tjuk
	or	ax,ax			; Negat°v vagy nulla ?
	je	short volfre		; Igen, nem °rjuk ki
	js	short volfre		; Igen, nem °rjuk ki
	mov	bx,ax			; Igy offszet lesz
	cmp	byte ptr es:[di + bx],0dh; CR ?
	jne	short volfre		; Ha nem nem °runk sort
	mov	dl,es:[di]		; Ez a ki°ratand¢
	cmp	dl,' '                  ; Sz¢kîz ?
	je	short decdil		; Igen, nem °rjuk ki
	cmp	dl,9			; Tabul†tor ?
	jne	short eredet		; Nem , nem m¢dos°tunk
decdil:
	scasb				; DI <- DI + 1
	dec	al			; Egyel rîvidebb
	je	short volfre		; Ha nem marad
eredet:
	mov	ah,15			; EnnÇl tîbb ?
	cmp	al,ah			; EnnÇl tîbb ?
	jbe	short nekelk		; Nem, nem korrig†lunk
	mov	al,ah			; Csak ennyit °runk ki
nekelk:
	sub	cl,al			; Ennyi marad
	push	cx			; Ez a maradÇk
	mov	ah,0			; Hogy ciklussz†m lehessen
	mov	cx,ax			; Ennyi a parancssor
parsoc:
	mov	dl,es:[di]		; Ez a ki°ratand¢
	inc	di			; A hat†rol¢-t †tlÇpjÅk
	cmp	dl,' '                  ; Sz¢kîznÇl kisebb ?
	jb	short kicibe		; Igen, befejezve
	call	kidosc			; Ki°rjuk DL-t.
	loop	short parsoc		; Ennyi lehet a ciklus
kicibe:
	jcxz	short mobeki		; Ha nincs tîbb
vakima:
	mov	dl,' '                  ; Sz¢kîz
	call	kidosc			; Ki°rjuk DL-t.
	loop	vakima			; Ennyi lehet a ciklus
	pop	cx			; Ennyi maradt
	jmp	short volfre		; KitesszÅk  a sz¢kîzt
mobeki:
	pop	cx			; Ennyi maradt
kerpok:
	cmp	byte ptr es:[di],0dh	; Ez a ki°ratand¢ ?
	je	short volfre		; Igen, kitesszÅk  a sz¢kîzt
parsop:
	mov	dl,'.'                  ; Ez a ki°ratand¢
	call	kidosc			; Ki°rjuk DL-t.
	loop	short parsop		; Ennyi lehet a ciklus
volfre:
	inc	cl			; Egyel tîbb sz¢kîz
	call	spkiir			; Ki°runk sz¢kîzt
	xor	bx,bx			; Ez a kezdî vektor
	mov	cx,[darabv]		; Ennyi vektor lehet egy sorban
	inc	cx			; Korrekci¢, mert LOOP-al kezd
	cmp	bx,[bp - 2]		; Ez a tulajdonos a szabad ?
	jne	short kovevi		; Nem, ez nem a szabad
	jmp	befeve			; A szabadnak nem °runk ki vektort
kovevi:
	push	bx			; Vektorsz†m mentÇs
	push	bp			; Pointer mentÇs
	shl	bx,1			; Vektor * 2
	shl	bx,1			; Vektor * 4 (°gy a vektor c°me)
	xor	ax,ax			; AX <- 0
	mov	es,ax			; ES <- IT. vektort†bla
	les	bx,es:[bx]		; DS:BX <- IT. vektor
	mov	ax,es			; AX <- vektor szegmense
	mov	ax,es			; Ez a paragrafushossz volt
	mov	dx,16			; Ennyi a szorz¢
	mul	dx			; Ennyi byte lesz
	add	ax,bx			; Eltol†s az offszettel
	adc	dx,0			; Eltol†s az offszettel
	mov	bx,[bp] 		; Ez az eredeti kezdet
kerciv:
	mov	es,bx			; Ez a kîvetkezî
	pop	bp			; Pointer vissza
	mov	bx,[bp - 2]		; Ez a tulajdonos
	push	bp			; Pointer vissza
	cmp	bx,es:[1]		; Ez a tulajdonosa ?
	je	short taltul		; Igen, ez lehet environment
koreme:
	mov	bx,es			; Ez volt a szegmens
	add	bx,es:[3]		; MCB hossz
	inc	bx			; Igy a kîvetkezî MCB
	cmp	byte ptr es:[0],4dh	; Mem¢ria blokk ?
	je	short kerciv		; Igen, ez az
	jmp	short ovekes		; Ha befejezte
taltul:
	push	ax			; Ebbe lesz a szorzand¢
	push	dx			; Ebbe lesz a szorz¢
	mov	ax,es			; Ez a paragrafushossz volt
	mov	dx,16			; Ennyi a szorz¢
	mul	dx			; Ennyi byte lesz
	mov	di,dx			; Ez a H sz¢
	mov	bx,ax			; Ez az L sz¢
	pop	dx			; H sz¢ vissza
	pop	ax			; L sz¢ vissza
	cmp	di,dx			; C°m H rÇsz alatt van ?
	ja	short koreme		; Nem, mehet a kîvetkezî blokkra
	jb	short mevive		; Alatta van, als¢ hat†rvizsg†lat
	cmp	bx,ax			; C°m L rÇsz alatt van ?
	ja	short koreme		; Nem, mehet a kîvetkezî blokkra
mevive:
	push	ax			; Ebbe lesz a szorzand¢
	push	dx			; Ebbe lesz a szorz¢
	mov	ax,es			; Ez a paragrafushossz volt
	add	ax,es:[3]		; Ez az utols¢t kîvetî c°m
	mov	dx,16			; Ennyi a szorz¢
	mul	dx			; Ennyi byte lesz
	mov	di,dx			; Ez a H sz¢
	mov	bx,ax			; Ez az L sz¢
	pop	dx			; H sz¢ vissza
	pop	ax			; L sz¢ vissza
	cmp	di,dx			; C°m H rÇsz alatt van ?
	jb	short koreme		; Igen, mehet a kîvetkezî blokkra
	ja	short meviki		; Alatta van, als¢ hat†rvizsg†lat
	cmp	bx,ax			; C°m L rÇsz alatt van ?
	jbe	short koreme		; Igen, mehet a kîvetkezî blokkra
meviki:
	loop	short nekeus		; Ha mehet mÇg
	call	crlfki			; Kîvetkezî sor
	mov	cl,50			; Ennyit °rjon ki sz¢kîzbîl
	call	spkiir			; Ki°runk sz¢kîzt
	mov	cx,[darabv]		; Ennyi vektor °r¢dhat ki
nekeus:
	pop	bp			; Pointer vissza
	pop	ax			; Vektorsz†m vissza
	push	ax			; Vektorsz†m mentÇs
	push	bp			; Pointer mentÇs
	push	cx			; Ciklussz†m kell
	call	hexaal			; AL ki°rat†sa hexadecim†lisan
	pop	cx			; Darab vissza
	cmp	cl,1			; Ennyi van ?
	je	short ovekes		; Igen, nincs sz¢kîz ki°rat†s
	mov	dl,' '                  ; Ez a karakter
	call	kidosc			; Ki°runk sz¢kîzt
ovekes:
	pop	bp			; Pointer vissza
	pop	bx			; Vektorsz†m vissza
	inc	bl			; Kîvetkezî vektor
	je	short befeve		; Nincs tîbb vektor
	jmp	kovevi			; Kîvetkezî vektor vizsg†lata
befeve:
	pop	es			; Szegmensregiszter vissza
	pop	di			; Hossz vissza
	pop	dx			; Kîvetkezî tulajdonos vissza
	pop	cx			; Tulajdonos vissza
	pop	bp			; Kezdî paragrafus vissza
	or	cx,cx			; A szabad blokk ?
	jne	short nidaes		; Nem
	test	byte ptr [elcrke],1	; Volt m†r ?
	jne	short nidaes		; Igen, volt m†r
	or	byte ptr [elcrke],1	; Volt jelzÇse
	mov	ax,[hatart]		; Kezdî tulajdonos
	mov	es,ax			; Paragrafus
	inc	ax			; Nulla ?
	je	short nidaes		; Nem volt kitîltve
	add	ax,es:[3]		; Hossz
	mov	bp,ax			; Innen folytassa
	mov	[nagytu],ax
	call	crlfki			; Uj sor ind°t†s
	jmp	nemjom			; Uj menet
nidaes:
	jcxz	short emstat		; Ha ez a szabad blokk volt
	inc	dx			; Volt tulajdonos ?
	je	short netait		; Igen, volt
	dec	dx			; Vissza az eredeti
netait:
	mov	cx,dx			; Ez a kîvetkezî tulaj
	jmp	tulviz			; Vizsg†lat az £j tulajdonossal
emstat:
	call	crlfki			; Uj sor ind°t†s
	push	es			; ES mentÇs
	mov	ax,0f000h		; Ez a ROM-BIOS szegmense
	mov	es,ax			; Szegmensregiszterbe 0f000h
	mov	al,es:[0fffeh]		; GÇpt°pus jelzî
	cmp	al,0fch 		; AT-gÇp ?
	pop	es			; ES vissza
	jne	short nematg		; Nem, nincs extended mem¢ria
	mov	dx,offset fej15m	; Ez az INT 15 szîvege
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ah,88h			; Extended mem¢ria mÇret
	int	15h			; ROM BIOS funkci¢
	mov	bx,1024 		; Ennyi hossz£ egy Kbyte
	mul	bx			; Ez a hossz
	mov	cx,1			; Ilyen hosszan
	mov	byte ptr [kirhos],0	; Nincs semmi ki°rva
	call	declon			; Ki°rjuk DX:AX-et
	mov	cx,26			; Ennyi hely maradjon
	sub	cl,[kirhos]		; Ennyit ki°rt
tavhma:
	push	cx			; Elmentem
	mov	dl,' '                  ; Sz¢kîz
	call	kidosc			; Ki°rjuk DL-t.
	pop	cx			; Vissza a ciklussz†m
	loop	tavhma			; Ki°rat¢ ciklus
	cmp	byte ptr [xmsexi],0	; Van XMS ?
	jnz	short cscrit		; Nincs XMS
	mov	ah,0			; HMA lekÇrdezÇs
	call	dword ptr [xmsrut]	; XMS kezelî
	mov	[xmsver],ax		; Verzi¢ elpakol†s
	or	dx,dx			; Nulla a DX ?
	mov	dx,offset hmavan	; Szîvegc°m
	jnz	short tenyva		; DX nem nulla, van HMA
	mov	dx,offset hmanin	; Szîvegc°m
tenyva:
	pushf				; Elmentem
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	popf				; Flag vissza
	jz	short cscrit		; Nincs m†s szîveg
	mov	ah,1			; HMA allok†l†sa
	mov	dx,16			; Ennyi kell
	call	dword ptr [xmsrut]	; XMS kezelî
	mov	dx,offset hmafog	; Szîvegc°m
	dec	ax			; Volt hiba ?
	jnz	short hmasta		; Igen, nem szabad a HMA
	mov	ah,2			; HMA visszaad†s
	call	dword ptr [xmsrut]	; XMS kezelî
	mov	dx,offset hmafre	; Szîvegc°m
hmasta:
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
cscrit:
	call	crlfki			; Kîvetkezî sor
nematg:
	cmp	byte ptr [emsver],0	; Van EMS ?
	jne	short talems		; Van EMS
	cmp	byte ptr [xmsexi],0	; Van XMS ?
	jz	short talems		; Van XMS
	jmp	ninems			; Ha nincs
talems:
	mov	dx,offset crlfku	; FejlÇc szîveg, ha nincs EMS
	cmp	byte ptr [emsver],0	; Van EMS ?
	je	short nevaem		; Nincs EMS
	mov	dx,offset fejeme	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	dl,byte ptr [emsver]	; EMS verzi¢
	mov	cl,4			; Ennyit
	shr	dl,cl			; LelÇptetÇs
	or	dl,'0'                  ; Karakteres°tÅnk
	call	kidosc			; DOS ki°rat†s
	mov	dl,'.'                  ; Verzi¢ pont
	call	kidosc			; DOS ki°rat†s
	mov	dl,byte ptr [emsver]	; EMS verzi¢
	and	dl,0fh			; Csak az als¢ byte
	or	dl,'0'                  ; Karakteres°tÅnk
	call	kidosc			; DOS ki°rat†s
	mov	dx,offset fejemf	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ah,41h			; Page frame c°m kÇrdÇs k¢dja
	int	67h			; EMS h°v†s
	mov	ax,bx			; Ezt dek¢dolja
	call	hexaax			; Ki°rjuk
	mov	dx,offset fejemu	; FejlÇc szîveg
nevaem:
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	cmp	byte ptr [xmsexi],0	; Van XMS ?
	jnz	short ninxma		; Nincs XMS kezelî
	mov	dx,offset xmsfej	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	dl,byte ptr [xmsver + 1]; XMS H byte
	and	dl,0f0h 		; Van felsî byte ?
	jz	short csamav		; Csak 2. byte van
	mov	cl,4			; Ennyit
	shr	dl,cl			; LelÇptetÇs
	or	dl,'0'                  ; Karakteres°tÅnk
	call	kidosc			; DOS ki°rat†s
csamav:
	mov	dl,byte ptr [xmsver + 1]; XMS H byte
	and	dl,0fh			; Csak az als¢ byte
	or	dl,'0'                  ; Karakteres°tÅnk
	call	kidosc			; DOS ki°rat†s
	mov	dl,'.'                  ; Verzi¢ pont
	call	kidosc			; DOS ki°rat†s
	mov	al,byte ptr [xmsver]	; XMS L byte
	mov	ah,0			; Lenull†zzuk
	mov	dx,2			; Ennyi hosszan
	mov	bp,dx			; Nincs space
	call	deckii			; Ki°rjuk
	mov	dx,offset xmsfef	; FejlÇc szîveg folytat†s
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ax,[xmsrut + 2] 	; Ezt dek¢dolja (paragrafus)
	call	hexaax			; Ki°rjuk
	mov	dx,offset kettop	; Hat†rol¢ szîveg c°me
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ax,[xmsrut]		; Ezt dek¢dolja (offszet)
	call	hexaax			; Ki°rjuk
ninxma:
	call	crlfki			; EmelÅnk
	call	crlfki			; EmelÅnk
	cmp	byte ptr [emsver],0	; Van EMS ?
	je	short nevvom		; Nincs EMS
	mov	dx,offset fejems	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	cmp	[emsver],40h		; Van 4.0 legal†bb ?
	mov	dx,5			; Ennyi sz¢kîz
	call	spkite			; Elv†laszt¢ szîveg
	mov	dx,offset fejemx	; FejlÇc szîveg
	jb	short nemvef		; Nincs, nem °rjuk ki
	mov	dx,offset fejemk	; FejlÇc szîveg
nemvef:
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	dx,15			; Ennyi sz¢kîz
	call	spkite			; Elv†laszt¢ szîveg
nevvom:
	cmp	byte ptr [xmsexi],0	; Van XMS ?
	jnz	short ninxmb		; Nincs XMS kezelî
	mov	dx,offset fejxmm	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
ninxmb:
	call	crlfki			; EmelÅnk
	cmp	byte ptr [emsver],0	; Van EMS ?
	je	short nevvon		; Nincs EMS
	mov	dx,offset fejemv	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	cmp	[emsver],40h		; Van 4.0 legal†bb ?
	mov	dx,offset fejemy	; FejlÇc szîveg
	jb	short nemvof		; Nincs, nem °rjuk ki
	mov	dx,offset fejeml	; FejlÇc szîveg
nemvof:
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	dx,15			; Ennyi sz¢kîz
	call	spkite			; Elv†laszt¢ szîveg
nevvon:
	cmp	byte ptr [xmsexi],0	; Van XMS ?
	jnz	short ninxmc		; Nincs XMS kezelî
	mov	dx,offset fejxmf	; FejlÇc szîveg
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
ninxmc:
	call	crlfki			; Uj sor ind°t†s
	cmp	byte ptr [emsver],0	; Van EMS ?
	je	short emshan		; Nincs EMS
	mov	ah,4bh			; Akt°vok sz†m†nak lekÇrdezÇse
	int	67h			; EMS h°v†s
	mov	di,offset memveg	; Ide teheti
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	mov	ah,4dh			; Akt°v lekÇrdezÇs
	int	67h			; EMS h°v†s
	mov	[emshnd],bx		; Ennyit kell
	mov	si,di			; Itt a feje
emshan:
	mov	cx,[emshnd]		; Ennyi van mÇg
	jcxz	short hndelf		; Elfogyott, FREE
	inc	cx			; FFFF volt ?
	jnz	short talmec		; Nem, van mit csin†lni
	cmp	word ptr [xmshnd],0ffffh; Van XMS ?
	jne	short keltat		; Van, kell a t†vtart†s
	mov	bx,[xmskio]		; Kiolvas†si c°m
	cmp	word ptr [bx],0ffffh	; Kell mÇg kiolvasni ?
	je	short csbefv		; Nincs m†r belîle sem
keltat:
	cmp	byte ptr [emsver],0	; Van EMS ?
	jz	short csbefv		; Nincs
	mov	dx,31			; Ennyi hosszan
	call	spkite			; Sz¢kîzîk kitÇtele
csbefv:
	jmp	hndbef			; Minden kÇsz
talmec:
	inc	cx			; FFFE volt ?
	jz	short hndtot		; Elfogyott, tot†l
	push	bp			; Elrontom
	lodsw				; Ez a handles
	push	ax			; EltesszÅk
	mov	dx,5			; Ennyi hosszan, nincs 0
	call	deckbp			; Ki°rjuk
	pop	ax			; Vissza a handle
	push	ax			; EltesszÅk
	lodsw				; Ez a lapsz†m
	push	ax			; Vissza
	mov	dx,6			; Ennyi hosszan, nincs 0
	call	deckbp			; Ki°rjuk
	pop	ax			; Ez a szabad
	mov	bx,16384		; Ennyi hossz£ egy EMS lap
	mul	bx			; Ez a hossz
	mov	cx,10			; Ilyen hosszan
	call	declon			; Ki°rjuk DX:AX-et
	pop	di			; Handles
	dec	word ptr [emshnd]	; Egyel kevesebb
	cmp	[emsver],40h		; Van 4.0 legal†bb ?
	jb	short tavspk		; Nincs tulajdonos
	mov	dx,offset tavols	; Szîvegc°m
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ax,5300h		; Tulajdonos kÇrdÇs
	mov	dx,offset fejems	; Ide tegye
	xchg	dx,di			; Helyrepakol†s
	int	67h			; Tulajdonos kÇrdÇs
	mov	cx,8			; Ennyi a maximum
cikhak:
	mov	dl,[di] 		; Karakter
	inc	di			; Kîvetkezî c°m
	or	dl,dl			; Nulla ?
	jne	short nestrv		; Nem, kipakolom
	mov	dl,' '                  ; Ezt helyette
	dec	di			; Vissza a null†ra
nestrv:
	call	kidosc			; DOS ki°rat†s
	loop	cikhak			; Vissza
nemves:
	jmp	short hndbef		; Mehet XMS nÇzîbe
hndelf:
	mov	word ptr [emshnd],0fffeh; Elsî sor
	mov	ah,42h			; Akt°v lekÇrdezÇs
	int	67h			; EMS h°v†s
	push	dx			; Ez a foglalt
	push	bx			; Ez a szabad
	mov	dx,offset freems	; Szabad szîvegc°m
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	pop	ax			; Ez a szabad
	jmp	short tavsel		; KiegÇsz°tem
hndtot:
	inc	word ptr [emshnd]	; Most FFFF lett belîle
	mov	dx,offset sumems	; Szabad szîvegc°m
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ah,42h			; Akt°v lekÇrdezÇs
	int	67h			; EMS h°v†s
	mov	ax,dx			; Ez a foglalt
tavsel:
	push	ax			; Vissza
	mov	dx,5			; Ennyi hosszan, nincs 0
	call	deckbp			; Ki°rjuk
	pop	ax			; Ez a szabad
	mov	bx,16384		; Enni hossz£ egy EMS lap
	mul	bx			; Ez a hossz
	mov	cx,10			; Ilyen hosszan
	call	declon			; Ki°rjuk DX:AX-et
tavspk:
	mov	dx,10			; Ennyi sz¢kîz
	call	spkite			; Elv†laszt¢ szîveg
hndbef:
	mov	ax,[xmshnd]		; Ez a handle
	or	al,al			; Nulla ?
	jnz	short nemkele		; Nem, nem vizsg†lunk
	mov	ah,0bh			; LeÅtÇsvizsg†lat k¢dja
	int	21h			; DOS h°v†s
nemkele:
	call	xmsido			; Beolvasunk
	mov	bx,[xmskio]		; Kiolvas†si c°m
	cmp	word ptr [bx],0ffffh	; Kell mÇg kiolvasni ?
	jne	short vanmic		; Igen, van kiolvasand¢
	cmp	word ptr [xmshnd],0ffffh; Ez az XMS handle
	jne	short hndbef		; Van mÇg, pr¢b†lkozunk
	jmp	xmself			; Nem, elfogyott
vanmic:
	cmp	byte ptr [emsver],0	; Van EMS ?
	jz	short cskxms		; Nem, csak XMS volt
	mov	dx,15			; Ennyi sz¢kîz
	call	spkite			; Elv†laszt¢ szîveg
cskxms:
	cmp	byte ptr [bx],0feh	; XMS kezelî free ?
	jnz	short nemfre		; Nem, nem free
	dec	byte ptr [bx]		; XMS kezelî tot†l legyen
	mov	dx,offset freexm	; Elv†laszt¢ szîveg c°me
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	cmp	word ptr [freehx],0	; Nulla ?
	jnz	short marvaf		; Nem, foglaltak m†r
	xor	dx,dx			; Ennyit kÇrek
	mov	ah,09h			; KÇrek blokkot
	call	dword ptr [xmsrut]	; XMS kezelî
	dec	ax			; Sikeres ?
	jnz	short marvaf		; Nem sikeres
	push	dx			; Elromlik
	mov	ah,8eh			; KÇrek inf¢t
	call	dword ptr [xmsrut]	; XMS kezelî
	inc	cx			; Ennyivel tîbb
	mov	[freehx],cx		; Szabadok sz†ma
	pop	dx			; Handle vissza
	mov	ah,0ah			; Visszaadom a blokkot
	call	dword ptr [xmsrut]	; XMS kezelî
marvaf:
	mov	ax,[freehx]		; Ennyi a szabad handle
	mov	dx,5			; Ennyi hosszan, nincs 0
	call	deckbp			; Ki°rjuk
	mov	bx,[xmskio]		; Kiolvas†si c°m
	mov	eax,[bx + 6]		; Ennyi a blokk
	jmp	short xmskii		; Ki°rom
nemfre:
	cmp	byte ptr [bx],0fdh	; XMS kezelî tot†l ?
	jnz	short nemfrt		; Nem, nem tot†l
	mov	dx,offset blksxm	; Elv†laszt¢ szîveg c°me
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	eax,[bx + 2]		; Ennyi a tot†l
	add	bx,10			; Od†bb
	mov	[xmskio],bx		; Elolvastam
	jmp	short xmskii		; Ki°rom
nemfrt:
	cmp	byte ptr [bx + 1],0	; Rîgz°tett ?
	mov	dx,offset locksz	; Ha rîgz°tett
	jnz	short rogziv		; Igen, rîgz°tett
	mov	dx,offset unlock	; Ha nem rîgz°tett
rogziv:
	call	crlfsz			; DOS h°v†s + sz†ml†l†s
	mov	ax,[bx + 6]		; Handle
	mov	dx,5			; Ennyi hosszan, nincs 0
	call	deckbp			; Ki°rjuk
	mov	eax,[bx + 2]		; MÇret
	add	bx,8			; Od†bb
	mov	[xmskio],bx		; Elolvastam
xmskii:
	mov	ebx,1024		; Ennyi hossz£ egy Kbyte
	mul	ebx			; Ez a hossz
	mov	cx,12			; Ilyen hosszan
	call	deceax			; Ki°rjuk EAX-et
xmself:
	call	crlfki			; Uj sor ind°t†s
	pop	bp			; Pointer vissza
	cmp	word ptr [emshnd],0ffffh; EMS kezelî elfogyott ?
	jz	short emsnit		; EMS elfogyott
elnefo:
	jmp	emshan			; MÇg nem fogyott el minden
emsnit:
	cmp	word ptr [xmshnd],0ffffh; XMS kezelî elfogyott ?
	jnz	short elnefo		; MÇg nem
	mov	bx,[xmskio]		; Kiolvas†si c°m
	cmp	word ptr [bx],0ffffh	; Kell mÇg kiolvasni ?
	jne	short elnefo		; Igen, kiolvasand¢ mÇg van
ninems:
	mov	ax,4c00h		; KilÇpÇs k¢dja
kilvim:
	push	ax			; Hibak¢d mentÇs
	lds	dx,dword ptr [int28t]	; Offszet
	mov	ax,ds			; Paragrafus
	or	ax,dx			; Offszet
	jz	short nemall		; Nem kell vissza†ll°tani
	mov	ax,2528h		; Vissza°rom
	int	21h			; DOS h°v†s
nemall:
	pop	ax			; Hibak¢d vissza
	int	21h			; DOS h°v†s (kilÇpÇs)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	IDLE megszak°t†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int28r:
	pushf				; Flag romlik
	test	byte ptr cs:[xmskeh],0ffh; Haszn†lj†k ?
	jnz	short nemhas		; Igen, Çn nem haszn†lhatom
	push	ds			; Elrontom
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	call	xmsido			; FeltîltÇs
	pop	ds			; Vissza
nemhas:
	popf				; Flag vissza
	jmp	dword ptr cs:[int28t]	; Megyek az eredeti helyre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	CTRL-BREAK rutin.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ctrlbr:
	push	ds			; Szegmensregiszter mentÇs
	push	ax			; Elrontom
	push	dx			; Elrontom
	lds	dx,dword ptr cs:[int28t]; Offszet Çs DS <- CS
	xor	ax,ax			; AX <- 0
	mov	[int28t + 2],ax 	; AX mentÇs
	mov	[int28t],ax		; BX mentÇs
	mov	ax,2528h		; Vissza°rom
	int	21h			; DOS h°v†s
	pop	dx			; Vissza
	pop	ax			; Vissza
	pop	ds			; Szegmensregiszter visszatîltÇs
	stc				; CARRY set (Ki kell lÇpni !)
	retf				; VisszatÇrek

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	XMS elîredolgoz†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xmsido:
	cmp	word ptr [xmshnd],0ffffh; Van mÇg mit csin†lni ?
	jz	short nemvan		; Nincs mit csin†lni
	inc	byte ptr [xmskeh]	; Haszn†lj†k
	cmp	byte ptr [xmskeh],1	; Haszn†lj†k ?
	jne	short decrem		; Igen, visszateszem
	pusha				; Elrontom
	mov	dx,[xmshnd]		; Ezzel oper†lok
	push	dx			; Kell kÇsîbb
	mov	ah,8eh			; Inform†ci¢kÇrÇs k¢dja
	call	dword ptr [xmsrut]	; Megh°vom az XMS kezelît
	dec	ax			; AX == 1 ?
	mov	ax,bx			; M†sikba
	mov	bx,[xmscim]		; Ide mutat
	pop	word ptr [bx + 6]	; Handle
	jnz	short hibaxm		; Nem, hiba volt
	mov	[freehx],cx		; Szabadok sz†ma
	mov	al,0			; Jelzî, hogy blokk
	mov	[bx],ax 		; T°pus
	mov	[bx + 2],edx		; Blokk mÇret
	add	bx,8			; Ennyivel od†bb
	mov	word ptr [bx],0ffffh	; Id†ig feltîltve jelzî
	mov	[xmscim],bx		; Ide mutat most m†r
hibaxm:
	mov	bx,offset xmshnd	; Itt v†ltoztatok
	inc	word ptr [bx]		; Kîvetkezî
	cmp	word ptr [bx],0ffffh	; Kîvetkezî lesz ?
	jne	short szamek		; Igen, mÇretkÇrdezÇs nem lesz
	mov	ah,88h			; MÇretlekÇrdezÇs k¢dja
	call	dword ptr [xmsrut]	; Megh°vom az XMS kezelît
	mov	bx,[xmscim]		; Ide mutat
	mov	[bx + 2],eax		; Legnagyobb mÇret
	mov	[bx + 6],edx		; Legnagyobb blokk mÇret
	dec	byte ptr [bx]		; Jelzem, hogy nincs tov†bb
	add	bx,10			; Ennyivel od†bb
	mov	word ptr [bx],0ffffh	; Id†ig feltîltve jelzî
	mov	[xmscim],bx		; Ide mutat most m†r
szamek:
	popa				; Vissza
decrem:
	dec	byte ptr [xmskeh]	; Nem haszn†lj†k
nemvan:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	AX ki°rat†sa hexadecim†lisan.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hexaax:
	push	ax			; AL miatt
	mov	al,ah			; Elîszîr AH
	call	hexaal			; AL kipakol†sa HEX-ben
	pop	ax			; AL vissza
hexaal:
	push	ax			; AL miatt
	mov	cl,4			; Ennyit lÇptetk le
	shr	al,cl			; LelÇptetjÅk
	call	felhex			; FÇl byte kitÇtel
	pop	ax			; Vissza
	and	al,00001111b		; Csak az als¢ 4 bit kell
felhex:
	call	xmsido			; Beolvasunk
	add	al,'0'                  ; Karakteres°tÅnk
	cmp	al,'9'                  ; Nem kell betÅkorrekci¢ ?
	jbe	short nemkor		; Nem, nem korrig†lok
	add	al,'@'-'9'              ; Ennyivel korrig†lok
nemkor:
	mov	dl,al			; Innen °rjuk ki

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Karakterki°rat†s DL-bîl.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kidosc:
	push	bp			; A pointer nem romolhat
	push	cx			; Ez a ciklusv†ltoz¢
	call	xmsido			; Beolvasunk
	mov	ah,2			; Ki°rat†s k¢dja
	int	21h			; DOS h°v†s
	inc	[kirhos]		; Megnîvelem
	pop	cx			; Ciklusv†ltoz¢ vissza
	pop	bp			; Pointer vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sz¢kîz ki°rat†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
spkii1:
	mov	cl,1			; Ennyit °rjon ki sz¢kîzbîl
spkiir:
	mov	ch,0			; Felsî byte null†z†s
	jcxz	short retcsa		; Ha nem kell semennyit ki°rni
spkici:
	mov	dl,' '                  ; Innen °rjuk ki a sz¢kîzt
	call	kidosc			; Ki°rjuk DL-t.
	loop	spkici			; Ciklusban a ki°rat†s
retcsa:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	CR-LF ki°rat†s. 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
crlfki:
	push	bp			; A pointer nem romolhat
	push	cx			; Ez a ciklusv†ltoz¢
	mov	dx,offset crlfku	; CR LF c°me
	call	crlfsz			; DOS h°v†s
	pop	cx			; Ciklusv†ltoz¢ vissza
	pop	bp			; Pointer vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Decim†lis ki°rat†s DX:AX-bîl.			;
;							;
;	Input:	EAX   <- A ki°ratand¢ ÇrtÇk		;
;		CX    <- A ki°rt†s hossza		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
deceax:
	mov	edx,eax 		; µtm†solom a felsî bitek miatt
	ror	edx,16			; DX:AX-be hossz
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Decim†lis ki°rat†s DX:AX-bîl.			;
;							;
;	Input:	DX:AX <- A ki°ratand¢ ÇrtÇk		;
;		CX    <- A ki°rt†s hossza		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
declon:
	xor	bp,bp			; Nincs semmi elîtte
	or	dx,dx			; Kell a long ?
	jne	short kellon		; Igen, mehet
	mov	dx,cx			; Darabsz†m
	jmp	short deckii		; Csak rîvid
kellon:
	push	cx			; Darab mentÇs
	push	ax			; L sz¢ mentÇs
;
; KÇt menetben elosztom 10.000-el. Elîszîr a H rÇsz osztom
;
	mov	ax,dx			; H sz¢
	mov	bx,10000		; Ez lesz az oszt¢
	xor	dx,dx			; Ez a vÇgejel
	div	bx			; Ez lesz a h†nyados
;
; H†nyados CX-be, maradÇd DX-be marad mint a H ÇrtÇkrÇsz
;
	mov	cx,ax			; Ennyi t°zezer
	pop	ax			; L sz¢ vissza
	div	bx			; Ez lesz a h†nyados
;
; AX Çs CX egyÅtt ad eredmÇnyt (CX:AX) darab 10.000 van
;
	jcxz	simrem			; Mint eddig £gy megy
	mov	bx,cx			; Ennyi t°zezer îsszesen (BX:AX)
	pop	cx			; Ennyi karakter
	push	dx			; MaradÇk eltÇtele ( < 10000 )
	mov	dx,bx			; Ennyi t°zezer îsszesen (DX:AX)
	mov	bx,10000		; Ez lesz az oszt¢
	div	bx			; Ez lesz a h†nyados
	push	dx			; MaradÇk eltÇtele ( < 10000 )
;
; ôsszesen 100.000.000 lett elosztva
;
	mov	dx,8			; Ennyivel csîkkentem
	sub	cl,dl			; Csak ennyi darab legyen
	jnc	short medams		; Ha nem lett emiatt hossz£
	mov	cl,0			; Nincs hossz
	mov	dl,4			; Nincs hossz
medams:
	mov	dx,cx			; Darabsz†m
	or	dh,cl			; Nem kell a nulla
	call	deckii			; Ki°rjuk a sz†zmill¢ ut†nit
	pop	ax			; Ez a 10.000 fîlîtti rÇsz
	mov	cl,0			; Nincs hossz
	mov	dl,4			; Nincs hossz
	call	deckii			; Ki°rjuk a sz†zmill¢ ut†nit
	mov	cl,0			; Nincs hossz
	mov	dl,4			; Nincs hossz
	jmp	short nakevt		; Ez a fîlîtte marad¢
simrem:
	pop	cx			; Ennyi karakter
	push	dx			; MaradÇk eltÇtele ( < 10000 )
	mov	dx,4			; Ennyivel csîkkentem
	sub	cl,dl			; Csak ennyi darab legyen
	jnc	short medami		; Ha nem lett emiatt hossz£
	mov	cl,0			; Nincs hossz
	mov	dl,4			; Nincs hossz
medami:
	push	dx			; MaradÇk hossz
	mov	dx,cx			; Darabsz†m
	or	dh,cl			; Nem kell a nulla
	call	deckii			; Ki°rjuk a tizezrest
	pop	dx			; Ennyi jeggyel kell
nakevt:
	pop	ax			; Ez a maradÇk jegy
deckii:
	call	xmsido			; Beolvasunk
	push	cx			; Ez el lesz rontva
	mov	cl,dl			; Ennyi jegyes legyen
	mov	bx,10			; Ez lesz az oszt¢
	mov	ch,bh			; CX <- darabsz†m
	mov	dl,0			; Ez a vÇgejel
	push	dx			; ElmentÇs
	mov	dh,0			; Igy kÇtszavas
ujosva:
	mov	dl,dh			; Igy kÇtszavas
rooshv:
	div	bx			; Ez lesz a soron kîvetkezî jegy
	or	dl,'0'                  ; KarakteresitÇs
	push	dx			; ElmentÇs
	jcxz	short mtonec		; Elsz†moltuk a hossz†t
	dec	cl			; Ennyi el lesz pakolva
mtonec:
	or	ax,ax			; Nulla a maradÇk ?
	jne	short ujosva		; Ujra elosztjuk
	jcxz	short vikkir		; Ha nincs elîjegy
elolop:
	mov	dl,'0'                  ; Karakter
	or	bp,bp			; Volt m†r karakter ?
	jne	short nemspi		; Igen, mehet
	mov	dl,' '                  ; Karakter
nemspi:
	call	kidosc			; Ki°rjuk DL-t.
	loop	elolop			; Elî-sz¢kîz ki°r¢ ciklus
vikkir:
	pop	dx			; Ez a kîvetkezî karakter
	or	dl,dl			; Nulla a karakter
	je	short vibede		; Igen visszatÇrÅnk
	pop	ax			; Elîzetes a kîvetkezîrîl
	or	al,al			; Utols¢ volt ?
	jne	short neutol		; Nem, mehet vissza
	or	ah,ah			; Lehet nulla ?
	js	short vibede		; Nem, nem is °rjuk ki
neutol:
	push	ax			; Vissza
	jne	short nelenk		; Nem, megnÇzzÅk
	or	al,al			; Utols¢ volt ?
	je	short nempro		; Igen, kitesszÅk
nelenk:
	or	bp,bp			; Volt m†r karakter ?
	jne	short nempro		; Igen, mehet
	cmp	dl,'0'                  ; Nulla karakter ?
	jne	short nempro		; Nem, mehet
	dec	bp			; Vissza a jelzî
	mov	dl,' '                  ; Csak sz¢kîzt °runk
nempro:
	inc	bp			; JelzÇs
	call	kidosc			; Ki°rjuk DL-t.
	jmp	short vikkir		; Tov†bbi ki°rat†sra
vibede:
	pop	cx			; Sz†ml†l¢ vissza
	ret				; VisszatÇrÇs

deckbp:
	push	bx			; Kell a kiolvas†sc°m
	push	bp			; Nem romolhat
	xor	bp,bp			; BP <- 0
	call	deckii			; Ki°rjuk
	pop	bp			; Pointer vissza
	pop	bx			; Pointer vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	LF sz†ml†l¢.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
crlfsz:
	call	xmsido			; Beolvasunk
	push	dx			; A pointer nem romolhat
	cmp	byte ptr [sordar],0ffh	; Display ?
	je	short nemsem		; Nem, ki°rathatjuk
innenf:
	push	bx			; A pointer nem romolhat
	mov	bx,dx			; Ez a szîveg
karell:
	mov	al,[bx] 		; Ez a karakter
	inc	bx			; Kîvetkezî c°m
	cmp	al,'$'                  ; VÇge a szîvegnek ?
	jne	short nemirh		; Nem, vizsg†ljuk
	pop	bx			; Pointer vissza
nemsem:
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	dx			; Pointer vissza
	ret				; VisszatÇrÇs
nemirh:
	cmp	al,0ah			; LF ?
	jne	short karell		; Nem, tov†bb
	dec	byte ptr [mardar]	; Egyel tîbb el fog menni
	jne	short karell		; Ha marad hely
	push	cx			; Elromlik
	mov	cx,bx			; Ez a karaktersor vÇge
	mov	bx,dx			; Elîrîl
kocara:
	mov	dl,[bx] 		; Ez a karakter
	inc	bx			; Kîvetkezî c°m
	cmp	bx,cx			; VÇge a szîvegnek ?
	je	short idaigk		; Igen, eddig kellet
	call	kidosc			; Ki°rjuk
	jmp	short kocara		; Kîvetkezîre
idaigk:
	pop	cx			; Vissza
	push	bx			; Ez a maradÇk
	mov	dx,offset folyle	; Szîvegc°m
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
ninkar:
	call	xmsido			; XMS lekÇrdezÇs
	mov	ah,0bh			; LeÅtÇsvizsg†lat k¢dja
	int	21h			; DOS h°v†s
	inc	al			; Van karakter ?
	jnz	short ninkar		; Ha nincs mÇg karakter
	mov	ah,8			; LeÅtÇskÇrÇs k¢dja
	int	21h			; DOS h°v†s
	or	al,al			; Nulla ?
	jne	short mehren		; Nem, mehetsz
	mov	ah,8			; LeÅtÇskÇrÇs k¢dja
	int	21h			; DOS h°v†s
mehren:
	mov	dx,offset folyto	; Szîvegc°m
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	dx			; C°m vissza
	pop	bx			; Mehet £jra
	mov	al,[sordar]		; Ennyi lehet
	dec	al			; Egyel kevesebbet lehet
	mov	[mardar],al		; Ennyi lehet
	jmp	short innenf		; Ki lehet most m†r °rni
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sz¢kîz kipakol†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
spkite:
	push	cx			; Ne romoljon
	mov	cx,dx			; Sz†ml†l¢ lett belîle
	mov	dl,' '                  ; Ez megy ki majd
emstav:
	call	kidosc			; Karakter ki
	loop	emstav			; Pakolom ki
	pop	cx			; Vissza az eredeti
	ret				; KÇsz, kitettem
;
sordar	db	0ffh			; Ennyi CRLF lehet
mardar	db	0ffh			; Ennyi CRLF volt
elcrke	db	0			; St†tusz

	even

nagytu	dw	9fffh			; HIGH hat†r
darabv	dw	10			; Ennyi darab vektor mehet
hatart	dw	0ffffh			; Ez a hat†r
mcbblk	dw	0			; MCB ÇrtÇke
xmsrut	dw	0,0			; XMS kezelî
int28t	dw	0,0			; IDLE megszak°t†s
emshnd	dw	0ffffh			; Nincs mit tenni
xmshnd	dw	0ffffh			; XMS kezdî handle
xmsver	dw	0			; XMS verzi¢ helye
xmscim	dw	memveg + emsmer 	; XMS pakol†s c°me
xmskio	dw	memveg + emsmer 	; XMS kiolvas†s c°me
freehx	dw	0			; XMS szabad handle sz†m
xmskeh	db	0			; XMS lekÇrdezÇs

kirhos	db	0			; Ennyi karakter volt
emsver	db	0			; EMS verzi¢

xmsexi	db	0ffh			; XMS nincs
emmszo	db	'EMMXXXX0',0            ; EMS neve
naszoc	db	'N/A      $'
freszo	db	'free     Max. cont. size: $'
frekov	db	' byte. $'
freems	db	' free $'
sumems	db	'total $'
versba	db	'Required at least DOS 3.00 !$'
tulsoh	db	'No enough memory !$'
merror	db	'Memory segmentation error !',0dh,0ah,'$'
fejlec	db	0dh,0ah
	db	'P'
	db	'S'
	db	'P'
	db	' '
	db	' blk MCB  bytes  owner    command line        '
	db	'hooked vektors$'
fejlev	db	'(4.13)'
	db	0dh,0ah
	db	'---- --- ---- ------ -------- ------------------- --$'
minuss	db	'---$'
spdrss	db	'   $'

fej15m	db	0dh,0ah
	db	'INT 15 free bytes: $'

hmavan	db	'HMA exists, $'

hmanin	db	'HMA not exists.$'

hmafog	db	'no free space.$'

hmafre	db	'available.$'

fejxmm	db	'status handle      bytes$'

fejxmf	db	'------ ------ ----------$'

fejems	db	'handle page     bytes$'

fejemk	db	'owner$'

fejemx	db	'     $'

fejeme	db	0dh,0ah,'EMS $'

fejemf	db	'    PAGE frame: $'

fejemu	db	'H                 $'

xmsfej	db	'XMS $'

xmsfef	db	'   Entry point: $'

kettop	db	':$'

fejemv	db	'------ ---- ---------$'

fejeml	db	'  --------$'

fejemy	db	'          $'

crlfku	db	0dh,0ah,'$'

folyle	db	0ah
	db	0dh,'Press any key to continue...$'

folyto	db	0dh,'                            ',0dh,'$'

tavols	db	'  $'

freexm	db	'free   $'

blksxm	db	'continuous  $'

locksz	db	'locked $'

unlock	db	'       $'

	even

memveg	label byte			; Ez az utols¢ c°m

code	ends
	end	start
