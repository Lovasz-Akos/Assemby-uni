code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

verzio	equ	 107			; Verzi¢sz†m (1.07)

hndnum	macro
	hndver	%verzio
	endm

vernum	macro
	defver	%verzio
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
num	=	num + 1
	endm
	endm

datum	macro	datstr

ev	=	0
honap	=	0
nap	=	0
cikl	=	0

	irpc	elem, datstr
	if	((cikl eq 1) or (cikl eq 2))
honap = (honap * 10) + elem
	endif
	if	((cikl eq 4) or (cikl eq 5))
nap   = (nap * 10) + elem
	endif
	if	((cikl eq 7) or (cikl eq 8))
ev    = (ev * 10) + elem
	endif
cikl = cikl + 1
	endm

datdef	record	evdef:6 = ev - 80, hodef:4 =honap ,napdef:5 = nap

	endm

	datum	%??date

	ifdef	sysdef
	dw	0ffffh,0ffffh		; Igy most SYS-nek megfelelî
	else
	jmp	start			; Ha COM, itt kezdîdjîn !
	nop				; Helyfoglal†s (°gy 4 byte !)
	endif

attrw	dw	800h			; Lemez ATTRIBUTUM sz¢
	dw	parelv			; Puffer-rutin c°me
	dw	keruti			; Kezelî rutin c°me
	db	1			; Egy egysÇget gener†lunk

csekod	db	1			; Cserejelzî
bpbpoi	dw	bpbofs			; Pointer a BPB-re
bufcim	dw	0,0			; A parancsor c°me
xmsrut	dw	0ffffh,0ffffh		; XMS rutin c°mt†r
jmppos	dw	0ffffh,0ffffh		; Ide mutat az offszet
extruc	dw	0,0			; XMS h°v†s helye
xmshnd	dw	0ffffh			; XMS handle (c°m)
memlei	dw	0,0,0,0,0,0,0,0 	; Mem¢ria le°r¢t†bla
kodofs	db	0			; Ez a rîvid JMP offszetje

boots	label	word
	jmp	short $ 		; BOOT ugr†s !
	nop				; BOOT NOP !
	db	'K. PÇter'              ; Azonos°t¢

bpbofs	label	word

	dw	512			; Ennyi byte-os a szektor
	db	0			; Ez a cluster-hossz
	dw	1			; Foglalt hossz
	db	1			; FAT sz†m
	dw	64			; BejegyzÇssz†m
	dw	0			; Szektorsz†m
	db	0f8h			; T°pusjelzî
	dw	1			; FAT hossz
	dw	1			; Egy track szektorsz†ma
	dw	1			; Oldalsz†m
	dw	0			; Rejtett szektorok sz†ma
	db	8			; Hatv†nysz†m (2**8 = 512)

drvtip	db	2			; T°pusjelzî

jmptab	dw	rdinit			; 0-†s	INIT
	dw	csreke			; 1-es	Csere vizsg†lat
	dw	bpbker			; 2-es	PBP kÇrdezÇs
	dw	egyhib			; 3-as	Hib†ra egybîl
	dw	secrea			; 4-es	Olvas†s
	dw	sivime			; 5-îs	Vissza egybîl
	dw	sivime			; 6-os	Vissza egybîl
	dw	sivime			; 7-es	Vissza egybîl
	dw	secwri			; 8-as	Ir†s
	dw	secwri			; 9-es	Ir†s + ôH
	dw	sivime			; 10-es Vissza egybîl
	dw	sivime			; 11-es Vissza egybîl
	dw	sivime			; 12-es Vissza egybîl
	dw	sivime			; 13-as Vissza egybîl
	dw	sivime			; 14-es Vissza egybîl
	dw	opcser			; 15-îs ismertelen


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancspuffer elvÇtele. 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
parelv:
	mov	cs:[bufcim],bx		; Ez az offszet
	mov	cs:[bufcim + 2],es	; Ez a paragrafusc°m
	retf				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Eszkîzkezelî rutin.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
keruti:
	push	si			; SI mentÇs
	push	ax			; AX mentÇs
	push	cx			; CX mentÇs
	push	dx			; DX mentÇs
	push	di			; DI mentÇs
	push	bp			; BP mentÇs
	push	ds			; DS mentÇs
	push	es			; ES mentÇs
	push	bx			; BX mentÇs
	lds	bx,dword ptr cs:[bufcim]; DS:BX <- pufferc°m
	mov	cx,[bx + 12h]		; CX <- 1. paramÇter
	mov	dx,[bx + 14h]		; DX <- 2. paramÇter
	mov	al,[bx + 2]		; Parancsk¢d
	cmp	al,15			; Nagyobb ann†l ?
	ja	egyhib			; Igen, hibajelzÇsre
	mov	si,offset jmptab	; Itt van a t†bl†zat
	cbw				; AX <- 0000 + AL
	shl	ax,1			; Egy bejegyzÇs 2 byte
	add	si,ax			; Eltol†s
	les	di,[bx + 0eh]		; ES:DI <- pufferc°m
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	jmp	[si]			; Ugr†s a funkci¢ra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	3-as parancsk¢d.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
egyhib:
	mov	al,3			; Hibak¢d
	jmp	short hitako		; HibajelzÇsre
nesimu:
	lds	bx,dword ptr cs:[bufcim]; DS:BX <- pufferc°m
	mov	word ptr [bx + 12h],0	; Ennyit mozgatott !!!
hitako:
	mov	ah,81h			; Hiba + befejezve
	jmp	short nesive		; VisszatÇrÇsre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	1-es parancsk¢d. Csere ellenîrzÇs.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
csreke:
	lds	bx,dword ptr [bufcim]	; DS:BX <- pufferc°m
	mov	al,1			; Nincs csere k¢dja
	xchg	cs:[csekod],al		; Ez megy ki ?
	mov	[bx + 14],al		; Ez a csere k¢dja
sivime:
	mov	ah,1			; Sikeres k¢dja
nesive:
	lds	bx,dword ptr cs:[bufcim]; DS:BX <- pufferc°m
	mov	[bx + 3],ax		; K¢d kipakol†s
	pop	bx			; BX vissza
	pop	es			; ES vissza
	pop	ds			; DS vissza
	pop	bp			; BP vissza
	pop	di			; DI vissza
	pop	dx			; DX vissza
	pop	cx			; CX vissza
	pop	ax			; AX vissza
	pop	si			; SI vissza
	retf				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	2-es parancsk¢d. BIOS paramÇterblokk kÇrÇs.	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bpbker:
	lds	bx,dword ptr [bufcim]	; DS:BX <- pufferc°m
	mov	word ptr [bx + 12h],offset bpbofs; BPB offszet
	mov	[bx + 14h],cs		; BPB paragrafus
	jmp	sivime			; Sikeres befejezÇsre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	15-îs parancsk¢d. Csere lekÇrdezÇs.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
opcser:
	mov	ax,0300h		; Nem cserÇlhetî k¢dja
	jmp	nesive			; VisszatÇrÇsre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	4-es parancsk¢d. Szektor(ok) olvas†sa.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
secrea:
	xor	bh,bh			; Olvas†s k¢dja
kozoio:
	call	secbhm			; Szektor I/O
	jnc	sivime			; Sikeres befejezÇsre
	jmp	nesimu			; Nem sikeres

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	8-as parancsk¢d. Szektor(ok) °r†sa.		;
;	9-es parancsk¢d. Szektor(ok) °r†sa,		;
;			 majd ôH (ezt el is hagyjuk !)	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
secwri:
	mov	bh,1			; Ir†s k¢dja
	jmp	short kozoio		; A kîzîs I/O-ra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szektor I/O.					;
;							;
;	Input:	BH    <- 0 --> olvas†s			;
;		BH    <- 1 --> °r†s			;
;		CX    <- szektorsz†m			;
;		DX    <- Kezdî szektor			;
;		ES:DI <- puffer 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
secbhm:
	cmp	dx,[bpbofs + 8] 	; Szektorsz†m
	jc	elfebe			; Ha nem t£l nagy
nikodi:
	mov	al,8			; Hibak¢d
	stc				; Hibajelzî flag
	ret				; VisszatÇrÇs
elfebe:
	mov	ax,dx			; AX <- kezdet
	add	ax,cx			; AX += hossz
	cmp	ax,[bpbofs + 8] 	; Szektorsz†m
	ja	nikodi			; Ha t£l nagy
	mov	ax,cx			; Hossz
	mov	cl,byte ptr [bpbofs + 19]; Hatv†nysz†m
	shl	ax,cl			; AX <- ennyi szektor
	jnc	tulnyu			; Ha belefÇrt AX-be
	mov	ax,8000h		; Ez a maximum most
tulnyu:
	mov	cx,ax			; Uj hossz (sz¢ban)
	mov	ax,dx			; Kezdet
	mul	word ptr [bpbofs]	; Szektor byte-sz†m

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	EXTENDED mem¢ria kezelî.			;
;							;
;	Input:	DX:AX <- kezdî poz°ci¢			;
;		BH    <- 0 --> olvas†s			;
;		BH    <- 1 --> °r†s			;
;		CX    <- sz¢sz†m			;
;		ES:DI <- puffer 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xmskez:
	mov	si,offset memlei	; Le°r¢t†bla kezdîc°m
	shl	cx,1			; CX <- byte-sz†m
	mov	cs:[si],cx		; A hossz als¢ szava
	mov	word ptr cs:[si + 2],0	; A hossz felsî szava
	or	bh,bh			; Ir†s kell ?
	jne	iraxms			; Igen, °runk
	mov	bx,[xmshnd]		; XMS handle (c°m)
	mov	cs:[si + 4],bx		; XMS forr†s c°m
	mov	cs:[si + 6],ax		; XMS H sz¢ 16 bit
	mov	cs:[si + 8],dx		; XMS L sz¢ 16 bit
	mov	word ptr cs:[si + 10],0 ; Forr†s (az elsî 1 Mbyte)
	mov	cs:[si + 12],di 	; Forr†s offszet
	mov	cs:[si + 14],es 	; Forr†s paragrafus
	jmp	short csimex
iraxms:
	mov	word ptr cs:[si + 4],0 ; Forr†s (az elsî 1 Mbyte)
	mov	cs:[si + 6],di		; CÇl offszet
	mov	cs:[si + 8],es		; CÇl paragrafus
	mov	bx,[xmshnd]		; XMS handle
	mov	cs:[si + 10],bx 	; XMS cÇl c°m
	mov	cs:[si + 12],ax 	; XMS H sz¢ 16 bit
	mov	cs:[si + 14],dx 	; XMS L sz¢ 16 bit
csimex:
	mov	ah,0bh			; XMS move k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî h°v†s
	shr	ax,1			; AL <- vÇgrehajt†si k¢d
	cmc				; CY <- 0 ha sikeres
	ret				; VisszatÇrÇs

hikehe:
	jmp	short atlhel		; ètlÇpÇs
	db	3 dup(90h)		; Ezt v†rja az XMS (3 db NOP)
atlhel:
	cmp	ax,0140h		; Ez a hiv¢k¢d ?
	je	nebehi			; Igen, nem belsî h°v†s
eltahi:
	jmp	dword ptr cs:[extruc]	; XMS belsî (jmp short helye)
nebehi:
	push	ax			; AX mentÇs
	push	bx			; BX mentÇs
	push	dx			; DX mentÇs
	mov	ah,8			; XMS mÇretlekÇrdezÇs k¢dja
	call	dword ptr cs:[xmsrut]	; XMS kezelî h°v†s
	mov	ax,dx			; Amit visszaad
	pop	dx			; Ez volt az eredeti
	cmp	ax,dx			; Azonosak ?
	pop	bx			; BX vissza
	pop	ax			; AX vissza
	jne	eltahi			; Ha nem azonosak ismÇtlÇs
	xor	ax,ax			; Ha nem sikerÅlt
	mov	bl,91h			; XMS Åzenet szimul†l†s
	retf				; VisszatÇrÇs

	if	($ - xmskez) AND 1	; Ha a hossz p†ratlan
xmskev	equ	$ + 1			; Akkor egyel hosszabb
	else
xmskev	equ	$			; Ha nem, akkor itt a vÇge
	endif

	dw	376 dup (0)		; Hely a kezelÇsre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	AX decim†lis ki°rat†sa. 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
decoax:
	cmp	byte ptr cs:[dumtip],0	; Csîndben ?
	jnz	nemacs			; Vissza, csîndben vagyunk
	mov	cx,10			; Ez az oszt¢
	xor	dx,dx			; H sz¢ <- 0
	div	cx			; Elosztjuk 10-el
	or	ax,ax			; Nincs meg benne ?
	je	makiki			; Nincs, DX <= 9
	push	dx			; A maradÇkot mentem
	call	decoax			; Rekurzi¢ !!!
	pop	dx			; MaradÇk vissza
makiki:
	add	dl,'0'                  ; Karakteres°tÇs
	mov	ah,2			; Karakterki°r†s k¢dja
	int	21h			; DOS h°v†s
nemacs:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	0-†s parancsk¢d. Eszkîz inicializ†l†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
rdinit:
	mov	ds:[0],0ffffh		; Nincs kîvetkezî 1.
	mov	ds:[2],0ffffh		; Nincs kîvetkezî 2.
	mov	[szacit + 2],cs 	; K¢d szegmens mentÇs
	mov	[bpbpar],cs		; K¢d szegmens mentÇs
	cld				; Nîvekvî stringmÅveletek
	mov	ah,30h			; Verzi¢sz†m kÇrÇs k¢dja
	int	21h			; DOS h°v†s
	xchg	ah,al			; Fî Çs al verzi¢sz†m csere
	mov	[versio],ax		; Elpakoljuk
	cmp	ax,0500h		; EnnÇl kisebb ?
	jb	tulkiv			; Igen, ez baj
	cmp	ah,07h			; EnnÇl nagyobb ?
	jbe	nekero			; Nem, mehet egybîl
