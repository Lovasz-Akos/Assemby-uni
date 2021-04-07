code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

nhossz	equ	16384			; Ennyi hossz£ a t rol¢
;
stbisz	equ	512			; STACK Biztons gi t vols g
;
segres = ((eddigt - start) + 10fh) / 16 ; Paragrafussz m
;
	org	80h

counte	db	?			; A sz ml l¢ by jt
	db	?			; A hat rol¢ helye
parsor	db	126 dup(?)		; A parancssor b jtjai

	org	100h
start:
	cld				; El‹refele csin lja
	mov	cl,[counte]		; CL <- darabsz m
	mov	ch,0			; CX <- darabsz m
	cmp	cx,2			; Ennyi van legal bb?
	jb	helple			; Ha nincs parancssor, help ki¡rat s
	xor	bp,bp			; Itt fogom gyûjteni a beolvasottakat
	mov	bx,10			; Ezzel szorozgatok
	mov	si, offset parsor	; Innen olvasok be
	dec	cx			; A hat rol¢ levonva
;
; Beolvasom a parancsssor karakter‚t
;
beolci:
	lodsb				; AL <- parancssor karakter
;
; Ellen‹rz‹m, hogy sz mjegy ASCII karakter-e
;
	cmp	al,'0'                  ; Enn‚l kisebb?
	jb	short helple		; Igen ez hiba
	cmp	al,'9'                  ; Enn‚l nagyobb?
	jbe	short karoke		; Nem, akkor megfelel
;
; Vagy nincs param‚ter, vagy nem j¢, vagy t£l nagy az ‚rt‚k
;
helple:
	mov	dx,offset helpsz	; A help sz”veg c¡me
	mov	cl,1			; Hibak¢d
	mov	ah,9			; A ki¡rat s k¢dja
	jmp	short kilhib		; Hib val kil‚pek
;
; Vagy nincs param‚ter, vagy nem j¢, vagy t£l nagy az ‚rt‚k
;
helpna:
	mov	dx,offset nagysz	; A t£l nagy sz”veg c¡me
	mov	cl,2			; Hibak¢d
kilhib:
	mov	ax,cs			; Hogy ha elromlott vissza lljon
	mov	ds,ax			; DS <- CS
	mov	ah,9			; A ki¡rat s k¢dja
	int	21h			; Ki¡rat s a DOS-sal
	mov	ah,4ch			; Kil‚p‚s k¢dja
	mov	al,cl			; Nem sikeres jelz‚ssel l‚pek ki
	int	21h			; DOS h¡v s kil‚p‚sre
;
; µtalak¡tom az ASCII karaktert numerikuss 
;
karoke:
	and	ax,0fh			; Csak az als¢ n‚gy ‚rt‚k maradjon
;
; Az eddig t rolt ‚rt‚ket megszorzom 10-el, majd hozz adom a sz mot
;
	xchg	bp,ax			; AX <- szorzand¢, BP <- sz mjegy
	mul	bx			; Megszorzom 10-el
	jc	short helpna		; T£l nagy lett
	add	bp,ax			; ™sszeadom a beolvasottal
	jc	short helpna		; T£l nagy lett
	loop	beolci			; Beolvas¢ ciklus
;
; Foglalok a stack-nek helyet
;
	mov	ah,4ah			; Hossz m¢dos¡t si k‚relem
	mov	bx,segres + 1000h	; A saj tom, + 64K stack
	int	21h			; K‚rem a DOS-t
	jc	short memhib		; Nincs el‚g hely
;
; Van el‚g mem¢ria az ”n ll¢ STACK sz m ra
;
	mov	[stackt],stbisz 	; Ez lesz az £j hat r
	mov	ax,es			; A jelenlegi hat r
	add	ax,segres		; Ennyivel eltolom
	mov	ss,ax			; Az £j szegmens
	mov	sp,0fffeh		; A legalja legyen
;
; Megn‚zem, van-e az adatnak is helye
;
	mov	ah,48h			; K‚rek egy £j blokkot
	mov	bx,1000h		; Az adatnak 64K
	int	21h			; K‚rem a DOS-t
	jc	short memhib		; Nincs el‚g hely
	mov	[eredci],0		; Kezd‹c¡m
	mov	[szamho],32768		; Sz mol si hossz
	mov	ds,ax			; Ez az adatr‚sz‚
	mov	es,ax			; Ez az adatr‚sz‚
