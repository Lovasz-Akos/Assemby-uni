code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

stbisz	equ	128			; STACK mÇret a rendszerh°v†shoz
;
segres = ((stacke - start) + 10fh) / 16 ; Paragrafussz†m
;
	.486
;
	org	80h

counte	db	?			; A sz†ml†l¢ by†jt
	db	?			; A hat†rol¢ helye
parsor	db	126 dup(?)		; A parancssor b†jtjai

	org	100h
start:
	cld				; Elãrefele csin†lja
	mov	sp,offset stacke	; Ez marad a STACK sz†m†ra
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
	mov	ax,cs			; Hogy ha elromlott vissza†lljon
	mov	ds,ax			; DS <- CS
	mov	ah,9			; A ki°rat†s k¢dja
	int	21h			; Ki°rat†s a DOS-sal
	mov	ah,4ch			; KilÇpÇs k¢dja
	mov	al,cl			; Nem sikeres jelzÇssel lÇpek ki
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
; MegnÇzem, hogy mennyi a hely
;
	mov	ah,4ah			; Meg akarom m¢dos°tan a helyemet
	mov	bx,0ffffh		; Ennyi £gy sem lesz
	int	21h			; KÇrem a DOS-t
	mov	ax,cs			; Ez a jelenlegi
	mov	cx,segres		; Ez a kÅlînbsÇg
	add	ax,cx			; Ez az £j szegmens
	mov	ds,ax			; Ez az adatrÇszÇ
	mov	es,ax			; Ez az adatrÇszÇ
	sub	bx,cx			; Ennyi maradt szegmensben
	and	ebx,0ffffh		; A felsã rÇsz tîrlÇse
	shl	ebx,2			; A hossz 4 b†jtosan
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
; KÇsz a paramÇter beolvas†sa.
; 1-re †ll°tom az eredmÇnyterÅletet (0! Çs 1! ÇrtÇke)
;
	xor	edi,edi 		; Az eredmÇny kezdãc°me
;
; A terÅletet null†zom, majd az elejÇre 1-et teszek
;
	xor	eax,eax 		; Ezt teszem ki a ciklusban
	mov	dx,ds			; Ez a szegmensem
tertor:
	mov	[di],eax		; Kitettem az 0-t
	add	di,4			; Tolom tov†bb
	jnz	short megtar		; Nem, mÇg nem az
	add	dx,1000h		; Eltolom 64K-t
	mov	ds,dx			; Ez az £j
megtar:
	dec	ebx			; Sz†ml†l¢ csîkkentÇse
	jnz	short tertor		; A tîbbit null†zom
;
; Egyel kisebb a dekodol†s eredmÇnyÇt t†rol¢ c°m
;
	add	di,-1			; Lecsîkkentem
	jc	short segnem		; A szegmenset nem kell
	add	dx,-1000h		; ÷gy vissza a szegmens
segnem:
	mov	cs:[tblcim],di		; A vÇgc°m offszetje
	mov	cs:[tblseg],dx		; A vÇgc°m szegmense
	xor	edi,edi 		; Itt lesz az eleje
	mov	bx,es			; Ez az eredeti
	mov	ds,bx			; DS is az eredeti
	inc	ax			; AX (EAX) <- 1
	mov	[di],ax 		; Kitettem az 1-et
	mov	cs:[hatcim],di		; A nem nulla offszetje
	mov	cs:[hatseg],ds		; A nem nulla szegmense
;
; Indul a sz†m°t†s
; Input:  EBP
; Output: EredmÇnyterÅlet DS szerint
;
	mov	edi,1			; Ezzel kezdem
nitucs:
	cmp	ebp,edi 		; EnnÇl kisebb?
	jbe	short kesvan		; Nem, kÇsz is az eredmÇny
;
; Az eredmÇnyt†rol¢t, meg kell szorozni a kîvetkezãvel
;
faktci:
	inc	edi			; Ezzel fog szorozni
	xor	si,si			; SI <- eredmÇnyt†rol¢ c°me
	mov	bx,es			; BX <- eredmÇnyt†rol¢ szegmense
	mov	ds,bx			; KezdjÅk a szegmenssel is