tulkiv:
	mov	dx,offset vershi	; Szîvegc°m
	jmp	nesipr			; KilÇpÇs
nekero:
	lds	si,dword ptr [bufcim]	; DS:SI <- parancssor
	mov	al,[si + 16h]		; Ez az egysÇgsz†m
	add	cs:[drvsam],al		; DRIVE sz†m
	lds	si,[si + 12h]		; Parancssor pointere
szokat:
	lodsb				; Karakterbeolvas†s
	cmp	al,' '                  ; Sz¢kîz ?
	je	szokat			; Igen, †tugorjuk
	cmp	al,9			; Tabul†tor ?
	je	szokat			; Igen, †tugorjuk
	cmp	al,','                  ; Vesszî ?
	je	szokat			; Igen, †tugorjuk
	jmp	short maboka		; Ha egyik sem, akkor j¢
pasove:
	mov	dx,offset fejlec	; Ki°ratand¢ szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	jmp	kesoeu			; Itt kezdjen
kavita:
	jmp	kavike			; Kapcsol¢ vizsg†latra
kokald:
	lodsb				; Karakterbeolvas†s
maboka:
	cmp	al,0dh			; CR ?
	je	pasove			; Igen, befejezve
	cmp	al,0ah			; LF ?
	je	pasove			; Igen, befejezve
	cmp	al,' '                  ; Sz¢kîz ?
	je	neleza			; Igen, elemezzÅk
	cmp	al,9			; Tabul†tor ?
	je	neleza			; Igen, elemezzÅk
	cmp	al,','                  ; Vesszî ?
	je	neleza			; Igen, elemezzÅk
	cmp	al,0			; StringvÇg ?
	jne	kokald			; Nem, tov†bb olvasunk
koloka:
	lodsb				; Karakterbeolvas†s
neleza:
	or	al,al			; Nulla ?
	je	pasove			; Igen, befejezve
	cmp	al,0dh			; CR ?
	je	pasove			; Igen, befejezve
	cmp	al,0ah			; LF ?
	je	pasove			; Igen, befejezve
	cmp	al,' '                  ; Sz¢kîz ?
	je	koloka			; Igen, kîvetkezîre
	cmp	al,9			; Tabul†tor ?
	je	koloka			; Igen, kîvetkezîre
	cmp	al,','                  ; Vesszî ?
	je	koloka			; Igen, kîvetkezîre
	cmp	al,'/'                  ; Kapcsol¢ jel ?
	je	kavita			; Igen, kiÇrtÇkeljÅk
	cmp	al,'0'                  ; EnnÇl kisebb ?
	jc	cohiva			; Igen, kisebb
	cmp	al,'9'                  ; Nagyobb ?
	ja	cohiva			; Igen, nagyobb
	dec	si			; Vissza a sz†mjegyre
	call	conbeo			; Konstans beolvas†s
	cmp	cs:[konsam],3		; Harmadik ut†n ?
	ja	cohiva			; Igen, hiba
	je	hacobe			; Ha az, mehet
	cmp	cs:[konsam],2		; M†sodik ?
	je	szemeo			; Igen, szektormÇret
	cmp	bx,4			; EnnÇl nagyobb ?
	jc	cohiva			; Nem, hiba
	cmp	bx,32768		; Nagyobb ?
	jnc	cohiva			; Nagyobb, hiba
	mov	cs:[rammer],bx		; MÇret
	jmp	short szainc		; Sz†ml†l¢ nîvelÇsre
szemeo:
	mov	cs:[bpbofs],bx		; Uj mÇret
	mov	dx,cs:[rammer]		; MÇret
	mov	al,6			; Ez a kezdî hatv†ny
	cmp	bx,128			; Ennyi ? (2**6 sz¢)
	jne	nemmfb			; Nem, kîvetkezîre
	cmp	dx,8192 		; 8 Kbyte-n†l kisebb ?
	jc	tamesm			; Igen, °gy meg is felel
	shl	bx,1			; Dupl†zzuk
nemmfb:
	inc	al			; Hatv†ny nîvelÇs
	cmp	bx,256			; Ennyi ? (2**7 sz¢)
	jne	nemmeb			; Nem, kîvetkezîre
	cmp	dx,16384		; 16 Kbyte-n†l kisebb ?
	jc	tamesm			; Igen, °gy meg is felel
	shl	bx,1			; Dupl†zzuk
nemmeb:
	inc	al			; Hatv†ny nîvelÇs
	cmp	bx,512			; Ennyi ? (2**8 sz¢)
	jne	pashik			; Ha nem, hiba
tamesm:
	mov	byte ptr cs:[bpbofs + 19],al; Hatv†nysz†m mentÇs
	cmp	bx,cs:[bpbofs]		; Azonos a tervezettel ?
	je	szainc			; Igen, sz†ml†l¢ nîvelÇsre
	mov	cs:[bpbofs],bx		; Ez lesz az igazi
	mov	dx,offset secadj	; Szîvegc°m
	call	strkir			; Ki°ratjuk
	jmp	short szainc		; Sz†ml†l¢ nîvelÇsre
cohiva:
	jmp	short pashik		; Hibaki°rat†s
hacobe:
	cmp	bx,2			; Ennyi van ?
	jc	pashik			; Ha nincs hiba
	cmp	bx,1024 		; EnnÇl nagyobb
	ja	pashik			; Igen, ez hiba
	mov	di,cs:[bpbofs]		; Szektor byte-sz†m
	mov	cl,5			; LÇptetÇssz†m
	shr	di,cl			; Ennyi bejegyzÇs fÇr
	mov	ax,bx			; AX <- konstans
	xor	dx,dx			; DX <- 0
	div	di			; Ennyi bejegyzÇs lehet
	or	dx,dx			; MaradÇk 0 ?
	je	nemasb			; Igen, ennyi bejegyzÇs lesz
	sub	di,dx			; Ennyi maradna
	add	bx,di			; MegnîveljÅk annyival
nemasb:
	mov	cs:[bpbofs + 6],bx	; BejegyzÇssz†m
szainc:
	inc	cs:[konsam]		; Konstans sz†ml†l¢ ++
	jmp	koloka			; Tov†bbi paramÇterre
pashiq:
	cmp	al,'Q'                  ; Csîndben ?
	je	csovab			; Igen, az lesz
	cmp	al,'q'                  ; Csîndben ?
	je	csovab			; Igen, az lesz
pashik:
	mov	dx,offset parhib	; Szîvegc°m
nesipr:
	call	strkir			; Ki°rat†s DX szerint
kilnue:
	xor	ax,ax			; AX <- egysÇgsz†m
	jmp	short kilnie		; KilÇpÇsre
kavike:
	mov	al,0ffh 		; Ez lesz a jelzî
	xchg	al,cs:[kavoje]		; Kapcsol¢ jelzî
	mov	ah,al			; Ha Quss lenne belîle
	or	al,al			; Volt m†r kapcsol¢ ?
	lodsb				; Kapcsol¢ ÇrtÇk
	jne	pashiq			; Igen, hiba
	cmp	al,'Q'                  ; Csîndben ?
	je	csovab			; Igen, az lesz
	cmp	al,'q'                  ; Csîndben ?
	jne	expesv			; Nem, esetleg extended
csovab:
	mov	byte ptr cs:[dumtip],0ffh; Nincs duma jelzÇs
	mov	cs:[kavoje],ah		; Kapcsol¢ vissza
	jmp	short koloks		; Mehet elemezni tov†bb
expesv:
	cmp	al,'E'                  ; Extended ?
	je	exjeta			; Igen, az lesz
	cmp	al,'e'                  ; Extended ?
	jne	expese			; Nem, esetleg Axpanded
exjeta:
	mov	cs:[drvtip],0		; Extended jelzÇs
koloks:
	jmp	koloka			; Tov†bb olvas†s
expese:
	cmp	al,'A'                  ; Axpanded ?
	je	expjta			; Igen, az lesz
	cmp	al,'a'                  ; Axpanded ?
	jne	pashik			; Igen, az lesz
expjta:
	mov	cs:[drvtip],1		; Expanded jelzÇs
	jmp	koloks			; Tov†bb olvas†s
kesoeu:
	push	cs			; Ez kerÅl majd DS-be
	pop	ds			; DS <- CS
	mov	al,[drvtip]		; T°pusjelzî
	or	al,al			; Extended ?
	jne	taexin			; Nem, tal†n expanded
	call	extini			; Extended kezelî init
	jmp	short inihie		; HibaellenîrzÇsre
taexin:
	dec	al			; Expanded ?
	jne	morein			; Nem, rendszermem¢ria
	call	expini			; Expanded kezelî init
	jmp	short inihie		; HibaellenîrzÇsre
morein:
	call	sysini			; Rendszer-mem¢ria kezelî
inihie:
	jnc	mehini			; Ha sikeres volt az init
	jmp	kilnue			; KilÇpÇs hib†val
mehini:
	cmp	byte ptr [inijel],0	; Inicializ†lva ?
	jne	noaini			; Nem, akkor inicializ†ljuk
	jmp	kilvae			; Sikeres ind°t†sra
noaini:
	call	drvini			; Inicializ†ljuk
	jnc	rendin			; Sikeres volt
	call	vimind			; Visszacsin†l†s
	mov	dx,offset ninele	; Szîvegc°m
	jmp	nesipr			; KilÇpÇs
rendin:
	mov	al,1			; Ennyi egysÇget kezel
kilnie:
	lds	bx,dword ptr cs:[bufcim]; DS:BX <- pufferc°m
	mov	[bx + 0dh],al		; EgysÇgsz†m
	mov	cx,cs:[szacit]		; A m†r szabad offszetje
	mov	[bx + 0eh],cx		; Offszet kitîltÇs
	mov	cx,cs:[szacit + 2]	; A m†r szabad paragrafus
	mov	[bx + 10h],cx		; Paragrafus kitîltÇs
	mov	word ptr [bx + 12h],offset bpbpoi; Ez a BPB pointer
	mov	cx,cs:[bpbpar]		; Ez a BPB paragrafusa
	mov	[bx + 14h],cx		; BPB paragrafus kitîltÇs
	jmp	sivime			; Sikeres befejezÇsre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Drive inicializ†l†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
drvini:
	mov	ax,[rammer]		; MÇret (Kbyte)
	mov	cx,1024 		; Ennyi 1 Kbyte
	mul	cx			; DX:AX <- mÇret
	div	word ptr [bpbofs]	; Szektor byte-sz†m
	mov	[bpbofs + 8],ax 	; Szektorsz†m
	mov	ax,[bpbofs + 6] 	; BejegyzÇssz†m
	mov	cl,5			; Egy bejegyzÇs hatv†nya
	shl	ax,cl			; AX <- szektor
	xor	dx,dx			; DX <- 0
	div	word ptr [bpbofs]	; Szektor byte-sz†m
	or	dx,dx			; Van maradÇk ?
	je	nimase			; Nincs, ennyi szektor
	inc	ax			; Egyel tîbb szektor kell
nimase:
	mov	[rootse],ax		; ROOT hossz
	add	ax,2			; Ennyivel minimum tîbb
	cmp	ax,[bpbofs + 8] 	; Szektorsz†m
	jc	szesza			; Ha kevesebb
	mov	word ptr [bpbofs + 6],16; BejegyzÇssz†m minimum
	xor	dx,dx			; DX <- 0
	mov	ax,512			; AX <- 512
	div	word ptr [bpbofs]	; Szektor byte-sz†m
	or	dx,dx			; Van maradÇk ?
	je	manele			; Nincs
	inc	ax			; Ha van, egyel tîbb
manele:
	mov	[rootse],ax		; ROOT hossz
	add	ax,2			; Ennyivel minimum tîbb
	cmp	ax,[bpbofs + 8] 	; Szektorsz†m
	jc	szesza			; Ha kevesebb
	stc				; Hibajel
	ret				; VisszatÇrÇs
szesza:
	mov	si,64			; Ciklussz†m
itcisa:
	mov	ax,[bpbofs + 8] 	; Szektorsz†m
	sub	ax,[bpbofs + 3] 	; Foglaltak sz†ma
	mov	cl,byte ptr [bpbofs + 5]; FAT-ok sz†ma
	xor	ch,ch			; H byte <- 0
tofale:
	sub	ax,[bpbofs + 11]	; FAT mÇret
	loop	tofale			; Annyiszor, ah†ny FAT van
	sub	ax,[rootse]		; ROOT hossz
	mov	bx,1			; Szektor / cluster
	cmp	ax,0feeh		; 4078-n†l tîbb ?
	jc	habeta			; Nem, annyi nincs
	mov	bx,2			; Szektor / cluster
	cmp	ax,1fdch		; 8156-n†l tîbb ?
	jc	habeta			; Nem, annyi nincs
	mov	bx,4			; Szektor / cluster
	cmp	ax,3fb8h		; 16312-nÇl tîbb ?
	jc	habeta			; Nem, annyi nincs
	mov	bx,8			; Szektor / cluster
	cmp	ax,7f70h		; 32624-nÇl tîbb ?
	jc	habeta			; Nem, annyi nincs
	mov	bx,16			; Szektor / cluster
habeta:
	xor	dx,dx			; H sz¢ null†z†s
	div	bx			; AX <- cluster-sz†m
	mov	cx,ax			; CX <- cluster-sz†m
	shr	cx,1			; CX <- CX / 2
	jnc	parole			; Ha p†ros volt
	inc	cx			; Igy is p†ros
parole:
	add	ax,cx			; AX <- AX * 1.5
	add	ax,3			; Ennyi kell az elejÇn
	xor	dx,dx			; H sz¢ null†z†s
	div	word ptr [bpbofs]	; Szektor byte-sz†m
	or	dx,dx			; Van maradÇk ?
	je	nimafa			; Ha nincs
	inc	ax			; Tîrt FAT szektor
