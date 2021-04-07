code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	.486
;
versio	equ	 100			; Verzi¢sz†m (1.00)
;
kiisec	equ	3 * 18			; Ki°rat†s 3 m†sodpercenkÇnt
;
hndnum	macro
	hndver	%versio
	endm

vernum	macro
	defver	%versio
	endm

hndver	macro	vnum
	irpc	x,vnum
	db	'&x&'
	endm
	endm

defver	macro	vnum
num	=	0
	irpc	x,vnum
	db	'&x&'
	if	num eq 0
	db	'.'
	endif
num	=	num+1
	endm
	endm

;
	org	80h

counte	db	?			; A sz†ml†l¢ by†jt
	db	?			; A hat†rol¢ helye
parsor	db	126 dup(?)		; A parancssor b†jtjai

	org	100h
start:
	mov	ah,34h			; Aktivit†s kÇrdÇse
	int	21h			; DOS h°v†s
	mov	[dosakt],bx		; IT. offszet
	mov	[dosakt + 2],es 	; IT. szegmens
	mov	dx,offset connam	; A CON neve
	mov	ax,3d01h		; Megnyitjuk °r†sra
	int	21h			; DOS h°v†s
	mov	[handco],ax		; A CON f†jlsz†ma
;
; Az IT. vektorok kitîltÇse
;
	mov	ax,3508h		; IT. vektor tartalom lekÇrdezÇs
	int	21h			; DOS h°v†s
	mov	[int08c],bx		; IT. offszet
	mov	[int08c + 2],es 	; IT. szegmens
	mov	ax,3523h		; IT. vektor tartalom lekÇrdezÇs
	int	21h			; DOS h°v†s
	mov	[int23c],bx		; IT. offszet
	mov	[int23c + 2],es 	; IT. szegmens
;
; IT. vektor †tir†ny°t†sa
;
	mov	dx,offset int08r	; Ide mutasson
	cli				; IT. tilt†s
	mov	ax,2508h		; IT. vektor tartalom m¢dos°t†s
	int	21h			; DOS h°v†s
	mov	dx,offset int23r	; Ide mutasson
	mov	ax,2523h		; IT. vektor tartalom m¢dos°t†s
	int	21h			; DOS h°v†s
	sti				; IT. engedÇly
	cld				; Elãrefele csin†lja
	mov	cl,[counte]		; CL <- darabsz†m
	mov	ch,0			; CX <- darabsz†m
	cmp	cx,2			; Ennyi van legal†bb?
	jb	short helple		; Ha nincs parancssor, help
	xor	ebp,ebp 		; Itt fogom gy˚jteni
	mov	ebx,10			; Ezzel szorozgatok
	mov	si, offset parsor	; Innen olvasok be
	dec	cx			; A hat†rol¢ levonva
;
; Beolvasom a parancsssor karakterÇt
;
beolci:
	lodsb				; AL <- parancssor karakter
;
; Ellenãrzãm, hogy sz†mjegy ASCII karakter-e
;
	cmp	al,'0'                  ; EnnÇl kisebb?
	jb	short helple		; Igen ez hiba
	cmp	al,'9'                  ; EnnÇl nagyobb?
	jbe	short karoke		; Nem, akkor megfelel
;
; Vagy nincs paramÇter, vagy nem j¢, vagy t£l nagy az ÇrtÇk
;
helple:
	mov	dx,offset helpsz	; A help szîveg c°me
	mov	cl,1			; Hibak¢d
	mov	ah,9			; A ki°rat†s k¢dja
	jmp	short kilhib		; Hib†val kilÇpek
;
; Vagy nincs paramÇter, vagy nem j¢, vagy t£l nagy az ÇrtÇk
;
helpna:
	mov	dx,offset nagysz	; A t£l nagy szîveg c°me
	mov	cl,2			; Hibak¢d
kilhib:
	push	dx			; Elrontan†
	call	kiioff			; Kikapcsolom a szîvegeket
	pop	dx			; Vissza a szîvegc°m
	mov	ah,9			; A ki°rat†s k¢dja
	int	21h			; Ki°rat†s a DOS-sal
kiloke:

	call	helyre			; Visszaadom ami nem az enyÇm
	mov	al,cl			; KilÇpÇsi k¢d
	mov	ah,4ch			; KilÇpÇs DOS-ba k¢dja
	int	21h			; DOS h°v†s kilÇpÇsre
;
; µtalak°tom az ASCII karaktert numerikuss†
;
karoke:
	and	eax,0fh 		; Csak a sz†m ÇrtÇke maradjon