;
; K‚sz a param‚ter beolvas sa.
; 1-re  ll¡tom az eredm‚nyterletet (0! ‚s 1! ‚rt‚ke)
;
memhib:
	mov	cx,cs:[szamho]		; Ennyi hosszan null zok
	dec	cx			; Egyel kevesebbet
	mov	di,cs:[eredci]		; Itt van az eredm‚ny
	mov	bx,di			; C¡mm solat (itt nem nulla)
	mov	ax,1			; 0!, 1! eset‚n ez az ‚rt‚k
	stosw				; Kitettem az 1-et
;
; Az 1 kit‚ve, a tov bbi terletet null zom
;
	dec	ax			; AX <- 0
	rep	stosw			; A t”bbit null zom
;
; Indul a sz m¡t s
; Input:  BP
; Output: Eredm‚nyterlet (cime az EREDCI-ben t rolva)
;
	cmp	bp,2			; Enn‚l kisebb?
	jb	short kesvan		; Nem, k‚sz is az eredm‚ny
	mov	di,1			; Ezzel kezdem
;
; Az eredm‚nyt rol¢t, meg kell szorozni a k”vetkez‹vel
;
faktci:
	inc	di			; Ezzel fog szorozni
	mov	cx,cs:[szamho]		; Ennyi elemb‹l  ll a ciklus
	mov	si,cs:[eredci]		; SI <- eredm‚nyt rol¢ c¡me
;
; El‹veszem az aktu lis eredm‚nyt
;
	xor	ax,ax			; Ezt teszem majd a hely‚re
	xchg	ax,[si] 		; AX <- a megszorzand¢
	jmp	short szorel		; Ind¡tom a szorz st
szorci:
	or	dx,dx			; Nulla lenne?
	jnz	szorto			; Nem, mehet tov bb
	cmp	bx,si			; El‚rte a v‚g‚t?
	jz	nitucs			; Igen, kil‚pek a ciklusb¢l
szorto:
	lodsw				; µtl‚pem az aktu list
	cmp	bx,si			; El‚rte a v‚g‚t?
	jae	nemmod			; Most nem kell m¢dos¡tani
	mov	bx,si			; Ez az £j v‚ge
nemmod:
	xchg	[si],dx 		; Hely‚re az eredm‚ny
	mov	ax,dx			; AX <- k”vetkez‹ szorzand¢
szorel:
	mul	di			; DX:AX <- szorozva
	add	[si],ax 		; Kiteszem a szorzat L r‚sz‚t
	adc	dx,0			; CY  tvitel
	loop	szorci			; Ciklusban
nitucs:
	cmp	bp,di			; El‚rte?
	jnz	short faktci		; Nem, m‚g csin lom
;
; Az eredm‚nyterleten tal lhat¢ ‚rt‚k ki¡rat sa
;
kesvan:
	mov	ax,cs:[szamho]		; Ennyi elemb‹l  ll a ciklus
	add	ax,ax			; Szavas a t rol¢
	add	cs:[eredci],ax		; Az eredm‚nyt rol¢ v‚g‚nek c¡me
	call	dekoki			; Az eredm‚nyt rol¢t ki¡ratom
	jnc	short nemtun		; Nem lett t£l nagy
	mov	dx,offset dekbaj	; A t£l nagy sz”veg c¡me
	mov	cl,3			; Hibak¢d
	jmp	kilhib			; Hibaki¡rat s
;
; K‚sz a ki¡r s, kil‚pek
;
nemtun:
	mov	ax,4c00h		; Sikeres jelz‚ssel l‚pek ki
	int	21h			; DOS h¡v s kil‚p‚sre
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Az eredm‚nyterlet ki¡rat sa decim lisan.	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
dekoki:
	xor	di,di			; Ennyi az elt rolt karaktersz m
	mov	cs:[dbkite],di		; Ennyi az elt rolt karaktersz m
	mov	bx,10			; Ennyivel osztogatok majd
kellme:
	xor	dx,dx			; Ez a H r‚sz els‹nek
	xor	bp,bp			; Nulla jelz‹
	mov	cx,cs:[szamho]		; Ennyi elemb‹l  ll a ciklus
	mov	si,cs:[eredci]		; Az eredm‚nyt rol¢ c¡me
	jmp	short meglep		; Kezdje az ellen‹rz‚st
modtta:
	dec	cs:[szamho]		; Egyel kevesebb
	mov	cs:[eredci],si		; A kisebb c¡m kipakol sa
meglep:
	add	si,-2			; Visszal‚pek, ez az utols¢ elem
	or	[si],bp 		; Nulla?
	loopz	modtta			; Igen, akkor nem osztogatom
	inc	cx			; Visszan”velem