nimafa:
	xchg	ax,[bpbofs + 11]	; FAT mÇret (az igazi)
	xchg	bl,byte ptr [bpbofs + 2]; Cluster-hossz
	dec	si			; Ciklussz†ml†l¢ csîkkentÇs
	je	civeva			; Ha elfogyott az iter†l†si sz†m
	cmp	bl,byte ptr [bpbofs + 2]; Cluster hossz a rÇgi ?
	jne	itcisa			; Nem, vissza sz†mol†sra
	cmp	ax,[bpbofs + 11]	; FAT mÇret a rÇgi ?
	jne	itcisa			; Nem, vissza sz†mol†sra
civeva:
	mov	dx,offset dsizsz	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	ax,[rammer]		; MÇret (Kbyte)
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset sectsz	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	ax,[bpbofs]		; Szektor byte-sz†m
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset alluni	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	al,byte ptr [bpbofs + 2]; Cluster-hossz
	xor	ah,ah			; H byte <- 0
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset entdar	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	ax,[bpbofs + 6] 	; BejegyzÇssz†m
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset crlfcs	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	cmp	[sysjel],0		; Renszermem¢ria ?
	je	neinre			; Nem, nem a rendszerÇ
	mov	ax,1			; BOOT szektor
	add	ax,[bpbofs + 11]	; FAT mÇret
	add	ax,[rootse]		; ROOT hossz
	mul	word ptr [bpbofs]	; Szektor byte-sz†m
	add	ax,[extruc]		; Eltol†s L sz¢
	adc	dx,[extruc + 2] 	; Eltol†s H sz¢
	add	ax,15			; Paragrafushat†ron t£lra tol†s
	adc	dx,0			; Carry †tvitel
	mov	cx,16			; ParagrafusmÇret
	div	cx			; DX:AX <- c°m
	mov	bx,ax			; BX <- paragrafushossz
	mov	dx,cs			; Ez a k¢dszegmens
	sub	bx,dx			; Ennyi marad a kÇt hely kîzîtt
	cmp	bx,147h 		; ElfÇr a FAT + a ROOT ?
	jnc	elfsys			; ElfÇr, ne b†ntsuk
	mov	ax,cs			; Ezt akarom eltolni
	add	ax,147h 		; Ennyivel kerÅl h†trÇbb
elfsys:
	mov	es,ax			; Ez az £j paragrafus
	xor	si,si			; Innetîl m†solajon
	mov	di,si			; Ide tegye
	mov	cx,offset utmasc	; Ilyen hosszan
	cld				; Nîvekvî stringmÅveletek
	rep	movsb			; M†sol†s
	push	es			; Ez lesz a k¢dszegmens
	mov	ax,offset neinre	; Ide ugorjon
	push	ax			; Offszet Stack-re
	push	es			; Ebbîl lesz DS
	pop	ds			; DS <- £j paragrafus
	retf				; Ugr†s az £j k¢drÇszre
neinre:
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	xor	dx,dx			; Az elsîbe kell °rni
	mov	cx,1			; Ennyit kell °rni
	mov	di,offset boots 	; BPB-t kell
	mov	bh,1			; Ir†s lesz
	call	mentio			; Szektor °r†s
	inc	dx			; Az elsî FAT szektor
	mov	di,offset secpuf	; Ez a szektor terÅlete
	xor	ax,ax			; Ezt vigye ki
	mov	cx,512			; Azaz 1024 byte
	cld				; Nîvekvî stringmÅveletek
	rep	stosw			; KitÅltÇs
	mov	di,offset secpuf	; Ez a szektor terÅlete
	mov	cx,1			; Ennyit kell °rni
	mov	es:[di],0fff8h		; Elsî kÇt byte
	mov	byte ptr es:[di + 2],0ffh; Harmadik byte
	call	mentio			; Szektor °r†s
	inc	dx			; A kîvetkezî szektor
	mov	word ptr es:[di],0	; Elsî kÇt byte null†z†s
	mov	byte ptr es:[di + 2],0	; Harmadik byte null†z†s
	mov	cx,[bpbofs + 11]	; FAT mÇret
	dec	cx			; Ezt m†r fel°rtuk
	jcxz	egyfat			; Ha csak 1 szektor a FAT
fatcik:
	push	cx			; Ciklussz†m mentÇs
	mov	cx,1			; Ennyit kell °rni
	call	mentio			; Szektor °r†s
	inc	dx			; A kîvetkezî szektor
	pop	cx			; Ciklussz†m vissza
	loop	fatcik			; Ciklus FAT-ra
egyfat:
	mov	cx,1			; Ennyit kell °rni
	mov	di,offset labelh	; Label c°me
	call	mentio			; Szektor °r†s
	inc	dx			; A kîvetkezî szektor
	mov	cx,[rootse]		; ROOT hossz
	dec	cx			; Ezt m†r fel°rtuk
	jcxz	kilvae			; Ha csak 1 szektor a ROOT
	mov	di,offset secpuf	; Ez a szektor terÅlete
rootci:
	push	cx			; Ciklussz†m mentÇs
	mov	cx,1			; Ennyit kell °rni
	call	mentio			; Szektor °r†s
	inc	dx			; A kîvetkezî szektor
	pop	cx			; Ciklussz†m vissza
	loop	rootci			; Ciklus ROOT-ra
kilvae:
	clc				; Sikeres jelzÇse
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	I/O mentÇsekkel.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mentio:
	push	es			; ES mentÇs
	push	di			; DI mentÇs
	push	ds			; DS mentÇs
	push	cx			; CX mentÇs
	push	dx			; DX mentÇs
	push	bx			; BX mentÇs
	call	secbhm			; Szektor I/O
	pop	bx			; BX vissza
	pop	dx			; DX vissza
	pop	cx			; CX vissza
	pop	ds			; DS vissza
	pop	di			; DI vissza
	pop	es			; ES vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Konstans beolvas¢ BX-be.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
conbeo:
	xor	bx,bx			; Ebben lesz a konstans
conkar:
	lodsb				; Karakter beolvas†s
	sub	al,'0'                  ; "Bin†ris°t†s"
	jc	beconb			; Ha nem sz†mjegy
	cmp	al,9			; Nagyobb mint 9 ?
	ja	beconb			; Igen, nem sz†mjegy
	cbw				; AX <- 0000 + AL
	xchg	ax,bx			; AX <- szorzand¢
	mov	dx,10			; Ennyivel kell szorozni
	mul	dx			; AX <- AX * 10
	add	bx,ax			; BX <- BX * 10 + sz†mjegy
	jmp	conkar			; Kîvetkezî beolvas†sra
beconb:
	dec	si			; VisszalÇpÇs
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Visszacsin†lunk mindent.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vimind:
	cmp	[drvtip],1		; EMS a ramdrive ?
	jne	nemexp			; Nem, egyÇb
	mov	dx,[xmshnd]		; EMS handle
	mov	ah,45h			; Close k¢dja
	int	67h			; EMS kezelî h°v†s
tikivi:
	push	ds			; Elrontom mindj†rt
	lds	dx,dword ptr [xmsrut]	; DS:DX <- eredeti 19-es vektor
	cli				; IT. most nem jîhet
	mov	ax,2519h		; 19-es vektor °r†s
	int	21h			; DOS h°v†s
	sti				; Most m†r h°vhatja
	pop	ds			; DS vissza
	mov	ax,0ffffh		; JelzÇs, hogy nincs
	mov	[xmsrut],ax		; Nincs vektor 1.
	mov	[xmsrut + 2],ax 	; Nincs vektor 2.
	ret				; VisszatÇrÇs
nemexp:
	cmp	[sysjel],0		; Rendszermem¢ria ?
	jne	nvahok			; Igen, nem XMS
	mov	dx,[xmshnd]		; XMS handle
	cmp	dx,0ffffh		; Volt kezelî m†r ?
	je	nevhnd			; Nem, mÇg nem volt
	mov	ah,0dh			; XMS rîgz°tÇs elengedÇs k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	mov	ah,0ah			; XMS visszaad†s k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
nevhnd:
	mov	ax,0ffffh		; JelzÇs, hogy nincs
	cmp	[jmppos],ax		; Volt kezelî m†r ?
	jne	tavoke			; Igen, volt m†r
	cmp	[jmppos + 2],ax 	; Volt kezelî m†r ?
	je	nvahok			; Nem, eddig mÇg nem
tavoke:
	mov	al,0ebh 		; Rîvid JMP k¢dja
	mov	ah,[kodofs]		; Ez az offszetje
	push	es			; Elrontom mindj†rt
	les	bx,dword ptr [jmppos]	; Ide kell be°rni
	mov	es:[bx],ax		; Vissza°rjuk
	mov	ax,9090h		; NOP, NOP k¢dja
	mov	es:[bx + 2],ax		; NOP, NOP vissza°r†s
	mov	byte ptr es:[bx + 4],al ; NOP vissza°r†s
	pop	es			; Visszaveszem
	mov	ax,0ffffh		; JelzÇs, hogy nincs
	mov	es:[jmppos],ax		; Nem volt kezelî 1.
	mov	es:[jmppos + 2],ax	; Nem volt kezelî 2.
nvahok:
	ret				; VisszatÇrÇs

nuserd:
	xor	dx,dx			; H sz¢ null†z†s
	mov	ax,dx			; L sz¢ null†z†s
	mov	cx,512			; Hossz sz¢
	push	cs			; Ez lesz a cÇl paragfusa
	pop	es			; ES <- CS
	mov	di,offset secpuf	; Ez a puffer c°me
	push	ds			; Elrontja
	call	xmskez			; Byte transzfer
	pop	ds			; DS vissza
	ret				; VisszatÇrÇs
inelle:
	xor	bh,bh			; BH <- olvas†s
	call	nuserd			; Beolvastunk
	mov	dx,offset iohiba	; Szîvegc°m
	jc	hibles			; KilÇpÇs hib†val
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	mov	di,offset secpuf	; Puffer
	mov	si,offset boots 	; BPB c°m
	mov	cx,11			; Ennyit kell îsszehasonl°tani
	cld				; Nîvekvî stringmÅveletek
	rep	cmpsb			; ôsszehasonl°t†s
	jne	nemini			; Ha nem azonos, vissza
	cmp	byte ptr [inijel],2	; Inicializ†l†s ut†n ?
	je	nemini			; Igen, vissza
	mov	si,offset secpuf + 11	; Eltoljuk
	lodsw				; AX <- hossz
	cmp	ax,[bpbofs]		; Szektor byte-sz†m
	jne	nemini			; Ha nem azonos, vissza
	mov	si,offset secpuf + 17	; Eltoljuk
	lodsw				; BejegyzÇsek sz†ma
	cmp	ax,[bpbofs + 6] 	; BejegyzÇssz†m
	jne	nemini			; Ha nem azonos, vissza
	mov	byte ptr [inijel],0	; Inicializ†lva
	mov	di,offset bpbofs	; Szektor byte-sz†m c°me
	mov	si,offset secpuf + 11	; M†sik byte-sz†m c°me
	mov	cx,10			; Hossz szavakban
	rep	movsw			; ètm†soljuk
nemini:
	clc				; St†tuszbe†ll°t†s
	ret				; VisszatÇrÇs
hibles:
	jmp	strkir			; Ki°rat†s DX szerint

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Extended kezelî inicializ†l†s.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
extini:
	call	xmsope			; XMS handle nyit†s
	jc	handni			; Nem sikerÅlt
extrui:
	mov	bx,[xmsrut]		; XMS kezelî offszet
	mov	es,[xmsrut + 2] 	; XMS kezelî paragrafus
vijmpv:
	mov	[extruc + 2],es 	; XMS belsî paragrafus
	mov	[jmppos + 2],es 	; Poz°ci¢ paragrafus
	mov	[jmppos],bx		; Poz°ci¢ offszet
	mov	cx,es:[bx]		; Ez a k¢d van ott
	cmp	cl,0ebh 		; JMP rîvid k¢dja ?
	je	rojako			; Igen, rîvid JMP k¢d
	cmp	cl,0eah 		; JMP SEG:OFFSET k¢dja ?
	jne	badkez			; Nem, hiba van
	push	es:[bx + 1]		; Offszet beolvas†s
	mov	es,es:[bx + 3]		; Paragrafusc°m beolvas†s
	pop	bx			; BX <- offszet
	jmp	vijmpv			; NÇzzÅk meg ott is
rojako:
	cmp	es:[bx + 2],9090h	; NOP, NOP van ott ?
	jne	badkez			; Nem, hiba van
	cmp	byte ptr es:[bx + 4],90h; NOP van ott ?
	jne	badkez			; Nem, hiba van
	mov	di,bx			; DI <- offszet
	mov	ah,0			; AH <- 0
	mov	al,ch			; AL <- k¢d offszet
	mov	[kodofs],al		; EltesszÅk
	add	ax,2			; Eltoljuk a rîvid JMP hossz†val
	add	bx,ax			; BX <- ez az £j offszet
	mov	[extruc],bx		; XMS belsî offszet
	mov	byte ptr es:[di],0eah	; JMP SEG:OFFSET k¢dja
	mov	es:[di + 1],offset hikehe; Offszet
	push	[bpbpar]		; Ezzel tîltse ki
	pop	es:[di + 3]		; Paragrafus
	clc				; Sikeres volt
handni:
	ret				; VisszatÇrÇs
badkez:
	mov	dx,offset badext	; Szîvegc°m
	jmp	strkir			; Ki°rat†s DX szerint

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Expanded kezelî inicializ†l†s.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
expini:
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	mov	si,offset emskez	; Saj†t rutin c°me
	mov	di,offset xmskez	; Kezelî fejc°m
	mov	cx,(emskev - emskez) / 2; A rutin helymÇrete sz¢ban
	cli				; IT. ne jîjjîn
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	call	emsope			; EMS nyit†s
	jc	rovite			; Hib†s a nyit†s
	mov	ax,3519h		; 19-es vektor lekÇrdezÇs
	int	21h			; DOS h°v†s
	mov	[xmsrut],bx		; Offszet elpakol†s
	mov	[xmsrut + 2],es 	; Paragrafus elpakol†s
	mov	dx,offset emsk19 - (emskez - xmskez); Ez a kezelî c°me
	mov	ax,2519h		; 19-es vektor m¢dos°t†s
	int	21h			; DOS h°v†s
	call	inelle			; MegnÇzzÅk volt-e inicializ†lva
	jnc	siinel			; Ha sikeres volt
	call	vimind			; Visszacsin†l†s
	stc				; HibajelzÇs