;
; Az eddig t†rolt ÇrtÇket megszorzom 10-el, majd hozz†adom a sz†mot
;
	xchg	ebp,eax 		; AX <- szorzand¢, BP <- sz†mjegy
	mul	ebx			; Megszorzom 10-el
	jc	short helpna		; T£l nagy lett
	add	ebp,eax 		; ôsszeadom a beolvasottal
	jc	short helpna		; T£l nagy lett
	loop	beolci			; Beolvas¢ ciklus
;
; MegnÇzem, hogy van-e EMS
;
	mov	dx,offset emmszo	; Ezt a file-t nyitjuk
	mov	ax,3d00h		; Megnyitjuk olvas†sra
	int	21h			; DOS h°v†s
	jc	short hibemm		; Ha nincs, ki°rjuk
	mov	bx,ax			; File-sz†m †tpakol†s
	mov	ax,4400h		; IOCTL h°v†s k¢dja
	int	21h			; DOS h°v†s
	test	dl,80h			; Eszkîz ?
	je	short hibemm		; Ez file, nincs EMS
	mov	ax,4407h		; IOCTL h°v†s k¢dja
	int	21h			; DOS h°v†s
	or	al,al			; Van EMS ?
	je	short hibemm		; Nincs EMS
	mov	ah,3eh			; CLOSE k¢dja
	int	21h			; DOS h°v†s
	mov	ah,46h			; EMS verzi¢ kÇrdÇs
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres a h°v†s ?
	jne	short hibemm		; Hib†s, nincs EMS
	cmp	al,32h			; BCD 3.2 verzi¢
	jae	short emmoke		; Hib†s, nincs EMS
hibemm:
	mov	dx,offset emsros	; Hib†s EMS szîveg c°me
	mov	cl,3			; Hibak¢d
	jmp	kilhib			; Mehet a hibaki°r†s
;
; Beolvasom a haszn†lhat¢ mÇretet
;
emmoke:
	mov	si,ax			; EltesszÅk a verzi¢t
	mov	ah,42h			; MÇretlekÇrdezÇs k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	hibemm			; Ha nem sikeres a h°v†s
;
; A mÇretet lefoglalom magamnak
;
	and	ebx,0fffch		; ÷gy 64K-s darabok lesznek
	je	short hibemm		; Ha nincs maradÇk
	mov	[darmar],ebx		; A mÇretet elt†rolom
	mov	ah,43h			; Szegmens open k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	short hibemm		; Ha nem sikeres a h°v†s
	mov	[hndems],dx		; Elpakoljuk a file-sz†mot
	cmp	si,40h			; Van 4.0 legal†bb ?
	jb	short ninanv		; Nincs
	mov	si,offset fakemh	; ä a tulajdonos
	mov	ax,5301h		; Tulajdonos be†ll°t†s k¢dja
	int	67h			; Tulajdonos kÇrdÇs
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	short hibemm		; Ha nem sikeres a h°v†s
ninanv:
	mov	ah,41h			; SzegmenskÇrÇs k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	short hibemm		; Ha nem sikeres a h°v†s
	mov	es,bx			; Ez az adatrÇszÇ
sivata:
	mov	ebx,[darmar]		; A mÇret 16K-s lapokban
	and	ebx,0ffffh		; A felsã rÇsz tîrlÇse
	shl	ebx,12			; A hossz 4 b†jtosan
	mov	[darmar],ebx		; Eltettem a mÇretet
	mov	eax,ebx 		; Ez a hossz m†solata
;
; Kisz†m°tom a hat†rt, azaz elosztom  (ln 16) / (ln 10) = (log 16)
; ÇrtÇkÇvel. Legfeljebb eddig terjedhet a szorzat.
; Ezt 25000/30103 ÇrtÇke (1.20412) kîzel°ti.
;
	mov	edi,25000		; Ennyivel szorzom
	mul	edi			; Megszoroztam (EDX:EAX)
	mov	edi,30103		; Ennyivel osztom
	div	edi			; EAX-ben a maxim†lis szorzat
	mov	ecx,eax 		; Darabsz†m maximum
;
; KÇsz a paramÇter beolvas†sa, szîvegkezdet
;
	xor	ebx,ebx 		; KezdãÇrtÇk
	mov	[hatter],ebx		; Kezdetben
	mov	byte ptr [consti],0	; Sz†ml†l¢
	mov	[teelis],offset faktke	; Ez a kîvetkezã feladat