;
; Az elsã ÇrtÇk c°mÇnek Çs "elãzmÇnyÇnek" be†ll°t†sa
;
	xor	edx,edx 		; Ezt teszem majd a helyÇre
;
; Mehet a szorz†s ciklusa
;
meneve:
	xchg	[si],edx		; HelyÇre az eredmÇny
	mov	eax,edx 		; EAX <- kîvetkezã szorzand¢
szorel:
	mul	edi			; EDX:EAX <- EAX * EDI
;
; Gîrgetem az eredmÇnyt az alacsonyabb helyiÇrtÇkekre
;
	add	[si],eax		; Kiteszem a szorzat L rÇszÇt
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
	cmp	bx,cs:[hatseg]		; A null†k szegmense?
	jnz	short szorto		; Nem, mÇg nem az
	cmp	cs:[hatcim],si		; ElÇrte a null†kat?
	jz	short nitucs		; Igen, kilÇpek a ciklusb¢l
;
; Nem nulla amit szorozni kell, lÇpek a kîvetkezã c°mre
;
szorto:
	add	si,4			; µtlÇpem az aktu†list
	jnz	short cineto		; Nem kell †tlÇpni
	add	bx,1000h		; Eltolom 64K-t
	mov	ds,bx			; Ez az £j
;
; Az £j nagyobb mint az eddigi szorz†s hat†ra?
;
cineto:
	cmp	cs:[hatseg],bx		; A vÇgsã szegmens?
	ja	short meneve		; Nem, mÇg szorzok tov†bb
	jnz	short segnag		; Igen kell
	cmp	cs:[hatcim],si		; ElÇrte a vÇgÇt?
	jae	short meneve		; Nem, mÇg szorzok tov†bb
;
; Igen, akkor ez az £j hat†r
;
segnag:
	mov	cs:[hatcim],si		; A nem nulla offszetje
	mov	cs:[hatseg],ds		; A nem nulla szegmense
	dec	ecx			; Èj hat†r szÅletett
	js	elfhel			; Elfogyna a hely, vÇge lesz
	jmp	short meneve		; MÇg nem Çrt a vÇgÇre, szorz†s
;
; MegnÇzem, hogy van-e gond a darabsz†mmal
;
kesvan:
	add	ecx,-2			; Az elejÇn rîgtîn 1 van + hely
	js	elfhel			; Elfogyna a hely, vÇge lesz
;
; Az eredmÇnyterÅleten tal†lhat¢ bin†ris ÇrtÇk 10-es sz†mrendszerbe
;
	xor	edi,edi 		; Ennyi az elt†rolt karaktersz†m
	mov	ebx,10			; Ennyivel osztogatok majd
kellme:
	xor	edx,edx 		; Ez a H rÇsz elsãnek
	xor	ebp,ebp 		; Nulla jelzã
	mov	si,cs:[hatcim]		; Az eredmÇnyt†rol¢ c°me
	mov	cx,cs:[hatseg]		; Az eredmÇnyt†rol¢ szegmense
	mov	ds,cx			; M†solat
	jmp	short elfert		; Kezdje az ellenãrzÇst
;
; Megkeresem a nem nulla elsã ÇrtÇket
;
modtta:
	add	si,-4			; VisszalÇpek, ez az utols¢ elem
	jc	short rafert		; MÇg nem kell szegmenset
	add	cx,-1000h		; ÷gy vissza a szegmens
	mov	ds,cx			; LÇpek vissza
	mov	cs:[hatseg],cx		; A kisebb c°m szegmense
rafert:
	mov	cs:[hatcim],si		; A kisebb c°m offszetje
elfert:
	or	[si],ebp		; Nulla?
	jz	modtta			; Igen, akkor nem osztogatom