rovite:
	ret				; VisszatÇrÇs
siinel:
	cmp	byte ptr [inijel],0	; Inicializ†lva ?
	jne	nermet			; Nem, meg van az ÇrtÇk
	mov	ax,[bpbofs + 8] 	; Szektorsz†m
	mul	word ptr [bpbofs]	; Szektor byte-sz†m
	mov	cx,1024 		; Ez 2**10
	div	cx			; AX <- Kbyte
	cmp	ax,[rammer]		; MÇret (Kbyte)
	je	nermet			; Ha azonos
	mov	byte ptr [inijel],2	; Nem azonos jelzÇse
nermet:
	clc				; Sikeres jelzÇse
	ret				; VisszatÇrÇs

emmxxx	db	'EMMXXXX0'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
;	EXPANDED mem¢ria kezelî.		;
;						;
;	Input:	DX:AX <- kezdî poz°ci¢		;
;		BH    <- 0 --> olvas†s		;
;		BH    <- 1 --> °r†s		;
;		CX    <- sz¢sz†m		;
;		ES:DI <- puffer 		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
emskez:
	push	ax			; Darabsz†m L sz¢
	push	dx			; Darabsz†m H sz¢
vasama:
	mov	dx,cs:[xmshnd]		; EMS handle
	mov	ah,47h			; Save k¢dja
	int	67h			; EMS kezelî h°v†s
	or	ah,ah			; Sikeres volt ?
	je	sisaco			; Igen, sikere
	cmp	ah,82h			; EMS foglalt ?
	je	vasama			; Igen, v†runk
	pop	dx			; Darabsz†m H sz¢ År°tÇs
	pop	dx			; Darabsz†m L sz¢ År°tÇs
	mov	al,2			; Hibak¢d
	cmp	ah,8ch			; T£lcsordul†s ?
	je	messem			; Igen, nem megy a save
	cmp	ah,8dh			; EnnÇl nagyobb ?
	ja	messem			; Nem, mehet
	mov	al,0ch			; Hibak¢d
messem:
	stc				; HibajelzÇs
	ret				; VisszatÇrÇs
sisaco:
	pop	dx			; Darabsz†m H sz¢
	pop	ax			; Darabsz†m L sz¢
nekevi:
	push	cx			; Sz¢sz†m
	mov	cx,16384		; Ez egy lap hossza
	div	cx			; AX <- lapsz†m, DX <- maradÇk
	mov	si,dx			; SI <- maradÇk
	mov	dx,ax			; DX <- lapsz†m
	pop	cx			; Ennyi sz¢ kell
	push	bx			; Ez az °r†s olvas†s jelzî
	push	cx			; Sz¢ darab
	mov	ax,di			; Output c°m
	add	ax,1			; Lehet esetleg carry
	rcr	ax,1			; Igy legfeljebb 8000h
	dec	cx			; Sz¢ darab - 1
	add	ax,cx			; C°m maximum
	shr	ax,1			; LelÇptetÇs 1.
	shr	ax,1			; LelÇptetÇs 2.
	shr	ax,1			; LelÇptetÇs 3.
	mov	bx,es			; CÇl szegmens
	add	ax,bx			; AX <- paragrafus-tetî
	sub	ax,[extruc + 2] 	; Nagyobb a page-frame ?
	jc	egysol			; Ha nagyobb volt
	mov	cx,4			; Hatv†ny az oszt†shoz
	mov	bp,di			; BP <- startc°m
	shr	bp,cl			; BP <- paragrafus
	add	bp,bx			; BP <- paragrafustetî
	sub	bp,[extruc + 2] 	; Igy elÇrte a page-frame-t ?
	jc	eleati			; Ha elÇrte
	cmp	bp,4096 		; Nagyobb mint 64K ?
	jnc	egysol			; Igen, mehet
eleati:
	jmp	leonre			; Visszair†s EMS-re
egysol:
	pop	cx			; Sz¢sz†m
	pop	bx			; Ir†s/Olvas†s jelzî
	xor	bp,bp			; BP <- 0
	push	bx			; Jelzî vissza
	mov	ax,dx			; AX <- lapsz†m
	mov	bx,si			; BX <- maradÇk lapmÇret
	shr	bx,1			; BX <- maradÇk sz¢ban
	push	cx			; Sz¢sz†m mentÇs
	add	bx,cx			; Ez az utols¢ c°m (szavas !)
	mov	dx,bx			; M†solat a c°mrîl
	mov	cl,13			; A hatv†nysz†m lapmÇretre
	shr	bx,cl			; BX <- lapsz†m
	and	dx,1fffh		; Ennyi sz¢ marad le a lapr¢l
	je	nemase			; Nem, egÇsz lapra esik
	inc	bx			; Egy lappal tîbb kell
nemase:
	mov	cx,bx			; Ennyi lap kellet
	mov	bx,ax			; BX <- kezdî lapsz†m
	cmp	cx,4			; Nem tîbb mint 4 ?
	jbe	nenmax			; Nem, mehet
	mov	bp,dx			; Ennyi maradt m†solni
	dec	cx			; Mert legfeljebb 5 volt
	pop	ax			; Sz¢sz†m vissza
	sub	ax,dx			; MaradÇkkal csîkkentve
	push	ax			; Ez az £j sz¢sz†m
nenmax:
	mov	dx,[xmshnd]		; EMS handle
	mov	ax,4400h		; EMS map k¢dja
	push	ax			; EltesszÅk stackre
valekma:
	pop	ax			; K¢d elîvÇtel (AX tîltÇs)
	push	ax			; VisszatesszÅk
	push	bx			; Lapsz†m mentÇs
	push	dx			; EMS handle mentÇs
	int	67h			; EMS kezelî h°v†s
	pop	dx			; EMS handle vissza
	pop	bx			; Lapsz†m vissza
	or	ah,ah			; Sikeres ?
	jne	nesilem 		; Nem, m†s k¢d jîtt
	inc	bx			; Kîvetkezî lapsz†m
	pop	ax			; EMS map k¢d
	inc	al			; Kîvetkezî lap
	push	ax			; K¢d stackre
	loop	valekma 		; LekÇpzÇsi ciklus
	pop	ax			; Stack År°tÇs (MAP k¢d)
	pop	cx			; Ennyi sz¢ megy ebben a menetben
	pop	ax			; Ez az °r†s/olvas†s jelzî
	push	ax			; Vissza is tesszÅk
	or	ah,ah			; Olvas†s ?
	je	emsolv			; Igen olvasunk
	push	es			; ES bîl lesz DS
	push	di			; Ez megy majd SI-be
	mov	di,si			; DI <- cÇl
	pop	si			; SI <- rÇgi DI
	pop	ds			; DS <- ES
	mov	es,cs:[extruc + 2]	; Page-frame paragrafus a cÇl
	jmp	short masveg		; Mehet a mozgat†s
emsolv:
	mov	ds,[extruc + 2] 	; Page-frame paragrafus a forr†s
masveg:
	rep	movsw			; ètm†soljuk
	or	bp,bp			; Maradt ?
	jne	marlap			; Igen, †tlÇpjÅk
siemsm:
	pop	ax			; Ez kell År°tÇs miatt
	clc				; St†tusz kitîltÇs
resems:
	push	ax			; KilÇpÇsi k¢d
	pushf				; St†tusz kipakol†s
varres:
	mov	dx,cs:[xmshnd]		; EMS handle
	mov	ah,48h			; Restore k¢dja
	int	67h			; EMS kezelî h°v†s
	or	ah,ah			; Sikeres ?
	je	valner			; Igen, sikeres
	cmp	ah,82h			; EMS foglalt ?
	je	varres			; Igen, v†runk
	cmp	ah,8eh			; Restore hiba ?
	je	valner			; Igen, az
	pop	dx			; Stack År°tÇs
	pop	dx			; Stack År°tÇs
	mov	al,0ch			; Hibak¢d
	stc				; Hibajel
	ret				; VisszatÇrÇs
valner:
	popf				; Flag <- sikeres
	pop	ax			; Stack År°tÇs
	ret				; VisszatÇrÇs
marlap:
	mov	dx,cs:[xmshnd]		; EMS handle
marlal:
	mov	ax,4400h		; EMS map k¢dja
	push	bx			; Lapsz†m mentÇs
	push	dx			; EMS handle mentÇs
	int	67h			; EMS kezelî h°v†s
	pop	dx			; EMS handle vissza
	pop	bx			; Lapsz†m vissza
	or	ah,ah			; Sikeres ?
	jne	nesmal			; Nem, valami baj van
	pop	ax			; Ez az °r†s/olvas†s jelzî
	push	ax			; Vissza is tesszÅk
	or	ah,ah			; Olvas†s ?
	je	olvmara 		; Igan, maradÇk olvas†s
	xor	di,di			; Itt a cÇl c°me
	jmp	short mairmo		; Mehet a maradÇk m†sol†sa
olvmara:
	xor	si,si			; Itt a forr†s c°me
mairmo:
	mov	cx,bp			; A maradÇk hossza sz¢ban
	rep	movsw			; ètm†soljuk
	jmp	siemsm			; ètmegyÅnk a befejezÇshez
nesilem:
	cmp	ah,82h			; EMS foglalt ?
	je	valekma 		; Igen, v†runk
	pop	dx			; 1 sz¢ År°tÇs
	pop	dx			; 1 sz¢ År°tÇs
	jmp	short nejoli		; Hibak¢ddal kilÇpÇs
nesmal:
	cmp	ah,82h			; EMS foglalt ?
	je	marlal			; Igen, v†runk
nejoli:
	pop	dx			; 1 sz¢ År°tÇs
	mov	al,2			; Hiba k¢d
	stc				; Hibajelzî
	jmp	resems			; KilÇpÇs restore-ral
leonre:
	xor	al,al			; Null†s lap
	mov	bx,[extruc + 2] 	; Ez a page-frame
	cmp	bp,4096 		; Elîtte kezdîdik ?
	jnc	naminn			; Igen, elîtte
	cmp	bp,1024 		; Nagyobb mint 16K ?
	jnc	namine			; Igen, nagyobb
naminn:
	mov	al,3			; Negyedik 16K-s lap
	add	bx,0c00h		; Page-frame is eltolva
namine:
	add	bp,0800h		; Eltoljuk kÇt lappal
	mov	cx,bp			; CX <- eltolt m†solat
	mov	ds,bx			; Kisz†m°tott paragrafus
	pop	bp			; Sz¢ darab
	pop	bx			; Ez az °r†s olvas†s jelzî
	push	cx			; Eltolt mentÇse
	xor	cx,cx			; MaradÇk, ha kisebb lenne
	cmp	bp,16384		; Nagyobb mint a lapmÇret ?
	jna	lamene			; Nem nagyobb, akkor csak enyyi
	mov	cx,bp			; Lem†soljuk a mÇretet
	mov	bp,16384		; Ez a lapmÇret
	sub	cx,bp			; CX <- maradÇk
lamene:
	push	cx			; MaradÇk mentÇs
	push	bx			; Ez az °r†s olvas†s jelzî
	push	dx			; Lapsz†m
	mov	cx,16384		; Ez a lapmÇret
	sub	cx,si			; Kezdîc°met levonjuk
	shr	cx,1			; CX <- sz¢sz†m
	cmp	cx,bp			; Kell ennyi egy†ltal†n ?
	jc	kelmem			; Igen, nem koorig†lunk
	mov	cx,bp			; Csak ennyit kell
kelmem:
	or	bh,bh			; Olvas†s ?
	je	csaolo			; Igen, nincs csere
	push	ds			; Ez lesz kÇsîbb ES
	push	es			; Ez lesz kÇsîbb DS
	push	si			; Ez lesz kÇsîbb DI
	mov	si,di			; SI <- DI
	pop	di			; Ez a rÇgi SI
	pop	ds			; Ez a rÇgi ES
	pop	es			; Ez a rÇgi DS
csaolo:
	cld				; Nîvekvî stringmÅveletek
elacse:
	sub	bp,cx			; BP <- ennyit olvastunk
	mov	bx,dx			; Lapsz†m m†solat
	mov	ah,44h			; MAP k¢dja
	mov	dx,cs:[xmshnd]		; EMS handle
	push	ax			; K¢d mentÇs (AL miatt)
varonm:
	pop	ax			; AX <- mÅveleti k¢d
	push	ax			; Vissza is tesszÅk
	push	bx			; Lapsz†m mentÇs
	push	dx			; Handle mentÇs
	int	67h			; EMS kezelî h°v†s
	pop	dx			; Handle vissza
	pop	bx			; Lapsz†m vissza
	or	ah,ah			; Sikeres volt ?
	je	sikonm			; Igen, sikeres
	cmp	ah,82h			; EMS foglalt ?
	je	varonm			; Igen, v†runk r†
	pop	ax			; Stack År°tÇs
	mov	al,2			; Hibak¢d
	pop	dx			; 1 sz¢ År°tÇs
	pop	dx			; 1 sz¢ År°tÇs
	pop	dx			; 1 sz¢ År°tÇs
	stc				; HibajelzÇs
	jmp	hiklva			; KilÇpÇsre (CARRY set !!!)
sikonm:
	pop	ax			; Lapk¢d vissza
	rep	movsw			; M†solunk
	or	bp,bp			; Maradt ?
	je	nemonm			; Nem maradt
	pop	dx			; Lapsz†m
	pop	bx			; Ir†s olvas†s jelzî
	inc	dx			; Kîvetkezî lap
	push	bx			; Jelzî vissza
	push	dx			; Lapsz†m vissza
	mov	cx,2000h		; Ez egy lap hossza sz¢ban
	cmp	cx,bp			; Tîbb mint egy lap ?
	jna	tomine			; Igen, tîbb mint egy lap
	mov	cx,bp			; Ha nem tîbb akkor annyi