;
; 1-re †ll°tom az eredmÇnyterÅletet (0! Çs 1! ÇrtÇke)
;
	xor	edi,edi 		; Az eredmÇny kezdãc°me
	mov	ebx,[darmar]		; Ez a darab 4 b†jtosan
tertor:
	call	edibea			; Be†ll°tom az oldal lekÇpzÇst
megtar:
	xor	eax,eax 		; Ezt teszem ki a ciklusban
	mov	cx,16384		; Ennyiszer 4 b†jt a 64K
	rep	stosd			; Kitettem az 0-t
	add	edi,10000h		; Eltoltam
	sub	ebx,16384		; Sz†ml†l¢ csîkkentÇse
	jnz	short tertor		; A tîbbit null†zom
	dec	edi			; Lecsîkkentem
	mov	[tblcim],edi		; A vÇgc°m offszetje
	xor	edi,edi 		; Itt lesz az eleje
	call	edibea			; Be†ll°tom az oldal lekÇpzÇst
	mov	al,1			; AL <- 1
	mov	es:[di],al		; Kitettem az 1-et
	mov	[hatcim],edi		; A nem nulla offszetje
;
; Indul a sz†m°t†s
; Input:  EBP
; Output: EredmÇnyterÅlet az EMS mem¢ri†ban
;
	mov	edi,1			; Ezzel kezdem
nitucs:
	cmp	ebp,edi 		; EnnÇl kisebb?
	jbe	short kesvan		; Nem, kÇsz is az eredmÇny
;
; Az eredmÇnyt†rol¢t, meg kell szorozni a kîvetkezãvel
;
	inc	edi			; Ezzel fog szorozni
	mov	[hatter],edi		; Hogy a h†ttÇr is boldoguljon
	xor	esi,esi 		; SI <- eredmÇnyt†rol¢ c°me
	call	esibea			; Be†ll°tom az oldal lekÇpzÇst
;
; Az elsã ÇrtÇk c°mÇnek Çs "elãzmÇnyÇnek" be†ll°t†sa
;
	xor	edx,edx 		; Ezt teszem majd a helyÇre
;
; Mehet a szorz†s ciklusa
;
meneve:
	xchg	es:[si],edx		; HelyÇre az eredmÇny
	mov	eax,edx 		; EAX <- kîvetkezã szorzand¢
szorel:
	mul	edi			; EDX:EAX <- EAX * EDI
;
; Gîrgetem az eredmÇnyt az alacsonyabb helyiÇrtÇkekre
;
	add	es:[si],eax		; Kiteszem a szorzat L rÇszÇt
	adc	edx,0			; CY †tvitel
;
; A tov†bbi ÇrtÇkek m†r ezzel futnak le. MegnÇzem, hogy
; kell-e egy†ltal†n tov†bb szorozgatni. (nem null†t kellene-e
; szorozgatni ÇrtelmetlenÅl, hossz£ ciklusban.) Ha nulla, vÇge a
; szorozgat†snak, azaz ciklusvÇg
;
szorci:
	or	edx,edx 		; Nulla lenne?
	jnz	short szorto		; Nem, mehet tov†bb
	cmp	[hatcim],esi		; ElÇrte a null†kat?
	jz	short nitucs		; Igen, kilÇpek a ciklusb¢l
;
; Nem nulla amit szorozni kell, lÇpek a kîvetkezã c°mre
;
szorto:
	add	esi,4			; µtlÇpem az aktu†list
;
; Az £j nagyobb mint az eddigi szorz†s hat†ra?
;
	cmp	[hatcim],esi		; ElÇrte a vÇgÇt?
	jae	short nemmod		; Most nem kell m¢dos°tani
;
; Igen, akkor ez az £j hat†r
;
	mov	[hatcim],esi		; A nem nulla offszetje
	dec	ecx			; Èj hat†r szÅletett
	js	short elfhel		; M†r el is fogyott
;
; Az £j c°m mÇg elÇrhetã sz†momra?
;
nemmod:
	or	si,si			; A c°m be†ll°t†s kell?
	jnz	short meneve		; Nem, mÇg nem kell
	call	esibea			; Be†ll°tom az oldal lekÇpzÇst
	jmp	short meneve		; MÇg nem Çrt a vÇgÇre, szorz†s
;
; MegnÇzem, hogy van-e gond a darabsz†mmal
;
kesvan:
	add	ecx,-2			; Az elejÇn rîgtîn 1 van + hely
	jns	short marhel		; Maradt mÇg hely