;
; Indul a terÅlet oszt†sa 10-el
;
egyosz:
	mov	eax,[si]		; Az osztand¢
	div	ebx			; Elosztom, EAX <- h†nyados
	mov	[si],eax		; H†nyados a helyÇre
	or	ebp,eax 		; Nulla vizsg†lat is
	mov	ax,es			; Ez a kezdã szegmens
	cmp	ax,cx			; ElÇrte ezt a szegmenst?
	jnz	short simdes		; Nem, akkor osztogatok tov†bb
	or	si,si			; ElÇrte az elejÇt?
	jz	short oszveg		; Igen, kÇsz az oszt†s
simdes:
	add	si,-4			; Visszafele egyet (4 b†jtot)
	jc	short egyosz		; MÇg nem m¢dosul a szegmens
	add	cx,-1000h		; ÷gy vissza a szegmens
	mov	ds,cx			; LÇpek vissza
	jmp	short egyosz		; Elosztom minden elemÇt
;
; Megvan a maradÇk, Çs a h†nyados is, egy fÇl b†jtba pakolom
;
oszveg:
	mov	si,cs:[tblcim]		; Itt van a dek¢dolt c°m
	mov	ds,cs:[tblseg]		; Ebben a szegmensben
	test	di,1			; Ez a sz†ml†l¢
	jz	short legals		; Ez az elsî
	shl	dl,4			; LÇptetem feljebb
	or	[si],dl 		; R†m†solom az elãzãeket
	mov	ax,ds			; Ez a szegmens
	or	si,si			; Nîveltem
	jnz	short demeve		; Nincs gond
	add	ax,-1000h		; ÷gy vissza a szegmens
	mov	cs:[tblseg],ax		; ÷gy vissza a szegmens
	mov	ds,ax			; Az ellenãrzÇshez
demeve:
	dec	si			; Elãzã c°mre
	mov	cs:[tblcim],si		; Itt van az £j c°m
	jmp	short nemgot		; Mehet a sz†ml†l†s, kitÇve
legals:
	mov	ax,si			; M†solat
	and	eax,3			; Egy dplasz¢ elejen lehet
	cmp	ax,3			; Most ment £j duplasz¢ra?
	jnz	short neduel		; Nem, akor nem vizsg†lom
;
; MegnÇzem, hogy maradt-e mÇg hely az osztand¢ elãtt
;
	xor	ax,si			; AX <-SI AND FFFC duplasz¢c°m
	cmp	dword ptr [eax],0	; ElÇrte a belsã hat†rt?
	jz	short neduel		; MÇg nem, Çrte el, tov†bbmehet
;
; Bizony elfogyott a hely
;
elfhel:
	mov	dx,offset dekbaj	; A t£l nagy szîveg c°me
	mov	cl,3			; Hibak¢d
	jmp	kilhib			; Hibaki°rat†s
neduel:
	mov	[si],dl 		; Elmentem a maradÇkot
nemgot:
	inc	edi			; No meg sz†molom is
	or	ebp,ebp 		; Kell mÇg osztani?
	jnz	kellme			; MÇg van mit, a h†nyados nem 0
;
; A h†nyados nulla lett, jîhet a ki°rat†s
;
	mov	ebp,edi 		; Darabsz†m m†solat
	mov	si,cs:[tblcim]		; Itt van a dek¢dolt c°m
	mov	ds,cs:[tblseg]		; Ebben a szegmensben
	xor	di,di			; A ki°r†s c°me
	test	bp,1			; P†ratlan?
	jnz	short alertk		; Kiteszem
	inc	ebp			; Mivel csîkkentem is
	inc	si			; Most nîvelni kell
	jmp	short nempar		; Kiteszem
kezcim:
	mov	al,[si] 		; Vissza a 4 sz†mjegy
	shr	al,4			; Alulra a magas ÇrtÇk
	and	al,0fh			; Csak a sz†mjegy maradjon
	or	al,'0'                  ; KarakterrÇ konvert†lom
	stosb				; Kiteszem a karaktert
	dec	ebp			; Egyet kitettem