tomine:
	or	bh,bh			; Olvas†s ?
	jne	irakit			; Nem, °r†s
	xor	si,si			; Forr†s c°m
	jmp	elacse			; Vissza a kîvetkezî lapra
irakit:
	xor	di,di			; CÇl c°m
	jmp	elacse			; Vissza a kîvetkezî lapra
nemonm:
	pop	dx			; Lapsz†m
	pop	bx			; Ir†s olvas†s jelzî
	pop	bp			; M†sodik menetre maradÇk
	pop	ax			; A mentett maradÇk
	or	bp,bp			; Maradt ?
	jne	marmam			; Igen, maradt
	jmp	onreve			; Nem maradt, vÇge
marmam:
	push	ax			; MaradÇk mentÇs
	xor	cx,cx			; CX <- 0
	push	cx			; Stack-re 0
	clc				; Sikeres jelzÇse
	push	dx			; Lapsz†m mentÇs
	push	ax			; MaradÇk mentÇs
	pushf				; Flag mentÇs
resonv:
	mov	dx,cs:[xmshnd]		; EMS handle
	mov	ah,48h			; Restore k¢dja
	int	67h			; EMS kezelî h°v†s
	or	ah,ah			; Sikeres volt ?
	je	sikmro			; Igen, sikeres
	cmp	ah,82h			; EMS foglalt ?
	je	resonv			; Igen, v†runk
	cmp	ah,8eh			; M†r volt restore ?
	je	sikmro			; Igen, °gy is sikeres
	pop	dx			; Stack År°tÇs
	pop	dx			; Stack År°tÇs
	mov	al,0ch			; Hibak¢d
	stc				; Hib†s jelzÇse
	jmp	short hiklev		; KilÇpÇsre
sikmro:
	popf				; Sikereresre †ll°tva a flag
	pop	ax			; MaradÇk vissza
hiklev:
	pop	dx			; Lapsz†m vissza
	jnc	resoke			; Ha sikeres
	pop	dx			; Stack År°tÇs
	pop	dx			; Stack År°tÇs
	ret				; VisszatÇrÇs
resoke:
	push	ax			; MaradÇk mentÇs
	push	dx			; Lapsz†m mentÇs
varosa:
	mov	dx,cs:[xmshnd]		; EMS handle
	mov	ah,47h			; Save mapping k¢dja
	int	67h			; EMS kezelî h°v†s
	or	ah,ah			; Sikeres volt ?
	je	sikvom			; Igen, sikeres volt
	cmp	ah,82h			; EMS foglalt ?
	je	varosa			; Igen, v†runk
	pop	dx			; Lapsz†m elimin†l†s
	pop	dx			; MaradÇk vissza
	mov	al,2			; VisszatÇrÇsi hibak¢d
	cmp	ah,8ch			; Full ?
	je	hisava			; Igen, hiba
	cmp	ah,8dh			; Volt m†r ?
	ja	hisava			; Igen, hiba
	mov	al,0ch			; Ez a m†sik hibak¢d
hisava:
	stc				; Hibajel
	pop	dx			; Stack År°tÇs
	pop	dx			; Stack År°tÇs
	ret				; VisszatÇrÇs
sikvom:
	pop	dx			; Lapsz†m vissza
	pop	ax			; MaradÇk vissza
	mov	cx,cs:[extruc + 2]	; Page-frame
	cmp	ax,0400h		; EnnÇl nagyobb ?
	jc	nkinan			; Nem, harmadik lapra
	cmp	ax,1000h		; EnnÇl kisebb ?
	jnc	nkinan			; Nem, harmadik lapra
	xor	ax,ax			; Lapk¢d 0
	jmp	short eltola		; Az elsî lap kellet
nkinan:
	mov	al,3			; Lapk¢d 3
	add	cx,0c00h		; Page-frame is eltolva
eltola:
	or	bh,bh			; Olvas†s ?
	jne	moirmm			; Nem °r†s
	mov	ds,cx			; Ez a forr†s
	mov	cx,16384		; Ez egy lap
	cmp	si,cx			; Nagyobb a lapmÇretnÇl ?
	jna	lamerk			; Nem, ezen a lapon van
	inc	dx			; Kîvetkezî lap
	xor	si,si			; Ott null†n kezd
lamerk:
	sub	cx,si			; CX <- mozgatand¢ byte-sz†m
	shr	cx,1			; CX <- mozgatand¢ sz¢-sz†m
darkes:
	push	bx			; Ir†s-olvas†s jelzî mentÇs
	push	dx			; Lapsz†m mentÇs
	cmp	cx,bp			; Kell-e mÇg annyit ?
	jna	bikemo			; Igen, kell
	mov	cx,bp			; Nem, csak ennyit
bikemo:
	jmp	elacse			; Vissza a kîvetkezî lapra
moirmm:
	mov	es,cx			; Ez a cÇl
	mov	cx,16384		; Ez egy lap
	cmp	di,cx			; Nagyobb a lapmÇretnÇl ?
	jc	lamerw			; Nem, ezen a lapon van
	xor	di,di			; Ott null†n kezd
	inc	dx			; Kîvetkezî lap
lamerw:
	sub	cx,di			; CX <- mozgatand¢ byte-sz†m
	shr	cx,1			; CX <- mozgatand¢ sz¢-sz†m
	jmp	darkes			; Mehet a maradÇkra
onreve:
	clc				; Sikeres jelzÇse
hiklva:
	push	ax			; K¢d mentÇs
	pushf				; Sikeres jelzî mentÇse
urfova:
	mov	dx,cs:[xmshnd]		; EMS handle
	mov	ah,48h			; Restore k¢dja
	int	67h			; EMS kezelî h°v†s
	or	ah,ah			; Sikeres volt ?
	je	sikutr			; Igen, sikeres
	cmp	ah,82h			; EMS foglalt ?
	je	urfova			; Igen, v†runk
	cmp	ah,8eh			; M†r volt k¢dja ?
	je	sikutr			; Igen, akkor is sikeres
	pop	dx			; Stack År°tÇs
	pop	dx			; Stack År°tÇs
	mov	al,0ch			; Hibak¢d
	stc				; HibajelzÇs
	ret				; VisszatÇrÇs
sikutr:
	popf				; Sikeres jelzî vissza
	pop	ax			; K¢d vissza
	ret				; VisszatÇrÇs
emsk19:
	push	ax			; AX mentÇs
	push	dx			; DX mentÇs
varclr:
	mov	dx,cs:[xmshnd]		; EMS handle
	mov	ah,45h			; EMS visszaad†s
	int	67h			; EMS kezelî h°v†s
	cmp	ah,82h			; EMS foglalt ?
	je	varclr			; Igen, v†runk
	pop	dx			; DX vissza
	push	ds			; DS elromlik
	xor	ax,ax			; AX <- 0
	mov	ds,ax			; DS <- 0
	mov	ax,cs:[xmsrut]		; 19-es offszet
	cli				; Most IT. ne jîjjîn
	mov	ds:[19h * 4],ax 	; Offszet vissza
	mov	ax,cs:[xmsrut + 2]	; 19-es paragrafusa
	mov	ds:[(19h * 4) + 2],ax	; Paragrafus vissza
	pop	ds			; DS vissza
	pop	ax			; AX vissza
	int	19h			; Folytassa

	if	($ - emskez) AND 1	; Ha a hossz p†ratlan
emskev	equ	$ + 1			; Akkor egyel hosszabb
	else
emskev	equ	$			; Ha nem, akkor itt a vÇge
	endif

rammer	dw	40h			; MÇret (Kbyte-ban)
konsam	db	1			; Konstans sz†ml†l¢
inijel	db	1			; Inicializ†l†s jelzî
kavoje	db	0			; Kapcsol¢ volt jelzî
rootse	dw	0			; ROOT hossz

	if	xmskev GT emskev - (emskez - xmskez)
szacit	dw	xmskev,0		; A szabad ha XMS nagyobb
	else
szacit	dw	emskev - (emskez - xmskez),0; A szabad ha EMS nagyobb
	endif

bpbpar	dw	0			; A BPB paragrafusa
versio	dw	0			; Ide jîn majd a verzi¢
sysjel	db	0			; Rendszermem¢ria jelzî

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	XMS ind°t¢.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
xmsope:
	mov	ax,4300h		; Ez a kÇrdezÇs k¢dja
	int	2fh			; MULTIPLEX
	cmp	al,80h			; Sikeres ?
	je	talxms			; Igen, van XMS
	mov	dx,offset xmsnot	; Szîvegc°m
nemsim:
	jmp	strkir			; Ki°rat†s DX szerint
talxms:
	push	es			; ES romlik
	mov	ax,4310h		; Vektor kÇrÇs k¢dja
	int	2fh			; MULTIPLEX
	mov	[xmsrut],bx		; XMS kezelî offszet
	mov	[xmsrut + 2],es 	; XMS kezelî paragrafus
	pop	es			; ES vissza
	mov	ah,8			; XMS mÇretlekÇrdezÇs k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	or	ax,ax			; Volt hiba ?
	jne	hitani			; Nem, tal†n nem
	test	bl,80h			; Van extended mem¢ria ?
	mov	dx,offset noexme	; Szîvegc°m
	je	nemsim			; Nincs, azÇrt van a hiba
	mov	dx,offset exmalh	; Szîvegc°m
	jmp	short nemsim		; Hib†val kilÇpÇs
hitani:
	mov	dx,offset ninele	; Szîvegc°m
	cmp	ax,10h			; EnnÇl kisebb a k¢d ?
	jc	nemsim			; Igen, nincs mem¢ria
	cmp	[rammer],ax		; Nagyobb mint a mÇret ?
	jna	nemnab			; Ha nem nagyobb mint a mÇret
	mov	[rammer],ax		; Uj mÇret (Kbyte)
nemnab:
	mov	dx,[rammer]		; MÇret (Kbyte)
	mov	ah,9			; XMS allok†l†s k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	or	ax,ax			; Volt hiba ?
	jne	vanrac			; Nem, sikerÅlt
	mov	dx,offset exmalh	; Szîvegc°m
	jmp	short nemsim		; Hib†val kilÇpÇs
vanrac:
	mov	[xmshnd],dx		; XMS handle
	ret				; VisszatÇrÇs (CY <- 0 !!!)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	EMS ind°t¢.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
emsope:
	mov	ax,3567h		; 67-es vektor lekÇrdezÇs
	int	21h			; DOS h°v†s
	mov	di,0ah			; EszkîznÇv offszet
	mov	si,offset emmxxx	; Itt van az EMS neve
	mov	cx,8			; Ennyi a nÇv
	rep	cmpsb			; ôsszehasonlit†s
	je	talkez			; Ha simmel, van EMS
	mov	dx,offset emsnin	; Szîvegc°m
	jmp	strkir			; Ki°rat†s DX szerint
talkez:
	mov	cx,8000h		; Ennyiszer v†runk
streva:
	mov	ah,40h			; St†tusz beolvas†s k¢dja
	int	67h			; EMS kezelî h°v†s
	cmp	ah,0			; Sikeres ?
	je	sikstk			; Igen, mehet
	cmp	ah,82h			; EMS foglalt ?
	loopz	streva			; Igen, v†runk
emskhi:
	mov	dx,offset emssta	; Szîvegc°m
emshib:
	jmp	strkir			; KilÇpÅnk, hiba van
sikstk:
	mov	ah,46h			; Mi a paragrafusa ?
	int	67h			; EMS kezelî h°v†s
	cmp	ah,82h			; EMS foglalt ?
	je	sikstk			; Igen, v†runk
	cmp	ah,0			; Sikeres ?
	jne	emskhi			; Nem, hibaÅzenet
	cmp	al,40h			; A kezelî van 4.00 ?
	jc	nemjve			; Nincs, nem nÇzzÅk meg
	mov	ax,5800h		; LekÇpzÇskÇrÇs k¢dja
	push	ds			; Ebbîl lesz ES
	pop	es			; ES <- DS
	mov	di,offset secpuf	; Itt van szabad terÅlet
	mov	si,di			; Innen kell beolvasni is
	int	67h			; EMS kezelî h°v†s
	cmp	ah,0			; Sikeres ?
	jne	emskhi			; Nem, hibaÅzenet
	cld				; Nîvekvî stringmÅveletek
ofnuke:
	lodsw				; Paragrafus
	lodsw				; Ofszet
	or	ax,ax			; Lapsz†m = 0 ?
	je	ofnuta			; Igen, az offszet nulla
	loop	ofnuke			; Ha van mÇg, akkor tov†bb
ofnuta:
	mov	dx,ax			; Offszet m†solat
	mov	bx,[si - 4]		; Ez a paragrafusc°m
	mov	cx,3			; MÇg 3 lapot ellenîrzîk
ezalap:
	inc	dx			; Lapsz†m nîvelÇs
	add	bx,1024 		; Ennyi paragrafus egy lap
	lodsw				; Kîvetkezî paragrafusc°m
	cmp	ax,bx			; Ez az a c°m ?
	jne	emskhi			; Nem, hibaÅzenet
	lodsw				; Lapsz†m beolvas†s
	cmp	ax,dx			; Ez az a lapsz†m ?
	jne	emskhi			; Nem, hibaÅzenet
	loop	ezalap			; Lapellenîrzî ciklus
nemjve:
	mov	ah,41h			; Mi a paragrafusa ?
	int	67h			; EMS kezelî h°v†s
	cmp	ah,82h			; EMS foglalt ?
	je	nemjve			; Igen, v†runk
	cmp	ah,0			; Sikeres ?
	jne	emskhi			; Nem, hibaÅzenet
	mov	[extruc],0		; Offszet
	mov	[extruc + 2],bx 	; Paragrafus