;
; Bizony elfogyott a hely
;
elfhel:
	mov	dx,offset dekbaj	; A t£l nagy szîveg c°me
	mov	cl,3			; Hibak¢d
	jmp	kilhib			; Hibaki°rat†s
;
; Az eredmÇnyterÅleten tal†lhat¢ bin†ris ÇrtÇk 10-es sz†mrendszerbe
;
marhel:
	call	kiioff			; Kikapcsolom a szîvegeket
	cmp	byte ptr [kiivol],0	; Volt ki°r†s jelzÇs?
	jz	short kiikih		; Nem volt, Çn sem °rok ki
	mov	bx,offset faktbe	; Szîvegki°rat†s c°me
	call	conras			; CON-ra kiteszem a szîveget
kiikih:
	xor	edi,edi 		; Ennyi az elt†rolt karaktersz†m
	mov	[hatter],edi		; Kezdetben
	mov	[elosmp],di		; Kezdetben
	mov	ebx,10			; Ennyivel osztogatok majd
	mov	[consti],bh		; Sz†ml†l¢
	mov	[teelis],offset dekrin	; Ez a kîvetkezã feladat
kellme:
	xor	edx,edx 		; Ez a H rÇsz elsãnek
	xor	ebp,ebp 		; Nulla jelzã
	mov	esi,[hatcim]		; Az eredmÇnyt†rol¢ c°me
	call	esibea			; Be†ll°tom az oldal lekÇpzÇst
	jmp	short elfert		; Kezdje az ellenãrzÇst
;
; Megkeresem a nem nulla elsã ÇrtÇket
;
modtta:
	add	esi,-4			; VisszalÇpek, ez az utols¢ elem
	cmp	si,0fffch		; ElÇrt a kîvetkezãre?
	jnz	short rafert		; Nem kell £j lekÇpzÇs
	call	esibea			; Be†ll°tom az oldal lekÇpzÇst
rafert:
	mov	[hatcim],esi		; A kisebb c°m offszetje
elfert:
	or	es:[si],ebp		; Nulla?
	jz	modtta			; Igen, akkor nem osztogatom

;
; Indul a terÅlet oszt†sa 10-el
;
egyosz:
	mov	eax,es:[si]		; Az osztand¢
	div	ebx			; Elosztom, EAX <- h†nyados
	mov	es:[si],eax		; H†nyados a helyÇre
	or	ebp,eax 		; Nulla vizsg†lat is
	or	esi,esi 		; ElÇrte az elejÇt?
	jz	short oszveg		; Igen, kÇsz az oszt†s
simdes:
	add	esi,-4			; Visszafele egyet (4 b†jtot)
	cmp	si,0fffch		; Az alja nulla volt?
	jnz	short egyosz		; MÇg nem m¢dosul a szegmens
	call	esibea			; Be†ll°tom az oldal lekÇpzÇst
	jmp	short egyosz		; Elosztom minden elemÇt
;
; Megvan a maradÇk, Çs a h†nyados is, egy fÇl b†jtba pakolom
;
oszveg:
	mov	si,[tcimta]		; Itt van a t†rol†si c°m
	test	di,1			; Ez a sz†ml†l¢
	jz	short legals		; Ez az elsî
	shl	dl,4			; LÇptetem feljebb
	or	[si],dl 		; R†m†solom az elãzãeket
	cmp	si,offset lapcim	; Nîveltem
	jnz	short demeve		; Nincs gond
	call	kimake			; Kim†solom a szegmenset
	jnz	elfhel			; Elfogyott a hely
	mov	si,offset lapcim + 16384; Itt folytassa
demeve:
	dec	si			; Elãzã c°mre
	mov	[tcimta],si		; Itt van az £j c°m
	jmp	short nemgot		; Mehet a sz†ml†l†s, kitÇve
legals:
	mov	[si],dl 		; Elmentem a maradÇkot
nemgot:
	inc	edi			; No meg sz†molom is
	mov	[hatter],edi		; A sz†ml†l¢ m†solata
	or	ebp,ebp 		; Kell mÇg osztani?
	jnz	kellme			; MÇg van mit, a h†nyados nem 0
	call	kimake			; Kim†solom az utols¢ szegmenset
	sub	[tcimta],offset lapcim	; Eddig °rta tele
	call	kiioff			; Kikapcsolom a ki°rat†st