alertk:
	lodsb				; Vissza a 2 sz†mjegy
	and	al,0fh			; Csak a sz†mjegy maradjon
	or	al,'0'                  ; KarakterrÇ konvert†lom
	stosb				; Kiteszem a karaktert
	or	si,si			; ElÇrte az elejÇt?
nempar:
	jnz	short nemcim		; Mehet, nincs szegmens v†lt†s
	mov	dx,ds			; Eddig ez volt
	add	dx,1000h		; A kîvetkezãre
	mov	ds,dx			; DS a kîvetkezãre
nemcim:
	cmp	di,0fffdh		; ElÇrt a vÇgÇre?
	jae	short akkoki		; Igen, ki°rat†s jîn
	mov	ax,es			; Innen olvasom
	mov	cx,ds			; Ide teszem
	cmp	ax,cx			; Ide Çrt
	jnz	short darano		; Mehet tov†bb
	cmp	si,di			; ElÇrte a ki°ratand¢t?
	jnz	short darano		; Nem, sz†ml†lok tov†bb
akkoki:
	call	stdowr			; Ki°rok
	xor	di,di			; A ki°r†s c°me
darano:
	dec	ebp			; Sz†ml†l¢t csîkkentem
	jnz	short kezcim		; Kiteszem a karaktereket
	or	di,di			; êppen kÇsz is volt?
	jz	short nemtun		; Igen, Çppen kÇsz is volt
	call	stdowr			; Ki°rok
;
; KÇsz a ki°r†s, kilÇpek
;
nemtun:
	mov	ax,4c00h		; Sikeres jelzÇssel lÇpek ki
	int	21h			; DOS h°v†s kilÇpÇsre
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A karakteres terÅlet ki°rat†sa			;
;	a STANDARD OUTPUT-ra.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stdowr:
	xor	dx,dx			; Az elejÇtãl
	mov	cx,di			; Ennyit kell
	mov	bx,1			; A standrd outputba
	push	ds			; Elrontom
	mov	ax,es			; Ide pakoltam
	mov	ds,ax			; A karakterek szegmense
	mov	ah,40h			; DOS ki°rat†s f†jlba k¢dja
	int	21h			; Ki°rat†s kÇrÇs
	pop	ds			; Vissza a beolvas†s szegmense
	ret				; KÇsz a ki°rat†s

;
helpsz	db	'Faktori†lis sz†m°t¢.', 13, 10
	db	'Haszn†lata: FAKT32 ÇrtÇk', 13, 10
	db	'Nagy ÇrtÇkeknÇl (> 50000) tîbb percig is sz†molhat!', 13, 10, '$'
;
nagysz	db	'A kÇrt ÇrtÇk t£l nagy eredmÇnyt ad!', 13, 10
	db	'KÇrjÇl kisebbet.', 13, 10, '$'

dekbaj	db	'Kisz†molni kisz†moltam (bin†risan), de nem tudom decim†lisra alak°tani!', 13, 10
	db	'KÇrjÇl kisebbet.', 13, 10, '$'
;
fogkel	equ	($ - start) and 3	; Sz¢ra igaz°t†s
;
	if	fogkel NE 0
;
	db	4 - fogkel dup (?)     ; Csak akkor foglalok, ha kell
;
	endif
;
vegcim	dw	?			; A terÅletemen t£li c°m
vegseg	dw	?			; A terÅletemen t£li szegmens
;
hatcim	dw	?			; A nem nulla c°me
hatseg	dw	?			; A nem nulla szegmense
;
tblcim	dw	?			; A decim†lis 4 bitek c°me
tblseg	dw	?			; A decim†lis 4 bitek szegmense
;
	db	stbisz dup(?)		; A STACK minimuma
;
stmara	equ	($ - start) and 15	; Paragrfusra igaz°t†s
;
	if	stmara NE 0
;
	db	16 - stmara dup (?)	; Csak akkor foglalok, ha kell
;
	endif
;
stacke	label	word
;
code	ends
	end	start