vaheke:
	mov	ah,42h			; HelykÇrdÇs
	int	67h			; EMS kezelî h°v†s
	cmp	ah,82h			; EMS foglalt ?
	je	vaheke			; Igen, v†runk
	cmp	ah,0			; Sikeres ?
	jne	emskhi			; Nem, hibaÅzenet
	mov	ax,dx			; Ez a teljes hossz
	mov	dx,offset noexme	; Szîvegc°m
	or	ax,ax			; Van valamennyi ?
	jne	ehiban			; Igen, van
emshit:
	jmp	emshib			; Nincs ki°rjuk a hib†t
ehiban:
	mov	dx,offset ninele	; Szîvegc°m
	or	bx,bx			; Van szabad ?
	je	emshit			; Nincs, ki°rjuk a hib†t
	test	bx,0f000h		; A felsî 4 bit van ?
	jne	nemeva			; Igen, ennyi van
	mov	cx,4			; Hatv†nyoz¢ ÇrtÇk
	shl	bx,cl			; BX <- Kbyte
	cmp	[rammer],bx		; A mÇret belefÇr ?
	jna	nemeva			; Igen, belefÇr
	mov	[rammer],bx		; Uj mÇret (Kbyte)
nemeva:
	mov	bx,[rammer]		; MÇret (Kbyte)
	mov	ax,bx			; MÇret m†solat
	mov	cx,4			; Hatv†nyoz¢ ÇrtÇk
	shr	bx,cl			; BX <- lapsz†m
	test	ax,0fh			; Volt maradÇk ?
	je	poanyi			; Nem, ennyivel ennyi
	inc	bx			; Egy lappal tîbb
	push	bx			; Ez az £j mÇret
	mov	cx,4			; Hatv†nyoz¢ ÇrtÇk
	shl	bx,cl			; BX <- mÇret (Kbyte)
	mov	[rammer],bx		; MÇret (Kbyte)
	pop	bx			; Lapsz†m vissza
poanyi:
	mov	ah,43h			; Open handle k¢dja
	int	67h			; EMS kezelî h°v†s
	cmp	ah,82h			; EMS foglalt ?
	je	poanyi			; Igen, v†runk
	cmp	ah,0			; Sikeres ?
	je	sifopa			; Igen, sikeres
	cmp	ah,86h			; Save hiba ?
	je	fahita			; Igen, fat†lis
	cmp	ah,85h			; Nincs tîbb handle ?
	jc	fahita			; Ha ennÇl kisebb a hiba
	mov	dx,offset ninele	; Szîvegc°m
	jmp	strkir			; Ki°rat†s, hiba van
fahita:
	jmp	emskhi			; Fat†lis hib†ra
sifopa:
	mov	[xmshnd],dx		; EMS handle
	mov	si,offset kprdve	; ô a tulajdonos
	mov	ax,5301h		; Tulajdonos be†ll°t†s k¢dja
	int	67h			; Tulajdonos kÇrdÇs
	cmp	ah,0			; Sikeres ?
	jne	fahita			; Nem, hibaÅzenet
	clc				; Sikeres jelzÇse
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Rendszermem¢ria inicializ†l¢.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sysini:
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	mov	si,offset syskez	; Saj†t rutin c°me
	mov	di,offset xmskez	; Kezelî fejc°m
	mov	cx,(syskev - syskez) / 2; A rutin helymÇrete sz¢ban
	rep	movsw			; ètm†soljuk
	cmp	[versio],0500h		; Verzi¢sz†m kisebb ?
	jc	kivema			; Igen, kisebb
	push	es			; Elmentem
	les	bx,dword ptr [bufcim]	; ES:BX <- pufferc°m
	mov	ax,es:[bx + 10h]	; AX <- paragrafussz†m
	pop	es			; ES vissza
	jmp	short mameva		; M†r meg is van

kivema:
	int	12h			; Mem¢ria hossz kÇrÇs
	mov	cl,6			; LÇptetÇsi sz†m
	shl	ax,cl			; AX <- paragrafussz†m
mameva:
	mov	bx,ax			; M†solat
	mov	word ptr [sysini - 4],ax; Ez a maximum
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	inc	byte ptr [sysjel]	; Jelzî inkrement
	mov	[inijel],2		; MÇretsz†m°t†s
	mov	ax,offset syskev - (syskez - xmskez); Itt kell kezdîdenie
	add	ax,15			; Paragrafuson t£lra tol†s
	mov	cl,4			; Ennyivel lÇptetjÅk
	shr	ax,cl			; AX <- paragrafusc°m
	mov	dx,cs			; DX <- saj†t paragrafusom
	add	ax,dx			; Eltolom vele
	push	ax			; Ennyi a hossz
	mov	cx,16			; Most megszorzom ennyivel
	mul	cx			; DX:AX abszol£t c°m
	mov	[extruc],ax		; C°m L sz¢
	mov	[extruc + 2],dx 	; C°m H sz¢
	pop	ax			; Hossz vissza
	mov	dx,[rammer]		; MÇret
	test	dx,0fc00h		; Be vannak †llitva ?
	jne	tusobe			; Igen, t£l sok
	mov	cl,6			; Paragrafusra hatv†ny
	shl	dx,cl			; Ennyi paragrafusban
	add	ax,dx			; Ennyi az îsszes hossz
	jc	tusobe			; Ha annyi hely nincs
taenhe:
	mov	dx,word ptr [sysini - 4]; Maximum t†r
	cmp	[versio],0500h		; A verzi¢ kisebb mint 5.00 ?
	jnc	vemaen			; Nem, hiba legyen
	sub	dx,3072 		; Ennyi marad ?
	jc	tusobe			; Nem, hiba
vemaen:
	cmp	ax,dx			; Maradt hely ?
	ja	tusobe			; Nem, ciki
	mov	[szacit],0		; Ez a maradÇk offszetje
	mov	[szacit + 2],ax 	; Ez a maradÇk szegmense
	clc				; Jelzî be†ll°t†s
	ret				; VisszatÇrÇs
tusobe:
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	mov	dx,offset ninele	; Szîvegc°m

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	String ki°rat†sa.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
strkir:
	cmp	byte ptr cs:[dumtip],0	; Csîndben ?
	jnz	csomst			; Vissza, csîndben vagyunk
	push	ds			; El fogom rontani
	push	cs			; Ebbîl lesz a DS
	pop	ds			; DS <- CS
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ds			; Eredeti DS vissza
csomst:
	stc				; Hibajelzî
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Rendszermem¢ria kezelî. 			;
;							;
;	Input:	DX:AX <- kezdî poz°ci¢			;
;		BH    <- 0 --> olvas†s			;
;		BH    <- 1 --> °r†s			;
;		CX    <- sz¢sz†m			;
;		ES:DI <- puffer 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
syskez:
	add	ax,[extruc]		; Eltol†s offszettel
	adc	dx,[extruc + 2] 	; Eltol†s paragrafussal
	push	cx			; Sz¢sz†m mentÇs
	mov	cx,16			; Paragrafushossz
	div	cx			; AX <- paragrafus eleje
	pop	cx			; Sz¢sz†m vissza
	or	bh,bh			; Olvas†s ?
	je	sysrdv			; Igen, nem lesz csere
	push	es			; Ebbîl lesz DS
	pop	ds			; DS <- ES
	mov	si,di			; Innen veheti
	mov	es,ax			; Ide tegye (paragrafus)
	mov	di,dx			; Ide tegye (offszet)
movvhs:
	rep	movsw			; ètm†soljuk
	clc				; Sikeres jelzî
	ret				; VisszatÇrÇs
sysrdv:
	mov	ds,ax			; Innen vegye (paragrafus)
	mov	si,dx			; Innen vegye (offszet)
	jmp	movvhs			; M†sol†sra

	if	($ - syskez) AND 1	; Ha a hossz p†ratlan
syskev	equ	$ + 1			; Akkor egyel hosszabb
	else
syskev	equ	$			; Ha nem, akkor itt a vÇge
	endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ez a direktory label-je.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

labelh	db	'KP-RAMDRIVE'           ; Ez a c°mke neve
	db	8			; ATTR (label)
	db	10 dup(0)		; Reserved
	dw	0000000000000000b	; Idî
	datdef	<>			; Record kipakol†s
	dw	0			; Cluster
	dw	0,0			; Hossz

secpuf	dw	512  dup(0)		; Szektor puffer

utmasc	label	byte			; Id†ig fog m†solni

emsnin	db	'RAMDRIVE: Expanded Memory Manager-t (EMS) nem tal†lok !',0dh,0ah,'$'
emssta	db	'RAMDRIVE: Expanded Memory Manager (EMS) hiba !',0dh,0ah,'$'
xmsnot	db	'RAMDRIVE: Extended Memory Manager-t (XMS) nem tal†lok !',0dh,0ah,'$'
noexme	db	'RAMDRIVE: Nincs extended mem¢ria !',0dh,0ah,'$'
badext	db	'RAMDRIVE: Hib†s az Extended Memory Manager (XMS) parancs-l†nc !',0dh,0ah,'$'
exmalh	db	'RAMDRIVE: Hiba az extended mem¢ria foglal†sn†l !',0dh,0ah,'$'
parhib	db	'RAMDRIVE: Helytelen paramÇter !',0dh,0ah,'$'
ninele	db	'RAMDRIVE: KevÇs a mem¢ria !',0dh,0ah,'$'
iohiba	db	'RAMDRIVE: Hiba az inicializ†l†s sor†n !',0dh,0ah,'$'
vershi	db	'RAMDRIVE: DOS verzi¢ nem megfelelî. (Nem 5.00 - 7.XX)',0dh,0ah,'$'
secadj	db	'RAMDRIVE: Helytelen paramÇter: szektor hossz m¢dos°tva !',0dh,0ah,'$'

fejlec	db	0dh,0ah
	db	'Keresztes RAMDRIVE '
	vernum
	db	'-es verzi¢ '

drvsam	db	'A:',0dh,0ah,'$'
dsizsz	db	'    DiskmÇret: $'
sectsz	db	'k',0dh,0ah
	db	'    Szektorhossz: $'
alluni	db	' byte',0dh,0ah
	db	'    Cluster szektorsz†m: $'
entdar	db	' szektor',0dh,0ah
	db	'    Kînyvt†rbejegyzÇsek sz†ma: $'
crlfcs	db	0dh,0ah,'$'

kprdve	db	'KPRDV'                 ; Tulajdonos az EMSnÇl
	hndnum

dumtip: db	0			; Nincs duma jelzÇs, ha nem 0

	ifndef	 sysdef

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A RAMDRIVE program vÇgrehajtva. (COM program)	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:
	mov	ah,0dh			; DISK alaphelyzetbe
	int	21h			; DOS h°v†s
	mov	ax,cs			; Itt tartok
	add	ax,10h			; Eltolom
	push	ax			; Ez lesz az £j CS
	mov	ax,offset folyta	; Itt lesz az igazi c°m
	push	ax			; Az £j offszet
	retf				; A "folyta" c°mre ugrok
folyta:
	cld				; Nîvekvî stringmÅveletek
	mov	si,80h			; Ez a helye a paramÇterle°r¢nak
	lodsb				; Beolvasom
	or	al,al			; Nulla ?
	jne	vanval			; Nem, valamennyi van
helkar:
	mov	dx,offset helpsz	; Szîvegc°m
kirexi:
	call	strkir			; Stringki°rat†s
cshiki:
	mov	ax,4c01h		; KilÇpÇs hib†san k¢dja
	int	21h			; DOS h°v†s
vanval:
	call	utolso			; Z†r¢karakter ?
	cmp	al,'z'                  ; EnnÇl nagyobb ?
	ja	helkar			; Igen, help ki°rat†s lesz
	cmp	al,'a'                  ; EnnÇl kisebb ?
	jae	vankar			; Nem, karakter
	cmp	al,'A'                  ; EnnÇl kisebb ?
	jb	helkar			; Igen, help ki°rat†s lesz
	cmp	al,'Z'                  ; EnnÇl nagyobb ?
	ja	helkar			; Igen, help ki°rat†s lesz
vankar:
	and	al,1fh			; Ez a lemezegysÇg k¢dja
	mov	dl,al			; DL <- lemezegysÇg k¢dja
	add	al,'@'                  ; Karakteres°tÇs
	mov	cs:[drvsam],al		; Ez a drive karakteres alakja
	mov	cs:[csilla],al		; Ez a drive karakteres alakja
	lodsb				; Ez a kîvetkezî karakter
	cmp	al,':'                  ; Ez volt ?
	jnz	helkar			; Nem, help ki°rat†s lesz
	mov	ah,52h			; DOS v†ltoz¢ c°mkÇrdezÇs k¢dja
	int	21h			; DOS h°v†s
	lds	bx,es:[bx]		; Az elsî DPB k¢dja
dpbell:
	cmp	bx,0ffffh		; Nincs tîbb ?
	jne	rencit			; De, nincs problÇma
	mov	dx,offset ervlem	; Szîvegc°m
kirext:
	jmp	short kirexi		; Hiba
rencit:
	dec	dl			; Ez a sz†ml†l¢ nulla ?
	je	megtal			; Igen, ez a DPB az
	lds	bx,[bx + 19h]		; Itt van a kîvetkezî DPB
	jmp	short dpbell		; MegnÇzzÅk ÇrvÇnyes-e