;
; A h†nyados nulla lett, jîhet a ki°rat†s
;
sturic:
	mov	si,offset lapcim	; Ide dek¢doljon
	call	bemake			; Bem†solom az aktu†list
	mov	ebp,edi 		; Darabsz†m m†solat
	mov	di,[tcimta]		; Itt van a dek¢dolt tartalom
	test	bp,1			; P†ratlan?
	jnz	short nempar		; Kiteszem
	inc	di			; Kîvetkezã
kezcim:
	test	di,3fffh		; Itt folytatassa?
	jnz	short kezpvi		; Mehet, nincs szegmens v†lt†s
	call	bemake			; Bem†solom az aktu†list
	xor	di,di			; ElejÇrãl
kezpvi:
	mov	al,es:[di]		; Vissza a 2 sz†mjegy
	shr	al,4			; Alulra a magas ÇrtÇk
	and	al,0fh			; Csak a sz†mjegy maradjon
	or	al,'0'                  ; KarakterrÇ konvert†lom
	mov	[si],al 		; Kiteszem a karaktert
	inc	si			; Kitettem, h†t nîvelem
	dec	ebp			; Egyet kitettem
nempar:
	mov	al,es:[di]		; Vissza a 2 sz†mjegy
	inc	di			; Megnîvelem, mert dek¢doltam
	and	al,0fh			; Csak a sz†mjegy maradjon
	or	al,'0'                  ; KarakterrÇ konvert†lom
	mov	[si],al 		; Kiteszem a karaktert
	inc	si			; Kitettem, h†t nîvelem
	cmp	si,offset lapcim + 16383; Itt folytassa
	jb	short darano		; Nem, sz†ml†lok tov†bb
	call	stdowr			; Ki°rok
darano:
	dec	ebp			; Sz†ml†l¢t csîkkentem
	jnz	short kezcim		; Kiteszem a karaktereket
	call	stdowr			; Ki°rok
;
; KÇsz a ki°r†s, kilÇpek
;
	mov	cl,0			; Sikeres jelzÇssel lÇpek ki
	jmp	kiloke			; Sikeresen kilÇpek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A karakteres terÅlet ki°rat†sa			;
;	a STANDARD OUTPUT-ra.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stdowr:
	mov	dx,offset lapcim	; Az elejÇtãl
	mov	cx,si			; Ez a m†r meg°rt c°m
	sub	cx,dx			; CX <- darabsz†m
	jcxz	nimiki			; Nincs mit kivinni
	mov	bx,1			; A standrd outputba
	mov	ah,40h			; DOS ki°rat†s f†jlba k¢dja
	int	21h			; Ki°rat†s kÇrÇs
	mov	si,offset lapcim	; Az elejÇtãl
nimiki:
	ret				; KÇsz a ki°rat†s
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	64K lekÇpzÇse EDI szerint.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
edibea:
	push	edi			; Elrontan†m
	shr	edi,16			; Ez a 64K sorsz†ma
	shl	di,2			; Ez a 16K sorsz†ma
	cmp	[aktlek],di		; Ez van Çppen lekÇpezve?
	jz	short akvaed		; Igen, Çppen ez van
	mov	[aktlek],di		; Ez lesz lekÇpezve
	push	cx			; Elrontan†m
	push	bx			; Elrontan†m
	mov	cx,4			; Ennyiszer kell
