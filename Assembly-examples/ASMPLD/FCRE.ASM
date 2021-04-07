	title	File kre†l†s
;
verzio	equ	 105			; Verzi¢sz†m (1.05)
;
vernum	macro
	defver	%verzio
	endm
;
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
;
code	segment para	public	'code'
;
assume cs:code, ds:code, es:nothing, ss:nothing
;
marhos	equ	65535 - vegpoi + 1
;
	org	100h
start:
	mov	ah,4ah			; M¢dos°t†s kÇrÇs k¢dja
	mov	bx,1000h		; 64K legyen
	int	21h			; Gyere DOS, m¢dos°tsd ha tudod
	mov	dx,offset kevmem	; Hibaszîveg
	jc	kiirba			; Ha nincs elÇg
	mov	sp,offset stpoin	; Ez saj†t terÅletre mutat
	mov	si,81h			; Itt van a parancssor eleje
elejei:
	lodsb				; Karakter betîltÇs
	cmp	al,' '                  ; Sz¢kîzzel van ez elejÇn ?
	jz	elejei			; Igen, elimin†lom
	cmp	al,9			; Tabul†tor van ez elejÇn ?
	jz	elejei			; Igen, elimin†lom
	cmp	al,0dh			; CR itt ?
	jz	vegbaj			; Igen, help lesz
	lea	dx,[si - 1]		; Ez a file-nÇv leje
	mov	ds:[6ch],dx		; Itt lesz a nÇvkezdet
talfiu:
	lodsb				; Karakter betîltÇs
mehet:
	or	al,al			; Nulla ?
	jne	nestri			; Igen, HELP ki°rat†sra
vegbaj:
	mov	dx,offset help		; Ez a HELP c°me
kiirba:
	mov	ah,9			; Stringki°rat†s k¢dja
	jmp	kilsta			; St†tusszal kilÇpÇs
nestri:
	cmp	al,0dh			; CR ?
	je	vegbaj			; Igen, HELP ki°rat†sra
	cmp	al,9			; VÇge a nÇvnek ?
	je	neveta			; Igen, ellenîrzîm
	cmp	al,' '                  ; VÇge a nÇvnek ?
	jne	talfiu			; Nem, kîvetkezî karakter kell
neveta:
	mov	byte ptr [si - 1],0	; A file-nÇv vÇgÇre 0 byte
	call	longco			; BP:CX <- konstans
	jc	conros			; Hib†s valami
	mov	[hosout],cx		; Konstans L rÇsz
	mov	[hosout + 2],bp 	; Konstans H rÇsz
crvane:
	lodsb				; Karakter behozatal
	cmp	al,' '                  ; Szîk¢z kîveti ?
	jz	crvane			; Igen, †tlÇpem
	cmp	al,9			; TAB kîveti ?
	jz	crvane			; Igen, †tlÇpem
	or	al,al			; Ez a befejezî karakter ?
	je	sibefs			; Igen, sikeres a hossz
	cmp	al,0dh			; Ez a befejezî karakter ?
	je	sibefs			; Igen, sikeres a hossz
	cmp	al,'/'                  ; Kapcsol¢ ?
	je	katava			; Igen, van kapcsol¢
conros:
	mov	dx,offset conhib	; Hibaszîveg c°me
kiirbs:
	jmp	short kiirba		; Hibaki°rat†sra
katava:
	lodsb				; Karakter behozatal
	cmp	al,'f'                  ; Kis f ?
	jz	fkatal			; Igen j¢ a kapcsol¢
	cmp	al,'F'                  ; Nagy F ?
	jnz	vegbaj			; Nem, helpet adjunk
fkatal:
	mov	di,offset fillte	; Ide teszem majd le
	lodsb				; Beolvasom a karaktert
	cmp	al,'r'                  ; VÇletlen sz†m ?
	jz	random			; Igen, az lesz
	cmp	al,'R'                  ; VÇletlen sz†m ?
	jnz	prokon			; Nem, pr¢b†ljuk konstansnak