megtal:
	mov	al,[bx + 1]		; Ez az alegysÇgsz†m
	mov	cs:[bpbolv + 1],al	; AlegysÇgsz†m kitîltÇs
	lds	bx,[bx + 13h]		; Itt van a DEVICE HEADER c°me
	mov	cs:[blatad + 2],ds	; Ez a blokkfogad†s paragrafusa
	mov	ax,[bx + 6]		; Ez a blokkfogad†s offszetje
	mov	cs:[blatad],ax		; Elpakolom
	mov	cs:[feldol + 2],ds	; Ez a feldolgoz†s paragrafusa
	mov	ax,[bx + 8]		; Ez a feldolgoz†s offszetje
	mov	cs:[feldol],ax		; Elpkolom
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	mov	bx,offset bpbolv	; BPB c°m kÇrdezÇs c°me
	mov	[bx + 16],cs		; Puffer szegmense
	call	dword ptr [blatad]	; ètadjuk a blokkot
	call	dword ptr [feldol]	; Feldolgoztatjuk
	mov	dx,offset hibdev	; Szîvegc°m
	mov	ax,[bx + 3]		; èllapotjelzî sz¢
	or	ax,ax			; Volt hiba ?
	js	kirext			; Igen, hibaki°rat†s
	mov	es,[bx + 20]		; Ez a BPB paragrafusc°me
	mov	di,offset jmptab	; Innen lehet îsszehasonl°tani
	push	si			; Elmentem a paramÇterc°met
	mov	si,di			; Ezzel lehet îsszehasonl°tani
	mov	cx,((xmskez - jmptab) - 1) / 2;Ennyi sz¢
	cli				; IT. most nem jîhet
	rep	cmpsw			; ôsszehasonl°t†s
	sti				; Most m†r h°vhatja
	pop	si			; C°m vissza
	mov	dx,offset nemsaj	; Szîvegc°m
	je	talsaj			; Ez a saj†tom
kirexs:
	jmp	kirexi			; Ki°rat†s hib†s kilÇpÇssel
talsaj:
	mov	di,[bx + 18]		; Ez a BPB c°me
	push	ss			; Ez a PSP c°me
	pop	ds			; DS <- PSP paragrafusc°me
	call	utolso			; Z†r¢karakter ?
	je	igpaki			; Igen, paramÇter ki°rat†s
	push	ax			; Kell kÇsîbb
	push	si			; Kell kÇsîbb
	mov	ax,es:[di + 8]		; Ennyi szektor van az eszkîzîn
	mul	word ptr es:[di]	; SzektormÇrettel szorz†s
	mov	cx,1024 		; 1 Kbyte
	div	cx			; Ennyi Kbyte
	mov	cs:[rammer],ax		; Hossz
	mov	si,offset bpbofs	; Ez a saj†tom
	mov	cx,10			; Ennyi a BPB hossza
masore:
	mov	ax,es:[di]		; Beolvasom
	mov	cs:[si],ax		; Kipakolom
	cmpsw				; DI <- DI + 2, SI <- SI + 2
	loop	masore			; RÇgi paramÇterek m†sol†sa
	pop	si			; Vissza
	pop	ax			; Vissza
	jmp	nezaka			; Nem, van mÇg paramÇter
igpaki:
	push	di			; El fogom rontani
	mov	di,offset xmskez	; Ide pakoljuk
	mov	si,offset holtke	; Kezelî hiba
	mov	cx,(holtkv - holtke) / 2; Sz¢sz†m
	cli				; IT. most nem jîhet
	db	2eh			; CS elîtag
	rep	cmpsw			; Kezelî îsszehasonl°t†s
	sti				; Most m†r h°vhatja
	pop	di			; C°m vissza
	jne	erveke			; Ha nem a vÇge van ott
	mov	dx,offset maneme	; Ki°ratand¢ szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
erveke:
	mov	dx,offset fejlec	; Ki°ratand¢ szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	dx,offset dsizsz	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	ax,es:[di + 8]		; Ennyi szektor van az eszkîzîn
	mul	word ptr es:[di]	; SzektormÇrettel szorz†s
	mov	cx,1024 		; 1 Kbyte
	div	cx			; Ennyi Kbyte
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset sectsz	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	ax,es:[di]		; Szektor byte-sz†m
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset alluni	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	al,byte ptr es:[di + 2] ; Cluster-hossz
	xor	ah,ah			; H byte <- 0
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset entdar	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	ax,es:[di + 6]		; BejegyzÇssz†m
	call	decoax			; AX ki°rat†s decim†lisan
	mov	dx,offset crlfcs	; Szîvegc°m
	call	strkir			; Ki°rat†s DX szerint
	mov	dx,offset sysdev	; Szîvegc°m
	mov	al,es:[drvtip]		; Ez a tipus
	and	al,3			; ElÇg ez a kÇt bit
	cmp	al,2			; System ?
	je	strkip			; Igen, ki°ratjuk
	mov	dx,offset emsdev	; Szîvegc°m
	dec	al			; Expanded ?
	je	strkip			; Igen, ki°ratjuk
	mov	dx,offset xmsdev	; Szîvegc°m
strkip:
	call	strkir			; Ki°rat†s DX szerint
kiloke:
	mov	ax,4c00h		; KilÇpÇs sikeresen k¢dja
	int	21h			; DOS h°v†s
nezaka:
	mov	dx,offset sysnem	; Szîvegc°m
	test	es:[drvtip],2		; System ?
	je	nesifo			; Nem, mehet
	jmp	kirexi			; Igen, az nem lehet
nesifo:
	cmp	al,'/'                  ; Kapcsol¢ ?
	jne	konviz			; Ez nem, tal†n konstans
	lodsb				; Beolvassuk
	test	cs:[drvtip],2		; Volt m†r ?
	jne	mehkar			; Nem, elemezzÅk
hivahe:
	cmp	al,'Q'                  ; Csînd ?
	je	dumoff			; Igen, az lesz
	cmp	al,'q'                  ; Csînd ?
	je	dumoff			; Igen, az lesz
	jmp	helkar			; Help ki°rat†s
mehkar:
	cmp	al,'E'                  ; Extended ?
	je	exjeva			; Igen, az lesz
	cmp	al,'e'                  ; Extended ?
	jne	expest			; Nem, esetleg Axpanded
exjeva:
	mov	cs:[drvtip],0		; Extended jelzÇs
	jmp	short jeleli		; JelzÇs ut†nra
expest:
	cmp	al,'A'                  ; Axpanded ?
	je	expjva			; Igen, az lesz
	cmp	al,'a'                  ; Axpanded ?
	je	expjva			; Igen, az lesz
	cmp	al,'O'                  ; Kikapcsol†s
	je	expoff			; Igen, az lesz
	cmp	al,'o'                  ; Kikapcsol†s
	je	expoff			; Igen, az lesz
	cmp	al,'Q'                  ; Csînd ?
	je	dumoff			; Igen, az lesz
	cmp	al,'q'                  ; Csînd ?
	je	dumoff			; Igen, az lesz
	jne	hivahe			; Igen, az lesz
dumoff:
	mov	byte ptr cs:[dumtip],0ffh; Nincs duma jelzÇs
	jmp	short jeleli		; JelzÇs ut†nra
expoff:
	mov	cs:[drvtip],0ffh	; Kikapcsol†s jelzÇs
	jmp	short jeleli		; JelzÇs ut†nra
expjva:
	mov	cs:[drvtip],1		; Axpanded jelzÇs
jeleli:
	call	utolso			; Van mÇg ?
	jne	nesifo			; Igen, van mÇg
	jmp	utocat			; Nincs tîbb
konviz:
	dec	si			; Vissza a sz†mjegyre
	call	conbeo			; Konstans beolvas†s
	cmp	cs:[konsam],3		; Harmadik ut†n ?
	ja	hivahe			; Igen, hiba
	je	hakobe			; Ha az, mehet
	cmp	cs:[konsam],2		; M†sodik ?
	je	szemem			; Igen, szektormÇret
	cmp	bx,4			; EnnÇl nagyobb ?
	jc	hivahe			; Nem, hiba
	cmp	bx,32768		; Nagyobb ?
	jnc	hivahe			; Nagyobb, hiba
	mov	cs:[rammer],bx		; MÇret
	jmp	short szainm		; Sz†ml†l¢ nîvelÇsre
szemem:
	mov	cs:[bpbofs],bx		; Uj mÇret
	mov	dx,cs:[rammer]		; MÇret
	mov	al,6			; Ez a kezdî hatv†ny
	cmp	bx,128			; Ennyi ? (2**6 sz¢)
	jne	nekmfb			; Nem, kîvetkezîre
	cmp	dx,8192 		; 8 Kbyte-n†l kisebb ?
	jc	takesm			; Igen, °gy meg is felel
	shl	bx,1			; Dupl†zzuk
nekmfb:
	inc	al			; Hatv†ny nîvelÇs
	cmp	bx,256			; Ennyi ? (2**7 sz¢)
	jne	nekmeb			; Nem, kîvetkezîre
	cmp	dx,16384		; 16 Kbyte-n†l kisebb ?
	jc	takesm			; Igen, °gy meg is felel
	shl	bx,1			; Dupl†zzuk
nekmeb:
	inc	al			; Hatv†ny nîvelÇs
	cmp	bx,512			; Ennyi ? (2**8 sz¢)
	je	takesm			; Igen, °gy meg is felel
hivahs:
	jmp	helkar			; Help ki°rat†s
takesm:
	mov	byte ptr cs:[bpbofs + 19],al; Hatv†nysz†m mentÇs
	cmp	bx,cs:[bpbofs]		; Azonos a tervezettel ?
	je	szainm			; Igen, sz†ml†l¢ nîvelÇsre
	mov	cs:[bpbofs],bx		; Ez lesz az igazi
	mov	dx,offset secadj	; Szîvegc°m
	call	strkir			; Ki°ratjuk
	jmp	short szainm		; Sz†ml†l¢ nîvelÇsre
hakobe:
	cmp	bx,2			; Ennyi van ?
	jc	hivahs			; Ha nincs hiba
	cmp	bx,1024 		; EnnÇl nagyobb
	ja	hivahs			; Igen, ez hiba
	mov	di,cs:[bpbofs]		; Szektor byte-sz†m
	mov	cl,5			; LÇptetÇssz†m
	shr	di,cl			; Ennyi bejegyzÇs fÇr
	mov	ax,bx			; AX <- konstans
	xor	dx,dx			; DX <- 0
	div	di			; Ennyi bejegyzÇs lehet
	or	dx,dx			; MaradÇk 0 ?
	je	nekasb			; Igen, ennyi bejegyzÇs lesz
	sub	di,dx			; Ennyi maradna
	add	bx,di			; MegnîveljÅk annyival
nekasb:
	mov	cs:[bpbofs + 6],bx	; BejegyzÇssz†m
szainm:
	inc	cs:[konsam]		; Konstans sz†ml†l¢ ++
	jmp	jeleli			; Tov†bbi paramÇterre
utocat:
	mov	dx,offset syslet	; Szîvegc°m
	cmp	cs:[drvtip],2		; System ?
	jne	nesile			; Nem, mehet a csere-bere
bajled:
	jmp	kirexi			; Igen, hibajelzÇs
nesile:
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	test	es:[drvtip],80h 	; Kikapcsolt ?
	jne	nekerf			; Igen, nem kÇrdezzÅk meg
	mov	ah,19h			; Aktu†lis egysÇg kÇrdezÇs k¢dja
	int	21h			; DOS h°v†s
	add	al,'A'                  ; Karakteres°tÇs
	mov	dx,offset akttil	; Szîvegc°m
	mov	si,offset csilla	; Ez a gyîkÇr le°r¢
	cmp	al,[si] 		; Ez az aktu†lis ?
	je	bajled			; Ha ez az aktu†lis is
	mov	dx,si			; Ez a gyîkÇr le°r¢
	mov	cx,0ffffh		; Attributum
	mov	ah,4eh			; Elsî hivatkoz†s k¢dja
kokere:
	int	21h			; DOS h°v†s
	jc	lehehi			; Ha hib†val futott
	mov	ax,4f00h		; Ez a tov†bbkeresÇs k¢dja
	test	byte ptr ss:[80h + 21],8; Label ?
	jne	kokere			; Igen, tov†bbkeresÇs
lehehi:
	mov	dx,offset fogdrv	; Szîvegc°m
	cmp	al,2			; File not found k¢dja ?
	je	nekerf			; Igen, nincs rajta
	cmp	al,18			; Nincs tîbb file k¢dja ?
	jne	bajled			; Nem, hiba
nekerf:
	mov	di,offset xmskez	; Ide pakoljuk
	mov	si,offset holtke	; Kezelî hiba
	mov	cx,(holtkv - holtke) / 2; Sz¢sz†m
	cli				; IT. most nem jîhet
	mov	es:[csekod],0		; JelzÇs, hogy cserÇltÇk
	rep	movsw			; Kezelî †tm†sol†s
	sti				; Most m†r h°vhatja
	or	es:[drvtip],80h 	; Jelenleg ki van kapcsolva
	mov	ax,0ffffh		; Nem volt handle k¢dja
	mov	dx,ax			; M†solat
	xchg	dx,es:[xmshnd]		; ?MS handle
	test	es:[drvtip],3		; EMS ?
	je	xmsrem			; Nem, jelenleg XMS
	cmp	dx,ax			; Volt EMS handle ?
	je	emsnhn			; Nem, mÇg nem volt
	mov	ah,45h			; Close k¢dja
	int	67h			; EMS kezelî h°v†s
emsnhn:
	cmp	[drvtip],0ffh		; Kikapcsol†s legyen ?
	je	emskik			; Igen, pr¢b†ljuk meg
	cmp	[drvtip],1		; EMS legyen ? (Az is volt !)
	je	remoks			; Igen, nem kell EMS remove
emskik:
	mov	ax,0ffffh		; JelzÇs, hogy nincs
	cmp	es:[xmsrut],ax		; Nincs vektor 1. ?
	jne	kekika			; De van !
	cmp	es:[xmsrut + 2],ax	; Nincs vektor 2. ?
remoks:
	je	remoke			; Igen, mehet m†sik is
kekika:
	push	ds			; ElmentjÅk
	push	es			; ElmentjÅk
	push	es			; Ebbîl lesz DS
	mov	dx,es			; Ezzel kell îsszehasonl°tani
	mov	ax,3519h		; Ez a vektor most
	int	21h			; DOS h°v†s
	pop	ds			; DS <- ES
	mov	ax,es			; Ez a paragrafus
	cmp	ax,dx			; Azonosak ?
	mov	dx,offset vekelt	; Szîvegc°m
	je	segazo			; Igen, offszetet is kell !