lekmad:
	mov	ax,cx			; AL <- lapsz†m + 1
	dec	ax			; AL <- lapsz†m
	mov	bx,di			; Ez a lekÇpzendã lapsz†m
	mov	ah,44h			; MAP k¢dja
	mov	dx,[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	inc	di			; A kîvetkezã lap
	loop	lekmad			; Ha tîbb lapot kell lekÇpezni
	pop	bx			; Vissza a lapsz†m t†rol¢ja
	pop	cx			; Vissza a sz†ml†l¢
akvaed:
	pop	edi			; Vissza a c°m
	ret				; VisszatÇrÇs
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	64K lekÇpzÇse ESI szerint.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
esibea:
	push	esi			; Elrontan†m
	shr	esi,16			; Ez a 64K sorsz†ma
	shl	si,2			; Ez a 16K sorsz†ma
	cmp	[aktlek],si		; Ez van Çppen lekÇpezve?
	jz	short akvaep		; Igen, Çppen ez van
	mov	[aktlek],si		; Ez lesz lekÇpezve
	push	cx			; Elrontan†m
	push	bx			; Elrontan†m
	push	dx			; Elrontan†m
	mov	cx,4			; Ennyiszer kell
lekmas:
	mov	ax,cx			; AL <- lapsz†m + 1
	dec	ax			; AL <- lapsz†m
	mov	bx,si			; Ez a lekÇpzendã lapsz†m
	mov	ah,44h			; MAP k¢dja
	mov	dx,[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	inc	si			; A kîvetkezã lap
	loop	lekmas			; Ha tîbb lapot kell lekÇpezni
	pop	dx			; Vissza a lapsz†m t†rol¢ja
	pop	bx			; Vissza a lapsz†m t†rol¢ja
	pop	cx			; Vissza a sz†ml†l¢
akvaep:
	pop	esi			; Vissza a c°m
	ret				; VisszatÇrÇs
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A 16K-s lap kim†sol†sa az EMS-be.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kimake:
	push	cx			; Elrontan†m
	push	ebx			; Elrontan†m
	push	esi			; Elrontan†m
	push	edi			; Elrontan†m
	mov	ah,47h			; Save k¢dja
	mov	dx,[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	mov	ebx,[tblcim]		; Ez a c°me az eredmÇnynek
	shr	ebx,14			; ÷gy lapc°m lett belãle
	mov	ax,4400h		; A legals¢ lapra m†solom
	int	67h			; EMS h°v†s
	xor	di,di			; A cÇlterÅlet az 1. 16K
	xor	eax,eax 		; Ezt vizsg†lom
	mov	cx,4096 		; Ennyi lapb¢l †ll
	repe	scasd			; Mind nulla?
	jnz	short bajmas		; Nem mind nulla
	mov	si,offset lapcim	; A m†soland¢ terÅlet eleje
	xor	di,di			; A cÇlterÅlet az 1. 16K
	mov	cx,4096 		; 16K 4 b†jtosan
	rep	movsd			; Duplaszavas m†sol†s
	sub	dword ptr [tblcim],16384; Elãzã lap c°me
	mov	ah,48h			; Vissza†ll°t†s
	int	67h			; EMS h°v†s
	or	ah,ah			; St†tusz be†ll°t†s
bajmas:
	pop	edi			; Vissza a m†sol†s ut†n
	pop	esi			; Vissza a m†sol†s ut†n
	pop	ebx			; Vissza a m†sol†s ut†n
	pop	cx			; Vissza a m†sol†s ut†n
	ret				; M†solat
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A 16K-s lekÇpzÇse.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bemake:
	push	ebx			; Elrontan†m
	add	dword ptr [tblcim],16384; Elãzã lap c°me
	mov	ebx,[tblcim]		; Ez a c°me az eredmÇnynek
	shr	ebx,14			; ÷gy lapc°m lett belãle
	mov	ax,4400h		; A legals¢ lapra m†solom
	mov	dx,[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	pop	ebx			; Vissza a m†sol†s ut†n
simare:
	ret				; M†solat
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°rat†si teendã kikapcsol†sa.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiioff:
	mov	bx, offset simare	; KÇsz vagyok
	xchg	[teelis],bx		; Nincs feladat
	cmp	byte ptr [kiivol],0	; Volt ki°r†s jelzÇs?
	jz	short megnek		; Nem, akkor nem csin†lok semmit
	call	bx			; Az eredeti feladatot megh°vom
	mov	bx,offset crlfco	; CR LF ki°rat†s
	call	conras			; CON-ra kiteszem a szîveget
megnek:
	ret				; KÇsz a ki°rat†s kikapcsol†s
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Teendã elsã lÇpÇs dek¢dol†s alatt.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dekrin:
	mov	bx,offset dekszo	; Szîvegc°m
	jmp	short szofol		; Folytassuk ugyan £gy
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Teendã elsã lÇpÇs faktori†lissz†m°t†s alatt.	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
faktke:
	mov	bx,offset faktin	; Szîvegc°m
szofol:
	mov	byte ptr [kiivol],1	; Volt ki°r†s jelzÇs
	call	conras			; CON-ra kiteszem a szîveget
	mov	[teelis],offset faktko	; Ez a kîvetkezã feladat
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	V†ltoz¢ ki°rat†sa faktori†lis sz†m°t†s alatt.	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
faktko:
	mov	bx,offset bckspa	; Karakter a visszalÇpÇshez
	mov	cl,[consti]		; Sz†ml†l¢
	mov	ch,0			; H rÇsz tîrlÇs
	sub	bx,cx			; A kezdãc°m visszafele
	call	conras			; VisszalÇpkedek
	xor	cx,cx			; Kezdã darabsz†m
	mov	eax,[hatter]		; Ezt kell k°ratni
	mov	ebx,10			; Ennyivel osztok
megosz:
	xor	edx,edx 		; A H rÇsze
	div	ebx			; Elosztom 10-el
	or	dl,'0'                  ; KarakterrÇ a maradÇk
	push	dx			; Elmentem a karaktert
	inc	cx			; Sz†ml†l¢val kîvetem
	or	eax,eax 		; Kell mÇg
	jnz	megosz			; MÇg osztani kell
	mov	[consti],cl		; Sz†ml†l¢
megkar:
	mov	dx,sp			; Karakter
	push	cx			; A sz†ml†l¢ kÇsãbbre
	mov	cx,1			; Csak egyet
	call	conwri			; Kitettem
	pop	cx			; Vissza a sz†ml†l¢
	pop	dx			; A ki°rt kiÅr°tÇse
	loop	megkar			; Ki a tîbbi is
	ret				; KÇsz
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A BX kitÇtele a CON-ra. 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
conras:
	mov	dx,bx			; Itt fog kezdeni
kivaci:
	cmp	byte ptr [bx],0 	; VÇgjel ?
	jz	short conraw		; Igen, megvan
	inc	bx			; Megyek a c°men
	jmp	short kivaci		; Keressen tov†bb
conraw:
	mov	cx,bx			; A vÇgc°m
	sub	cx,dx			; CX <- darabsz†m
conwri:
	mov	bx,[handco]		; Ez a CON f†jlsz†m
	mov	ah,40h			; Ki°r†s f†jlba k¢dja
	int	21h			; A DOS-sal ki°r†sm a kÇpernyãre
	ret				; KÇsz a ki°r†s
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A timer IT. k¢drÇsze.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int08r:
	pushf				; ÷gy IT. szer˚ lesz belãle
	call	dword ptr cs:[int08c]	; Ez az eredeti feladat
	sti				; IT. jîhet
;
; A sz†ml†l¢ nîvelÇse
;
	inc	word ptr cs:[elosmp]	; Nîvelem a sz†ml†l¢t
;
; Ki°r†si hat†r vizsg†lat
;
	cmp	word ptr cs:[elosmp],kiisec; ElÇrte?
	jnz	short donect		; Nem most mÇg v†runk
;
; Lehetne ki°rni, szabad a DOS
;
	push	es			; DOS foglalts†gvizsg†lat miatt
	push	ebx			; DOS foglalts†gvizsg†lat miatt
	les	bx,dword ptr cs:[dosakt]; Aktivit†s FLAG
	cmp	byte ptr es:[bx],0	; Szabad a DOS?
	jz	short dossza		; Igen, szabad
;
; Nem szabad, visszakorrig†lok, hogy legkîzelebbi IT.-nÇl ki°rhasson
;
	dec	word ptr cs:[elosmp]	; Vissza, hogy bekîvetkezzen
	jmp	short donesz		; Mehet tov†bb
dossza:
	push	ds			; Ez romlik
	push	eax			; Ebbe teszem a H sz¢t
	push	ecx			; Ez is romlik
	push	edx			; Ez is romlik
	mov	ax,cs			; Szegmenslap
	mov	ds,ax			; Kitîltve
	call	word ptr [teelis]	; Teendã
	mov	word ptr [elosmp],0	; Kezdje elãrãl
	pop	edx			; Regiszter vissza
	pop	ecx			; Regiszter vissza
	pop	eax			; Regiszter vissza
	pop	ds			; Szegmensregiszter vissza
donesz:
	pop	ebx			; Regiszter vissza
	pop	es			; Szegmensregiszter vissza
donect:
	iret				; KÇsz vagyok
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	CNTRL BREAK reag†l†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int23r:
	push	ds			; Elromlik
	push	es			; Elromlik
	pusha				; Mentegetek
	mov	ax,cs			; Szegmenslap
	mov	ds,ax			; Kitîltve
	call	helyre			; Mindent †ll°tsunk helyre
	popa				; Vissza
	pop	es			; Szegmens vissza
	pop	ds			; Szegmens vissza
	stc				; Ki kell lÇpni jelzÇs
	retf				; VisszatÇrÇs jelzÇssel
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Helyre†ll°tom a v†ltoztat†sokat.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
helyre:
	mov	dx,[hndems]		; Ez a file-sz†m
	or	dx,dx			; Ez Çlã?
	jz	short nefoem		; Nem, nincs foglalva
	mov	ah,45h			; Visszad†s k¢dja
	int	67h			; EMS h°v†s
nefoem:
	xor	ax,ax			; AX <- vektorok szegmense
	mov	es,ax			; ES <- vektorterÅlet
	mov	ax,cs			; Ez a szegmensem
nemazv:
	sti				; M†r lehet IT.
	nop				; Itt jîhet az IT.
	cli				; IT. nem lehet
	cmp	word ptr es:[8 * 4],offset int08r ; Ez van ott ?
	jne	short nemazv		; Nem, nem vesszÅk ki
	cmp	word ptr es:[(8 * 4) + 2],ax ; Ez van ott ?
	jne	short nemazv		; Nem, nem vesszÅk ki
	cmp	word ptr es:[23h * 4],offset int23r ; Ez van ott ?
	jne	short nemazv		; Nem, nem vesszÅk ki
	cmp	word ptr es:[(23h * 4) + 2],ax ; Ez van ott ?
	jne	short nemazv		; Nem, nem vesszÅk ki
	mov	ax,[int08c]		; Offszet
	mov	es:[8 * 4],ax		; Offszet ki
	mov	ax,[int08c + 2] 	; Szegmens
	mov	es:[(8 * 4) + 2],ax	; Szegmens ki
	mov	ax,[int23c]		; Offszet
	mov	es:[23h * 4],ax 	; Offszet ki
	mov	ax,[int23c + 2] 	; Szegmens
	mov	es:[(23h * 4) + 2],ax	; Szegmens ki
	sti				; M†r lehet IT.
	ret				; Helyre†ll°t†s kÇsz
;
fakemh	db	'FAKT!'                 ; EMS handle tulajdonos szîveg
	hndnum				; Verzi¢ a handle-hoz
;
emmszo	db	'EMMXXXX0',0            ; EMS neve
;
connam	db	'CON', 0                ; A CONSOLE perifÇria neve
;
emsros	db	'EMS hiba, vagy nem megfelelã verzi¢ !', 13, 10, '$'
;
helpsz	db	'Faktori†lis sz†m°t¢.', 13, 10
	db	'Haszn†lata: FAKTEMS ÇrtÇk', 13, 10
	db	'Nagy ÇrtÇkeknÇl (> 50000) tîbb percig is sz†molhat!', 13, 10, '$'
;
nagysz	db	'A kÇrt ÇrtÇk t£l nagy eredmÇnyt ad!', 13, 10
	db	'KÇrjÇl kisebbet.', 13, 10, '$'

dekbaj	db	'Kisz†molni kisz†moltam (bin†risan), de nem tudom decim†lisra alak°tani!', 13, 10
	db	'KÇrjÇl kisebbet.', 13, 10, '$'

faktin	db	13, 'Faktori†lis sz†m°t†s: ', 0
;
dekszo	db	13, 'Az eddig dek¢dolt sz†mjegyek sz†ma: ', 0
;
faktbe	db	'A faktori†lis kisz†m°t†sa (bin†risan) kÇsz, dek¢dol†s kîvetkezik.', 13, 10, 0
;
	db	13 dup(8)		; VisszalÇpÇsek
bckspa	db	0
;
crlfco	db	13, 10, 0
;
kiivol	db	0			; Ki°r†s jelzÇs
consti	db	?			; A ki°r†s hossza
;
fogkel	equ	($ - start) and 1	; Sz¢ra igaz°t†s
;
	if	fogkel NE 0
;
	db	0			; Eltolom sz¢ra
;
	endif
;
teelis	dw	simare			; Nincs teendã
hndems	dw	0			; Handle t†rol¢
elosmp	dw	0			; A sz†ml†l¢
aktlek	dw	0ffffh			; A lekÇpzÇs jelenleg
tcimta	dw	lapcim + 16383		; A terÅlet c°me
handco	dw	?			; A CON f†jlsz†ma
dosakt	dw	?, ?			; A DOS foglalts†gi bit
;
fogdup	equ	($ - start) and 2	; Dupla sz¢ra igaz°t†s
;
	if	fogdup NE 0
;
	dw	?			; Eltol†s duplasz¢ra
;
	endif
;
int08c	dw	?,?			; 8-as vektor tartalma
;
int23c	dw	?,?			; 8-as vektor tartalma
;
darmar	dd	?			; Az EMS mÇrete 16K-s lapokban
;
hatcim	dd	?			; A nem nulla c°me
;
tblcim	dd	?			; A decim†lis 4 bitek c°me
;
hatter	dd	?			; Ezt °rogatja ki
;
lapcim	label	dword
	db	16384 dup(?)		; 16K-s EMS lapt†rol¢
;
code	ends
	end	start