random:
	lodsb				; Beolvasom a hat†rol¢t
	cmp	al,' '                  ; Szîkîz ?
	jz	random			; Igen, †tlÇpem
	cmp	al,9			; TAB ?
	jz	random			; Igen, †tlÇpem
	cmp	al,0dh			; A vÇgjel ?
	jnz	conros			; Rossz a konstans
	mov	[filldb],-1		; Kiteszem a jelet
sibefs:
	jmp	sibefe			; Teljesen kÇsz
prokon:
	mov	bx,4			; A hossza
	cmp	al,'q'                  ; Duplaszavas ?
	jz	tokial			; Igen, byte-os a tîltÇs
	cmp	al,'Q'                  ; Duplaszavas ?
	jz	tokial			; Igen, byte-os a tîltÇs
	mov	bx,2			; A hossza
	cmp	al,'w'                  ; Szavas ?
	jz	tokial			; Igen, byte-os a tîltÇs
	cmp	al,'W'                  ; Szavas ?
	jz	tokial			; Igen, byte-os a tîltÇs
	dec	bx			; BX <- 1
	cmp	al,'b'                  ; Byte-os ?
	jz	tokial			; Igen, byte-os a tîltÇs
	cmp	al,'B'                  ; Byte-os ?
	jz	tokial			; Igen, byte-os a tîltÇs
karkoo:
	dec	si			; VisszalÇpek