kirexm:
	cmp	cs:[drvtip],0ffh	; Kikapcsol†s ?
	je	remokj			; Igen, kikapcsoljuk
	jmp	kirexi			; Igen, hibajelzÇs
segazo:
	cmp	bx,offset emsk19 - (emskez - xmskez); Ez a kezelî c°me
	jne	kirexm			; Hiba
	call	tikivi			; 19-es vektor helyre†ll°t†s
	jmp	short remokr		; 19-es REMOVE rendben
xmsrem:
	cmp	dx,ax			; Volt XMS handle ?
	je	nevhnm			; Nem, mÇg nem volt
	mov	ah,0dh			; XMS rîgz°tÇs elengedÇs k¢dja
	call	dword ptr es:[xmsrut]	; XMS kezelî
	mov	ah,0ah			; XMS visszaad†s k¢dja
	call	dword ptr es:[xmsrut]	; XMS kezelî
nevhnm:
	cmp	[drvtip],0ffh		; Kikapcsol†s legyen ?
	je	xmskik			; Igen, pr¢b†ljuk meg
	cmp	[drvtip],0		; XMS legyen ? (Az is volt !)
	je	remoke			; Igen, nem kell a remove
xmskik:
	mov	ax,0ffffh		; Nincs kezelî ?
	cmp	es:[jmppos],ax		; Volt kezelî m†r ?
	jne	tavokm			; Igen, volt m†r
	cmp	es:[jmppos + 2],ax	; Volt kezelî m†r ?
	je	remoke			; Nem, eddig mÇg nem
tavokm:
	mov	dx,offset vekelx	; Szîvegc°m
	cmp	word ptr es:[hikehe],03ebh; Short jmp k¢dja van ?
	jne	kirexm			; Nem lehet vissza°rni
	push	ds			; ElmentjÅk
	push	es			; ElmentjÅk
	push	es			; Ebbîl lesz DS
	pop	ds			; DS <- ES
	call	nevhnd			; Handle vissza°r†s
remokr:
	or	es:[drvtip],40h 	; Jelenleg remove van
remokj:
	pop	es			; Vissza
	pop	ds			; Vissza
remoke:
	cmp	[drvtip],0ffh		; Kikapcsol†s ?
	jne	drvtiv			; Nem, t°pusvizsg†lat
	jmp	kiloke			; KilÇpÇs sikeresen
drvtiv:
	cmp	[drvtip],1		; EMS ?
	jne	xmskei			; Nem, XMS lesz
	mov	si,offset emskez	; Saj†t rutin c°me
	mov	di,offset xmskez	; Kezelî fejc°m
	mov	cx,(emskev - emskez) / 2; A rutin helymÇrete sz¢ban
	cli				; IT. ne jîjjîn
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	push	es			; Elromlana
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	mov	si,offset emskez	; Saj†t rutin c°me
	mov	di,offset xmskez	; Kezelî fejc°m
	mov	cx,(emskev - emskez) / 2; A rutin helymÇrete sz¢ban
	cli				; IT. ne jîjjîn
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	call	emsope			; EMS nyit†s
	pop	es			; ES vissza
	jnc	siopke			; EMS sikeres nyit†s (OK handle)
nsixop:
	jmp	cshiki			; KilÇpÇs hib†val
siopke:
	push	es			; Elrontja a rutin
	push	cs			; Ez lesz a c°m
	pop	ds			; DS <- CS
	call	drvini			; Drive inicializ†l†s
	pop	es			; ES vissza
	jnc	sikine			; Ha sikerÅlt inicializ†lni
	mov	dx,0ffffh		; Ez legyen helyette
	xchg	dx,[xmshnd]		; Ezt kell megszÅntetni
	mov	ah,45h			; Close k¢dja
	int	67h			; EMS kezelî h°v†s
xmsnoi:
	mov	dx,offset ninele	; Szîvegc°m
	jmp	kirexi			; Igen, hibajelzÇs
sikine:
	push	es			; Elrontja
	test	es:[drvtip],40h 	; Remove volt ?
	jne	remoem			; Igen, nem problÇma
	les	bx,dword ptr es:[xmsrut]; Ez az eredeti vektor
	mov	[xmsrut],bx		; Offszet elpakol†s
	mov	[xmsrut + 2],es 	; Paragrafus elpakol†s
	jmp	short emsvol		; Igen, nem problÇma
remoem:
	mov	ax,3519h		; 19-es vektor lekÇrdezÇs
	int	21h			; DOS h°v†s
	mov	[xmsrut],bx		; Offszet elpakol†s
	mov	[xmsrut + 2],es 	; Paragrafus elpakol†s
	pop	es			; ES vissza
	push	es			; ES vissza
	push	ds			; Ez a CS is
	push	es			; Ebbîl lesz DS
	pop	ds			; DS <- ES
	mov	dx,offset emsk19 - (emskez - xmskez); Ez a kezelî c°me
	mov	ax,2519h		; 19-es vektor m¢dos°t†s
	int	21h			; DOS h°v†s
	pop	ds			; DS <- CS
emsvol:
	pop	es			; ES vissza
	mov	es:[drvtip],1		; EMS lett
	jmp	inikes			; Befejezve
xmskei:
	mov	si,offset xmskez	; Saj†t rutin c°me
	mov	di,si			; Kezelî fejc°m
	mov	cx,(xmskev - xmskez) / 2; A rutin helymÇrete sz¢ban
	cli				; IT. ne jîjjîn
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	call	xmsope			; XMS handle nyit†s
	jc	nsixop			; Ha nem sikeres
	test	es:[drvtip],40h 	; Remove volt ?
	jne	remoxm			; Igen, nem problÇma
	push	es			; El fogja rontani
	les	bx,dword ptr es:[jmppos]; Ez az eredeti vektor
	mov	[jmppos],bx		; Offszet elpakol†s
	mov	[jmppos + 2],es 	; Paragrafus elpakol†s
	pop	es			; ES vissza
	push	es			; El fogja rontani
	les	bx,dword ptr es:[extruc]; Ez az eredeti vektor
	mov	[extruc],bx		; Offszet elpakol†s
	mov	[extruc + 2],es 	; Paragrafus elpakol†s
	pop	es			; ES vissza
	jmp	short xmsvol		; Igen, nem problÇma
remoxm:
	mov	si,offset hikehe	; Saj†t rutin c°me
	mov	di,si			; Kezelî fejc°m
	mov	cx,(xmskev - hikehe) / 2; A rutin helymÇrete sz¢ban
	cli				; IT. ne jîjjîn
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	mov	[bpbpar],es		; Ez legyen a kezelî c°me
	push	es			; Elromlik
	call	extrui			; XMS kezelî inicializ†l†s
	pop	es			; ES vissza
	jnc	xmsvol			; Ha sikerÅlt
	mov	dx,0ffffh		; Ez legyen helyette
	xchg	dx,[xmshnd]		; Ezt kell megszÅntetni
	mov	ah,0dh			; XMS rîgz°tÇs elengedÇs k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	mov	ah,0ah			; XMS visszaad†s k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	jmp	cshiki			; KilÇpÇs hib†val
xmsvol:
	mov	si,offset xmsrut	; ParamÇterek c°me
	mov	di,si			; ParamÇterek c°me
	mov	cx,7			; A BPB helymÇrete sz¢ban
	cli				; IT. most nem jîhet
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	push	es			; El fogja rontani
	call	drvini			; Drive inicializ†l†s
	pop	es			; ES vissza
	jnc	sikikx			; Ha sikerÅlt inicializ†lni
	mov	dx,0ffffh		; Ez legyen helyette
	xchg	dx,[xmshnd]		; Ezt kell megszÅntetni
	mov	ah,0dh			; XMS rîgz°tÇs elengedÇs k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	mov	ah,0ah			; XMS visszaad†s k¢dja
	call	dword ptr [xmsrut]	; XMS kezelî
	test	es:[drvtip],40h 	; Remove volt ?
	je	neremo			; HibajelzÇsre
	push	es			; ElmentjÅk
	call	nevhnd			; Handle vissza°r†s
	pop	es			; Vissza
neremo:
	jmp	xmsnoi			; Ha nem sikeres
sikikx:
	mov	es:[drvtip],0		; XMS lett
inikes:
	mov	si,offset bpbofs	; Saj†t BPB c°me
	mov	di,si			; A kezelî BPB c°me
	mov	cx,10			; A BPB helymÇrete sz¢ban
	cli				; IT. most nem jîhet
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	mov	si,offset xmsrut	; ParamÇterek c°me
	mov	di,si			; ParamÇterek c°me
	mov	cx,7			; A BPB helymÇrete sz¢ban
	cli				; IT. most nem jîhet
	rep	movsw			; ètm†soljuk
	sti				; Most m†r jîhet
	jmp	kiloke			; KilÇpÇs sikeresen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Utols¢ karakter vizsg†lat			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
holtke:
	mov	cs:[csekod],0		; JelzÇs, hogy cserÇltÇk
	mov	al,7			; Hibak¢d
	stc				; Hibajel
	ret				; VisszatÇrÇs

	if	($ - holtke) AND 1	; Ha a hossz p†ratlan
holtkv	equ	$ + 1			; Akkor egyel hosszabb
	else
holtkv	equ	$			; Ha nem, akkor itt a vÇge
	endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Utols¢ karakter vizsg†lat			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
utolso:
	lodsb				; Parancskarakter beolvas†s
	cmp	al,' '                  ; Sz¢kîz ?
	je	utolso			; Igen, £j karakter beolvas†s
	cmp	al,9			; Tabul†tor ?
	je	utolso			; Igen, £j karakter beolvas†s
	cmp	al,0dh			; CR ?
	je	igretr			; Igen, vissztÇrÇs (string vÇge)
	cmp	al,0ah			; LF ?
	je	igretr			; Igen, vissztÇrÇs (string vÇge)
	or	al,al			; Nulla ?
igretr:
	ret				; VisszatÇrÇs

bpbolv	db	22			; Hossz
	db	0			; AlegysÇg
	db	2			; BPB c°m kÇrdezÇs k¢dja
	dw	0			; èllapotjelzî sz¢
	db	8 dup(0)		; DOS fenntartott terÅlet
	db	0			; Jelenlegi t°pus
	dw	secpuf,0		; Pointer a pufferre
	dw	0,0			; Pointer a BPB-re

blatad	dw	0,0			; Ez a blokk†tad†s c°me
feldol	dw	0,0			; Ez a feldolgoz†s c°me


helpsz	db	'RAMDRIVE paramÇter m¢dos°t¢ program. ('
	vernum
	db	')',0dh,0ah,0ah
	db	'Haszn†lata: KPRDV @:                                    '
	db	'              vagy',0dh,0ah
	db	'            KPRDV @: <kapcsol¢(k)>                      '
	db	'              vagy',0dh,0ah
	db	'            KPRDV @: hossz <kapcsol¢(k)>                '
	db	'              vagy',0dh,0ah
	db	'            KPRDV @: hossz szektorhossz <kapcsol¢(k)>   '
	db	'              vagy',0dh,0ah
	db	'            KPRDV @: hossz szektorhossz bejegyzÇssz†m'
	db	' <kapcsol¢(k)>',0dh,0ah,0ah
	db	'A @: a m¢dos°tand¢ RAMDRIVE azonos°t¢ja.',0dh,0ah,0ah
	db	'AlapÇrtelmezÇsek:  Hossz:          64 Kbyte. (4...32768)',0dh,0ah
	db	'                   Szektorhossz:  512 byte.  (128...512)',0dh,0ah
	db	'                   BejegyzÇssz†m:  64 darab. (2....1024)',0dh,0ah,0ah
	db	'A kapcsol¢ lehet : /O -> RAMDRIVE megszÅntetÇs.',0dh,0ah
	db	'                   /E -> Extended mem¢ria legyen.',0dh,0ah
	db	'                   /A -> Expanded mem¢ria legyen.',0dh,0ah,0ah
	db	'                   /Q -> Ne °rjon ki Åzenetet.',0dh,0ah,0ah
	db	'Ha csak a @: szerepel, a RAMDRIVE paramÇtereit '
	db	'list†zza ki.',0dh,0ah,'$'

fogdrv	db	'A lemez nem Åres !',0ah,0dh,'$'

ervlem	db	'êrvÇnytelen lemezhivatkoz†s !',0ah,0dh,'$'

hibdev	db	'Hib†s eszkîzkezelÇs, kilÇpek !',0ah,0dh,'$'

nemsaj	db	'Ez nem a saj†t RAMDRIVE kezelîm !',0ah,0dh,'$'

akttil	db	'Nem lehet aktu†lis drive !',0ah,0dh,'$'

xmsdev	db	'Extended Memory Manager (XMS) kezelî.',0dh,0ah,'$'

emsdev	db	'Expanded Memory Manager (EMS) kezelî.',0dh,0ah,'$'

sysdev	db	'System mem¢ria. Ez nem szÅntethetî meg, nem m¢dos°that¢ !',0dh,0ah,'$'

sysnem	db	'System mem¢riakezelît nem lehet m¢dos°tani !',0dh,0ah,'$'

syslet	db	'System mem¢riakezelît nem lehet lÇtrehozni !',0dh,0ah,'$'

vekelt	db	'Nem lehet helyre†ll°tani a 19-es IT. vektort !',0dh,0ah
	db	'A RAMDRIVE kezelî (EMS) most nem m¢dos°that¢.',0dh,0ah,'$'

vekelx	db	'Nem lehet helyre†ll°tani az XMS parancs-l†ncot !',0dh,0ah
	db	'A RAMDRIVE kezelî (XMS) most nem m¢dos°that¢.',0dh,0ah,'$'

maneme	db	0ah,0dh,'A RAMDRIVE jeleneleg nem Åzemel !',0dh,0ah
	db	'Elîzî paramÇterei:',0dh,0ah,'$'

csilla	db	'?:\*.*',0

	endif

	code	ends
	end