egyosz:
	mov	ax,[si] 		; Az osztand¢
	div	bx			; Elosztom, AX <- h nyados
	mov	[si],ax 		; H nyados a hely‚re
	or	bp,ax			; Nulla vizsg lat is
	dec	si			; Visszafele egyet
	dec	si			; Visszafele ”sszesen kett‹t
	loop	egyosz			; Elosztom minden elem‚t
	mov	cx,di			; Ez a sz ml l¢
	and	cx,3			; Mit tegyek?
	jz	legals			; Ez az els”
	shl	cx,1			; L‚ptetem feljebb (2 szeres)
	shl	cx,1			; L‚ptetem feljebb (4 szeres)
	shl	dx,cl			; L‚ptetem feljebb
	pop	ax			; Vissza az el‹z‹
	or	dx,ax			; R m solom az el‹z‹eket
legals:
	push	dx			; Elmentem a marad‚kot
	inc	di			; No meg sz molom is
	jnz	nemnoh			; M‚g f‚r a 16 bitbe
	inc	cs:[dbkite]		; H r‚szen is n”velek
nemnoh:
	or	bp,bp			; Kell m‚g osztani?
	jz	sturic			; Nem, v‚ge van

;
; Megn‚zem, hogy maradt-e m‚g hely a stackben
;
	cmp	sp,cs:[stackt]		; El‚rte a bels‹ hat rt?
	jae	short kellme		; M‚g nem l¢g a stack-be
;
; Bizony elfogyott a hely
;
	add	di,3			; Ennyit tettem bele b jtokban
	jnc	short hnemno		; CY  tvitele
	inc	cs:[dbkite]		; Ennyi az elt rolt karaktersz m
hnemno:
	shr	cs:[dbkite],1		; CY <- a H r‚sz bitje
	rcr	di,1			; Csak a fele szavakban
	and	di,0fffeh		; A legals¢t eltntetem
	add	sp,di			; Eltntetem bel‹le
	stc				; Hibajelz‚s
	ret				; K‚sz a ki¡r s

;
; A h nyados nulla lett, j”het a ki¡rat s
;
sturic:
	mov	cx,di			; Ennyi a ciklus
	dec	cx			; Visszafele megyek
	and	cx,3			; Megn‚zem, hogy v lt s-e
	shl	cx,1			; L‚ptetem feljebb (2 szeres)
	shl	cx,1			; L‚ptetem feljebb (4 szeres)
	pop	dx			; Vissza a 4 sz mjegy
	jcxz	nempar			; Ha nincs l‚ptet‚s
	push	dx			; M‚g kell az eredeti
	shr	dx,cl			; A k”vetkez‹ l‚p alulra
nempar:
	and	dl,0fh			; Csak a sz mjegy maradjon
	or	dl,'0'                  ; Karakterr‚ konvert lom
	mov	ah,2			; DOS karakterki¡rat s k¢dja
	int	21h			; Karakterki¡rat s k‚r‚s
	dec	di			; Sz ml l¢t cs”kkentem
	jnz	short sturic		; Kiteszem a karaktereket
	or	cs:[dbkite],di		; Nulla van a H r‚szen?
	jz	egybev			; Igen, k‚sz vagyok
	dec	cs:[dbkite]		; H r‚szen is cs”kkentek
	jmp	short sturic		; Kiteszem a karaktereket
egybev:
	clc				; Hibajelz‚s nincs
	ret				; K‚sz a ki¡r s
;
helpsz	db	'Faktori lis sz m¡t¢.',10,13
	db	'Haszn lata: FAKTN ‚rt‚k', 10, 13, '$'
;
nagysz	db	'A k‚rt ‚rt‚k t£l nagy eredm‚nyt ad!', 10, 13
	db	'K‚rj‚l kisebbet.', 10, 13, '$'

dekbaj	db	'Kisz molni kisz moltam (bin risan), de nem tudom decim lisra alak¡tani!', 10, 13
	db	'K‚rj‚l kisebbet.', 10, 13, '$'
;
fogkel	equ	($ - start) and 1	; Sz¢ra igaz¡t s
;
	if	fogkel NE 0
;
	db	1			; Csak akkor foglalok, ha kell
;
	endif
;
dbkite	dw	0			; Darabsz m kiterjeszt‚s
;
szamho	dw	nhossz			; Ennyi hosszan sz molok
;
eredci	dw	eredpu			; A sz mol s c¡me
;
stackt	dw	stacke			; Itt t rolom a stack hat r t
;
eredpu	dw	nhossz dup (?)		; Itt gyûlik az eredm‚ny
;
eddigt	label	word
;
	db	stbisz dup(?)		; A STACK minimuma
;
stacke	label	word
;
code	ends
	end	start