tokial:
	lodsb				; Karakter behozatal
	cmp	al,'"'                  ; Karakterkezdet ?
	jz	talkoe			; Igen, ez a kezdet
	cmp	al,''''                 ; Karakterkezdet ?
	jnz	konfel			; Nem, konstanssal pr¢b†lkozom
talkoe:
	mov	ah,al			; M†solat r¢la
	xor	cx,cx			; Kezdî karaktersz†m
tokabe:
	lodsb				; AL <- karakter
	cmp	al,ah			; Karakterkezdet p†rja ?
	jnz	filkam			; Ki lehet tenni
	add	[filldb],cx		; Kiteszem a darabot
	jmp	short kabeol		; Sikeresen befejezte
filkam:
	stosb				; Kiteszem
	inc	cx			; Darabsz†m nîvelÇs
	jmp	short tokabe		; Mehet tov†bb
konfel:
	dec	si			; Vissza a karakterre
	push	di			; Elrontja
	call	longco			; BP:CX <- konstans
	pop	di			; Vissza
	jnc	filkae			; Sikeres volt a beolvas†s
fillro:
	mov	dx,offset filhib	; Hibaszîveg c°me
	jmp	short kiirbs		; Ki°ratom
filkae:
	cmp	bx,4			; Duplaszavas ?
	jz	duptol			; Igen, duplaszavas
	cmp	bx,2			; Szavas ?
	jz	wordto			; Igen, szavas
	or	bp,bp			; H rÇsz nulla ?
	jnz	fillro			; Nem, nem sikeres
	or	ch,ch			; Csak byte mÇretÅ ?
	jnz	fillro			; Nem, nem sikeres
filkao:
	mov	[di],cl 		; Kiteszem
	jmp	short konhov		; Ki lett tÇve
duptol:
	mov	[di],cx 		; L rÇsz
	mov	[di + 2],bp		; H rÇsz
	jmp	short konhov		; Ki lett tÇve
wordto:
	or	bp,bp			; H rÇsz nulla ?
	jnz	fillro			; Nem, nem sikeres
	mov	[di],cx 		; L rÇsz
konhov:
	add	[filldb],bx		; A tîltÇs hossza
	add	di,bx			; Puffereltol†s
kabeol:
	lodsb				; Beolvasom a hat†rol¢t
	cmp	al,' '                  ; Szîkîz ?
	jz	kabeol			; Igen, †tlÇpem
	cmp	al,9			; TAB ?
	jz	kabeol			; Igen, †tlÇpem
	cmp	al,0dh			; A vÇgjel ?
	jz	sibefe			; Igen, kÇsz vagyok, de teljesen
	cmp	al,','                  ; Elv†laszt¢ ?
	jnz	karkoo			; Nem elv†laszt¢
kakave:
	lodsb				; Beolvasom a hat†rol¢t
	cmp	al,' '                  ; Szîkîz ?
	jz	kakave			; Igen, †tlÇpem
	cmp	al,9			; TAB ?
	jz	kakave			; Igen, †tlÇpem
	cmp	al,0dh			; A vÇgjel ?
	jz	fillro			; Igen, ez itt hiba
	jmp	short karkoo		; Mehet az olvas†sra
sibefe:
	mov	dx,ds:[6ch]		; Itt lesz a nÇvkezdet
	dec	byte ptr [status]	; Igy most 2 lesz
	push	dx			; A nÇv c°mÇnek mentÇse
	mov	ax,3d01h		; Nyit†s °r†sra k¢dja
	int	21h			; Gyere DOS, nyisd meg a file-t
	pop	dx			; NÇv visszahozatal
	jnc	opesik			; Ha sikeres a nyit†s
	mov	ah,3ch			; Kre†l†s k¢dja
	xor	cx,cx			; Ez a file attributuma
	int	21h			; Gyere DOS, kre†lj file-t
	jnc	kresik			; SikerÅlt neki
	mov	dx,offset opehib	; Ez a nyit†shiba szîveg c°me
	jmp	kiirbs			; Nem sikeres a kre†l†s
kresik:
	dec	byte ptr [status]	; Igy most 1 lesz
opesik:
	mov	bx,ax			; Ez a file-sz†m
	xor	cx,cx			; Hossz H rÇsz
	mov	dx,cx			; Hossz L rÇsz
	mov	ax,4202h		; Pozicion†l†s a vÇgÇhez k¢dja
	int	21h			; Gyere DOS, vidd a pointert
	mov	[erehos + 2],dx 	; Hossz H rÇsz
	mov	[erehos],ax		; Hossz L rÇsz
	mov	cx,[hosout + 2] 	; Hossz H rÇsz
	mov	dx,[hosout]		; Hossz L rÇsz
	mov	ax,4200h		; Pozicion†l†s k¢dja
	int	21h			; Gyere DOS, vidd a pointert
	mov	ah,40h			; Ir†s k¢dja
	xor	cx,cx			; Az °r†s hossza 0
	int	21h			; Gyere DOS, v†gk ki a hosszat
	xor	dx,dx			; L rÇsz
	mov	cx,dx			; H rÇsz
	mov	ax,4202h		; Pozicion†l†s a vÇgÇhez k¢dja
	int	21h			; Gyere DOS, mutasd a vÇgÇt
	cmp	dx,[hosout + 2] 	; Azonos a kiv†nttal ?
	jne	hoszba			; Nem, hibaki°rat†sra
	cmp	ax,[hosout]		; Azonos a kiv†nttal ?
	je	mehhot			; Igen, sikerÅlt
hoszba:
	mov	dx,offset ninjoh	; Hosszhiba szîveg c°me
	jmp	zafio			; Z†r†sra
mehhot:
	mov	cx,[erehos + 2] 	; Az eredeti hossz H rÇsz
	mov	dx,[erehos]		; Az eredeti hossz L rÇsz
	mov	ax,4200h		; Pozicion†l†s a vÇgÇre
	int	21h			; Gyere DOS, menj a file vÇgÇre
	mov	ax,[erehos]		; Az eredeti hossz L rÇsz
	sub	[hosout],ax		; Levonom az L rÇszt
	mov	ax,[erehos + 2] 	; Az eredeti hossz H rÇsz
	sbb	[hosout + 2],ax 	; Levonom a H rÇszt
	jc	ninmit			; Nincs mit tîlteni
	mov	ax,[hosout]		; L rÇsz
	or	ax,[hosout + 2] 	; H rÇsz, nulla ?
	jz	ninmit			; Ha nem kell tîlteni m†r
	mov	ax,[filldb]		; Ennyit kell tîltenem
	or	ax,ax			; Kell tîltenem egy†ltal†n ?
	jz	ninmit			; Nincs mivel tîlteni
	mov	dx,offset fillte	; A saj†t terÅletem
	cmp	ax,-1			; VÇletlensz†m ?
	jz	cikfet			; Igen, azzal tîltîm fel
	mov	si,dx			; A saj†t terÅletem
	mov	di,dx			; Innen viszi is ki
	add	di,ax			; Ide tegye ki
	mov	cx,marhos		; A tîltÇs hossza
	sub	cx,ax			; Ennyi m†r ki van tîltve
	cld				; Elîrefele
	rep	movsb			; Ciklusban tîltÇs
	jmp	short kitpum		; Mehet kivinni
cikfet:
	call	velkez			; KezdîÇrtÇkek be†ll°t†sa
kitpum:
	mov	cx,marhos		; AlapÇrtelmezÇs
	cmp	word ptr [hosout + 2],0 ; Van bîven ?
	jnz	emarad			; Igen, CX marad
	cmp	[hosout],cx		; Van bîven ?
	jae	emarad			; Igen, CX marad
	mov	cx,[hosout]		; Ennyi lesz
emarad:
	jcxz	mohera			; Nincs mit csin†lni
	sub	[hosout],cx		; Ennyit most kiviszek
	sbb	[hosout + 2],0		; H rÇszre is †tviszem
	mov	ax,[filldb]		; Ennyit kell tîltenem
	inc	ax			; VÇletlensz†m
	jnz	mohera			; Nem, mehet a ki°r†s
	call	velkit			; Kitîltîm
mohera:
	mov	ah,40h			; Az °r†s k¢dja
	int	21h			; Gyere DOS, °rd ki a file-ba
	cmp	ax,cx			; Kivitte ?
	jnz	nemvik			; Nem vitte ki
	mov	ax,[hosout]		; L rÇsz
	or	ax,[hosout + 2] 	; H rÇsz, nulla ?
	jnz	kitpum			; Nem, tîltîm tov†bb
ninmit:
	mov	byte ptr [status],0	; Sikeres volt
	mov	ah,3eh			; Z†r†s k¢dja
kilsta:
	int	21h			; Gyere DOS, z†rd le
	mov	al,[status]		; Ez a kilÇpÇs visszatÇrÇsi k¢dja
	mov	ah,4ch			; KilÇpÇs k¢dja
	int	21h			; Gyere DOS, befejeztem
nemvik:
	mov	dx,offset nensif	; Nem vitte ki c°me
zafio:
	mov	ah,3eh			; Z†r†s k¢dja
	int	21h			; Gyere DOS, z†rd le
	jmp	kiirba			; Hibaki°rat†sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	BP:CX-be konstans beolvas†sa.			;
;	Haszn†lhat¢ formul†k:  123456789  -> 123456789	;
;			       cd5595h	  -> 123456789	;
;			       63252625o  -> 123456789	;
;			       1000b	  ->	     8	;
;			       8k	  ->	  8192	;
;			       8m	  ->   8388608	;
;							;
;	Input:	SI <- stringkezdet			;
;							;
;	Output: BP:CX <- a beolvasott konstans		;
;		SI <- a konstansot kîvetî karakter	;
;		CY <- 1 ha nem j¢ a konstans		;
;		CY <- 0 ha j¢ a konstans		;
;							;
;	Ront:	AX, DX, DI				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
longco:
	mov	ah,0			; AH <- 0
	mov	di,si			; Itt kezdîdik a string
folele:
	lodsb				; Karakter behozatal
	cmp	al,'A'                  ; A betÅk elîtt van ?
	jb	rogsam			; Igen, akkor elemezze
	cmp	al,'Z'                  ; A nagybetÅk rÇsze ?
	jbe	nagybe			; Igen, akkor elemezze
	cmp	al,'a'                  ; A kisbetÅk elîtt van ?
	jb	roscon			; Igen, hib†s a konstans
	cmp	al,'z'                  ; A kisbetÅk ut†n van ?
	jae	roscon			; Igen, hib†s a konstans
	sub	al,'a'-'A'              ; ètalak°tom nagybetÅre
nagybe:
	cmp	al,'B'                  ; Bin†ris, vagy HEX 'B' ?
	jnz	nemabi			; Nem bin†ris
	test	ah,00000111b		; Bin†ris lehet ?
	jnz	folelh			; Nem bin†ris, hexa
	call	hatvan			; Hat†rol¢ ?
	jnz	folelh			; Nem bin†ris, hexa
	mov	cx,2			; Szorz¢
	jmp	short elezar		; ElemzÇs vÇge
roscon:
	stc				; Hibajel
	ret				; Nincs tov†bb
nemabi:
	cmp	al,'F'                  ; A hexadecim†lis tartom†ny ?
	ja	nemhex			; Nem az a tartom†ny
folelh:
	or	ah,00000111b		; Hexadecim†lis
	jmp	short folele		; Folytassa
nemhex:
	cmp	al,'O'                  ; Okt†lis jelzî ?
	jnz	nemokt			; Nem okt†lis jelzî
	test	ah,00000110b		; Volt nem ide val¢ ?
	jnz	roscon			; Hib†s konstans
	mov	cx,8			; Szorz¢
	jmp	short elezar		; ElemzÇs vÇge
nemokt:
	cmp	al,'H'                  ; Hexa jelzî ?
	jnz	nemhej			; Nem hexa jelzî
	mov	cx,16			; Szorz¢
	jmp	short elezar		; ElemzÇs vÇge
nemhej:
	cmp	al,'M'                  ; Mega jelzî ?
	jz	megaje			; Igen, folytattom
	cmp	al,'K'                  ; Kilo jelzî ?
	jnz	roscon			; Nem kilo jelzî
megaje:
	test	ah,00000100b		; Volt nem ide val¢ ?
	jnz	roscon			; Hib†s konstans
	mov	cx,10			; Szorz¢
elezar:
	call	hatvan			; Hat†rol¢ ?
	jz	konjel			; Igen, beolvashatom
roscse:
	jmp	short roscon		; Hib†s konstans
rogsam:
	cmp	al,' '                  ; Hat†rol¢ ?
	jz	konrea			; Igen, elemzem
	cmp	al,9			; Hat†rol¢ ?
	jz	konrea			; Igen, elemzem
	cmp	al,','                  ; Hat†rol¢ ?
	jz	konrea			; Igen, elemzem
	cmp	al,0dh			; Hat†rol¢ ?
	jz	konrea			; Igen, elemzem
	or	al,al			; Hat†rol¢ ?
	jz	konrea			; Igen, elemzem
	cmp	al,'0'                  ; Kisebb mint a '0' karakter ?
	jb	roscon			; Ha kisebb
	cmp	al,'2'                  ; Kisebb mint a '2' karakter ?
	jb	folels			; Igen, lehet bin†ris
	or	ah,00000001b		; Legal†bb okt†lis
	cmp	al,'8'                  ; Kisebb mint a '8' karakter ?
	jb	folels			; Igen, lehet okt†lis
	or	ah,00000011b		; Legal†bb decim†lis
	cmp	al,'9'                  ; Kisebb, vagy a '9' karakter ?
	ja	roscse			; Hib†s a konstans
folels:
	jmp	folele			; Igen, lehet decim†lis
konrea:
	test	ah,00000100b		; Volt hex sz†m ?
	jnz	roscse			; Igen, hib†s
	mov	cx,10			; Decim†lis szorz¢
konjel:
	mov	si,di			; Itt kezdett
	mov	di,cx			; Ez a szorz¢
	xor	cx,cx			; Ez lesz a hossz L byte
	mov	bp,cx			; Ez lesz a hossz H byte
konjeu:
	lodsb				; Ez a konstans eleme
	cmp	al,'0'                  ; Sz†mjegy ?
	jb	konenm			; Kisebb vÇge a keresÇsnek
	cmp	al,'9'                  ; Sz†mjegy ?
	jbe	szamje			; Most sz†mjegy
	cmp	al,'a'                  ; Lehet kisbetÅ ?
	jb	nemkis			; Nem kisbetÅ
	sub	al,'a'-'A'              ; ètalak°tom nagybetÅre
nemkis:
	cmp	al,'M'                  ; Ez az 'M' ?
	jz	komega			; Igen, konstans vÇge
	cmp	al,'K'                  ; Ez a 'K' ?
	jz	kokilo			; Igen, konstans vÇge
	cmp	al,'H'                  ; Ez a 'H' ?
	jz	konend			; Igen, konstans vÇge
	cmp	al,'O'                  ; Ez az 'O' ?
	jz	konend			; Igen, konstans vÇge
	cmp	al,'B'                  ; Ez a 'B' ?
	jnz	nemabj			; Nem a bin†ris jelzî
	cmp	di,2			; A vÇgÇt jelzi ?
	jz	konend			; Igen, konstans vÇge
nemabj:
	cmp	al,'F'                  ; Nagyobb ?
	ja	konenm			; Igen, vÇge a konstansnak
	sub	al,7			; Konstansos°tom
szamje:
	and	ax,1111b		; Csak az als¢ bitek kellenek
	push	ax			; Elmentem
	mov	ax,bp			; AX <- H rÇsz
	mul	di			; A konstanssal szorzom
	or	dx,dx			; T£lcsordult ?
	jnz	roscse			; Igen, rossz a konstans
	mov	bp,ax			; Vissza a szorzat
	mov	ax,cx			; AX <- L rÇsz
	mul	di			; A konstanssal szorzom
	mov	cx,ax			; A szorzat L rÇsze vissza
	add	bp,dx			; A H rÇsz†tvitele
	jc	roscss			; T£lcsordult
	pop	ax			; Vissza
	add	cx,ax			; L rÇsz
	adc	bp,0			; H rÇsz
	jnc	konjeu			; Olvassa tov†bb
roscss:
	jmp	roscon			; T£lcsordult
komega:
	mov	di,1024 		; Ez az 1K ÇrtÇke
	mov	ax,bp			; AX <- H rÇsz
	mul	di			; A konstanssal szorzom
	or	dx,dx			; T£lcsordult ?
	jnz	roscss			; Igen, rossz a konstans
	mov	bp,ax			; Vissza a szorzat
	mov	ax,cx			; AX <- L rÇsz
	mul	di			; A konstanssal szorzom
	mov	cx,ax			; A szorzat L rÇsze vissza
	add	bp,dx			; A H rÇsz†tvitele
	jc	roscss			; T£lcsordult
kokilo:
	mov	di,1024 		; Ez az 1K ÇrtÇke
	mov	ax,bp			; AX <- H rÇsz
	mul	di			; A konstanssal szorzom
	or	dx,dx			; T£lcsordult ?
	jnz	roscss			; Igen, rossz a konstans
	mov	bp,ax			; Vissza a szorzat
	mov	ax,cx			; AX <- L rÇsz
	mul	di			; A konstanssal szorzom
	mov	cx,ax			; A szorzat L rÇsze vissza
	add	bp,dx			; A H rÇsz†tvitele
	jc	roscss			; T£lcsordult
	inc	si			; Hogy a DEC hat†stalan legyen
konenm:
	dec	si			; Idegen karakter volt
konend:
	clc				; SikerÅlt
	ret				; Megvan a konstans
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Hat†rol¢ vizsg†lat.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hatvan:
	push	si			; Nem romolhat el
	lodsb				; Beolvasom
	cmp	al,'/'                  ; Kapcsol¢ jel ?
	jz	eleveg			; Igen, keresek tov†bb
	cmp	al,','                  ; Vesszî ?
	jz	eleveg			; Igen, keresek tov†bb
	cmp	al,' '                  ; Sz¢kîz ?
	jz	eleveg			; Igen, keresek tov†bb
	cmp	al,9			; Tabul†tor ?
	jz	eleveg			; Igen, keresek tov†bb
	cmp	al,0dh			; Csak ennyi ?
	jz	eleveg			; Igen, itt a vÇge
	or	al,al			; Null byte ?
eleveg:
	pop	si			; Vissza ami romlott
	ret				; Megvan a konstans
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	VÇletlen byte-kitÇteli ciklus.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
velkit:
	push	cx			; Elrontom a sz†ml†l¢t
	mov	di,dx			; M†solat a c°mrîl
	push	dx			; A c°m is elromlik
	mov	ax,[elovet]		; Az elîzî vÇletlen ÇrtÇke
veleci:
	mul	[atarol]		; Megszorzom az A ÇrtÇkÇvel
	add	ax,[btarol]		; Eltolom B-vel
	adc	dx,0			; Eltolom B-vel
	rcr	dx,1			; Felezem a H rÇszt
	rcr	ax,1			; Felezem az L rÇszt
	stosb				; VÇletlen ÇrtÇk kitÇtel
	loop	veleci			; Kitîltîm a puffert
	mov	[elovet],ax		; Kiteszem a folytat†shoz
	pop	dx			; Vissza
	pop	cx			; Vissza a sz†ml†l¢
	ret				; KÇsz
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A vÇletlensz†m kezdî ÇrtÇkei.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
velkez:
	push	dx			; Ez most elromlana
	push	cx			; Ez most elromlana
	xor	ax,ax			; Ez lesz a szegmens ÇrtÇke
	mov	ds,ax			; DS <- 0
	cwd				; DX <- 0
csinat:
	mov	cx,4000h		; Ennyi duplasz¢ sz¢ 64K
	xor	si,si			; SI <- 0
cikelo:
	add	ax,[si] 		; VÇletlensz†m kialak°t†s
	add	dx,[si + 2]		; VÇletlensz†m kialak°t†s
	add	si,4			; Eltolom
	loop	cikelo			; Ciklusban
	mov	cx,ds			; DS m†solat
	add	cx,1000h		; Eltolom
	mov	ds,cx			; Vissza
	cmp	cx,3000h		; ElÇrte ?
	jnz	csinat			; Nem, tov†bb
	mov	cx,cs			; Ezt kell
	mov	ds,cx			; DS <- CS
	add	[elovet],ax		; Eltolom 1.
	add	[elovet],dx		; Eltolom 2.
	add	ax,cx			; MÇg CS is seg°t
ismlep:
	shl	dx,1			; * 2
	shl	dx,1			; * 4
	jnz	simato			; Ha nem nulla
nutain:
	mov	dx,0100101010000000b	; Nulla esetÇn
simato:
	test	dx,1110000000000000b	; ElÇg nagy ?
	jz	ismlep			; Nem elÇg nagy
	inc	dx			; Van ÇrtÇk
	jz	nutain			; Nulla lett volna
	mov	[atarol],dx		; A szorz¢ kÇsz
megyor:
	or	ax,1			; Legyen p†ratlan
megyko:
	cmp	ax,2048 		; Nagyobb ?
	ja	mehrat			; Nem nagyobb
	shl	ax,1			; * 2
	jmp	short megyor		; Megy az OR £jra
mehrat:
	mov	[btarol],ax		; Ez lesz az eltol¢
	mov	cx,3			; Kezdî oszt¢
primci:
	mov	ax,[btarol]		; Ezt vizsg†lom
	xor	dx,dx			; DX <- 0
	div	cx			; Elosztom
	or	dx,dx			; MaradÇk van ?
	jnz	eznemo			; Igen, ez nem az oszt¢ja
	mov	ax,[btarol]		; Ez ami nem pr°m sz†m
	inc	ax			; Eltolom
	inc	ax			; Eltolom
	jmp	short megyko		; Mehet vissza
eznemo:
	inc	cx			; LÇpek
	inc	cx			; LÇpek
	cmp	cx,[btarol]		; ElÇrte ?
	jb	primci			; Nem, megy tov†bb
	pop	cx			; Sz†ml†l¢ vissza
	pop	dx			; C°m vissza
	ret				; KÇsz, [btarol] <- primsz†m
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A szîvegeket, byte-os v†ltoz¢kat ide teszem.	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
status	db	3			; St†tusz helye
;
help	db	0ah, 0dh
	db	'öres file-t kre†l¢ program. ('
	vernum
	db	')', 0ah, 0ah, 0dh
	db	'Haszn†lata: FCRE file-specifik†ci¢ hossz[ /f???]',0dh,0ah,0ah
	db	'A hossz alapÇrtelmezÇsben decim†lis.',0ah,0dh
	db	'M†s sz†mrendszerhez a konstans vÇgÇre kell tenni a jelîlÇst.',0ah,0dh
	db	'H -> hexadecim†lis, O -> okt†lis, B -> bin†ris. Decim†lis rendszerben a hossz',0ah,0dh
	db	'vÇgÇre tett K kilo, az M megabyte-os foglal†st jelent.', 0ah, 0dh
	db	'Pl.: 1000b, 377o, 1bh, 22k, 5m.', 0ah, 0dh
	db	'Az "F" kapcsol¢val tîltî stringet adhatunk meg. Pl.: /f''Z'' vagy /f90 vagy', 0ah, 0dh
	db	'/f5ah Z betÅvel tîlti fel, a /f''Zoli'' ZoliZoliZoli... stringgel tîlti fel.', 0ah, 0dh
	db	'A tîltî karaktereket sz¢kîzzel, tabul†torral vagy vesszîvel v†laszthatjuk el.', 0ah, 0dh
	db	'Pl.: Kicsi + CR + LF legyen a tîltÇs: /f''Kicsi'' 13, 10', 0ah, 0dh
	db	'Ha a konstansokat t°pussal kiv†njuk ell†tni, az F ut†n haszn†ljunk t°pusjelzît.', 0ah, 0dh
	db	'A t°pusjelzî B, W vagy Q lehet. A B byte-os a W szavas, a Q duplaszavas', 0ah, 0dh
	db	'ÇrtÇkeket jelent. Pl. /fw456dh', 0ah, 0dh
	db	'A /fr kapcsol¢val †lvÇletlensz†mmal fogja a karaktereket helyettes°teni.', 0ah, 0dh
	db	'Ha nincs tîltîkarakter megadva, csak hosszbe†ll°t†st vÇgez.', 0ah, 0dh
	db	'LÇtezî file-t csak a kiegÇsz°tî rÇszen tîlti fel.', 0ah, 0dh
	db	'$'
;
kevmem	db	'Nincs elÇg mem¢ri†m.$'
;
ninjoh	db	'Nem sikerÅlt a hossz v†ltoztat†sa.$'
;
opehib	db	'Sikertelen file-kre†l†s.$'
;
conhib	db	'Hib†s hosszmegad†s.$'
;
filhib	db	'Hib†s a tîltîkarakter(ek) megad†sa.$'
;
nensif	db	'Nem sikerÅlt a file-t feltîlteni.$'
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ha nem p†ros c°men kezdîdnek, eltolom.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	if	($ - start) and 1
;
	db	1 dup(?)		; Ha nem p†ros c°men van
;
	endif
;
filldb	dw	0			; A tîltÇs darabsz†ma
;
elovet	dw	1 dup(?)		; A vÇletlen elîzî ÇrtÇke
atarol	dw	1 dup(?)		; A vÇletlen szorz¢ja
btarol	dw	1 dup(?)		; A vÇletlen eltol¢ja
erehos	dw	2 dup(?)		; Az eredeti hossz
hosout	dw	2 dup(?)		; A lÇtrehozand¢ hossz
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ugy foglalok a STACK sz†m†ra, hogy		;
;	kiegÇsz°tem paragrafusra.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	dw	512 dup(?)		; Minimum ennyi a STACK
;
fogkel	equ	($ - start) and 15	; Ennyi van t£l a paragrafuson
;
	if	fogkel NE 0
;
	db	16 - fogkel  dup(?)	; KiegÇsz°tem
;
	endif
;
stpoin	label	word			; Ez lesz a STACKPOINTER
;
vegpoi	equ	(($ - start) + 100h) ; Ennyi maradt a 64K-b¢l
;
fillte	label	byte		       ; Itt lesz feltîltve
;
code	ends
	end	start
