title	Parancssor Çrtelmezî-kezelî

	page	65,128


versio	equ	 702			; Verzi¢sz†m (7.02)

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

defang	macro

memme1	db	'Reserved memory size $'
memme2	db	' byte.',0ah,0dh,'Free memory size $'
memme3	db	' byte $'
memme4	db	' block(s).$'
memme5	db	8,'.$'
memhib	db	'Incorrect resident part while packing !',0dh,0ah
	db	'Corrected !',0dh,0ah,'$'
helyhi	db	'No enough place for the file !',0dh,0ah,'$'
leteh1	db	0dh,0ah,'Overwrite the $'
leteh2	db	' file ? (Yes/No) [a]',8,8,' ',8,'$'
openh1	db	'Open error on $'
openh2	db	' file.',0dh,0ah,'$'
membaj	db	'No enough memory. Exiting !$'
hibszo	db	'Incorrect starting. Exiting !$'
helpsz	db	'COMmand line EDitor ('
	vernum
	db	')'
	db	0dh,0ah
	db	'Starting: COMED [switch(es)]'
	db	0dh,0ah,0ah
	db	'Switches: (both ''/'' or ''-'' are used)'
	db	0dh,0ah
	db	'/H ....................... use high memory'
	db	0dh,0ah
	db	'/E ....................... use EMS'
	db	0dh,0ah
	db	'/Mxxxxx .................. memory size'
	db	0dh,0ah
	db	'/Sfile ................... output file'
	db	0dh,0ah
	db	'/Wfile ................... output file'
	db	0dh,0ah
	db	'/Ffile ................... configuration file'
	db	0dh,0ah
	db	'/Lxx ..................... stack-elements'
	db	0dh,0ah
	db	'/U ....................... program remove'
	db	0dh,0ah
	db	'/I ....................... inicialization'
	db	0dh,0ah
	db	'/Nxx ..................... the longer will be stored'
	db	0dh,0ah
	db	'/? ....................... help'
	db	0dh,0ah
	db	'The default file for configuration is the COMED.CFG'
	db	0dh,0ah
	db	'located in the running program''s directory.'
	db	0dh,0ah
	db	'The filename does not contain the ''-'' character !'
	db	0dh,0ah
	db	'Using the W and F switches simultaneously, only'
	db	0dh,0ah
	db	'the W switch will be interpreted, the F is omitted.'
	db	0dh,0ah
	db	'The stack elements are in 1-99, default is 24.'
	db	0dh,0ah
	db	'The stored length is in 0-255, default is 2,'
	db	0dh,0ah
	db	'The M switch is maximum 61280 bytes, default is 1024.'
	db	0dh,0ah,'$'

emsnin	db	'No EMS or incorrect EMS version ! Exiting.$'
emshnd	db	'Unsuccessful EMS call. Error code: $'
kilkel	db	'h. Exiting.$'
megres	db	'Unsuccesful removing ! May be later if it is possible.$'
versba	db	'Required at least DOS 3.00 !$'
lerror	db	'Loading error.',0dh,0ah,'$'
merror	db	'Memory segmentation error !',0dh,0ah,'$'

	endm

defnem	macro

memme1	db	'Die Grî·e der besetzten Memorie ist $'
memme2	db	' byte.',0ah,0dh,'Die Grî·e der freien Memorie ist $'
memme3	db	' byte in $'
memme4	db	' StÅck.$'
memme5	db	8,'.$'
memhib	db	'WÑhrend der Zusammenfassung inkorrekt residenten '
	db	'Teils !',0dh,0ah
	db	'Berichtigt !',0dh,0ah,'$'
helyhi	db	'Der File hat keinen genÅgenden Platz !',0dh,0ah,'$'
leteh1	db	0dh,0ah,'Soll ich den File $'
leteh2	db	' wiederschrieben ? (Ja/Nein) [a]',8,8,' ',8,'$'
openh1	db	'Die ôffnung von File $'
openh2	db	' ist nicht gelungen.',0dh,0ah,'$'
membaj	db	'Ich habe keine genÅgende Memorie. Ich hîre damit auf !$'
hibszo	db	'Fehlerhafte Startprobe. Ich hîre damit auf !$'


helpsz	db	'Befehlreihe Konstukteur-Ausgestalter ('
	vernum
	db	')'
	db	0dh,0ah
	db	'Start: COMED [Taste(n)]'
	db	0dh,0ah,0ah
	db	'Tasten: (statt dem Zeichen ''/'' ist auch das Zeichen'
	db	' ''-'' zu benutzen)'
	db	0dh,0ah
	db	'/H ....................... man mu· fÅr hîhere '
	db	'Memorieaddressen fÅllen',0dh,0ah
	db	'/E ....................... man mu· in EMS legen'
	db	0dh,0ah
	db	'/Mxxxxx .................. Speichergrî·e'
	db	0dh,0ah
	db	'/Sfile-specifikation ..... Zweck von Ausschreibung'
	db	0dh,0ah
	db	'/Wfile-specifikation ..... Zweck von Ausschreibung'
	db	0dh,0ah
	db	'/Ffile-specifikation ..... Start-file'
	db	0dh,0ah
	db	'/Lxx ..................... stack-Bauteil-zahl'
	db	0dh,0ah
	db	'/U ....................... Programm remove'
	db	0dh,0ah
	db	'/I ....................... Initialisierung'
	db	0dh,0ah
	db	'/Nxx ..................... der von diesem grî·ere '
	db	'Befehl wird gespeichert',0dh,0ah
	db	'/? ....................... help Ausschreibung'
	db	0dh,0ah
	db	'Wenn es keine File-Specifikation gibt, wird der File '
	db	'COMED.CFG',0dh,0ah
	db	'von das Programm enthaltenden Subdirectory der '
	db	'Grunddeutung sein.',0dh,0ah
	db	'Die File-Specifikation darf keine Charakter ''-'' '
	db	'enthalten!',0dh,0ah
	db	'Bei der Benutzung von der beiden Tasten W und F '
	db	'wird nur die Taste W wirken.',0dh,0ah
	db	'Die Stach-Bauteilzahl kann 1-99 sein, die Grunddeutung '
	db	'ist 24.',0dh,0ah
	db	'Die LÑnge kann 0-255 sein, die Grunddeutung ist 2.'
	db	0dh,0ah
	db	'Die Grunddeutung der Taste M ist 1024, max. 61280 byte.'
	db	0dh,0ah,'$'

emsnin	db	'Ich finde keine EMS, oder die Version ist nicht '
	db	'entsprechend ! Ich hîre damit auf !$'
emshnd	db	'Erfolgloser EMS-Ruf. Fehlerkode: $'
kilkel	db	'h. Ich hîre damit auf !$'
megres	db	'Die Wegbrennung ist nicht gelungen ! Wenn es mîglich'
	db	'sein wird, tue ich es.$'
versba	db	'Mindestens wird DOS mit Versionnr. 3.00 benîtigt !$'
lerror	db	'EinfÅllungsfehler!',0dh,0ah,'$'
merror	db	'Fehler in der Segmentkette der Memorie !',0dh,0ah,'$'

	endm

defmag	macro

memme1	db	'A lefoglalt mem¢ria mÇrete $'
memme2	db	' byte.',0ah,0dh,'A szabad mem¢ria mÇrete $'
memme3	db	' byte $'
memme4	db	' darabban.$'
memme5	db	8,'.$'
memhib	db	'A tîmîritÇs sor†n inkorrekt rezidens rÇsz !',0dh,0ah
	db	'Kijav°tva !',0dh,0ah,'$'
helyhi	db	'Nincs a file-nak elÇg hely !',0dh,0ah,'$'
leteh1	db	0dh,0ah,'FelÅl°rjam a $'
leteh2	db	' file-t ? (Igen/Nem) [a]',8,8,' ',8,'$'
openh1	db	'Nem sikerÅlt megnyitni a $'
openh2	db	' file-t.',0dh,0ah,'$'
membaj	db	'Nincs elÇg mem¢ri†m. KilÇpek !$'
hibszo	db	'Hib†s ind°t†si k°sÇrlet. KilÇpek !$'
helpsz	db	'Parancssor szerkesztî-kialak°t¢ ('
	vernum
	db	')'
	db	0dh,0ah
	db	'Ind°t†sa: COMED [kapcsol¢(k)]'
	db	0dh,0ah,0ah
	db	'Kapcsol¢i: (a ''/'' helyett ''-'' is alkalmazhat¢)'
	db	0dh,0ah
	db	'/H ................................. '
	db	'magasabb mem¢riac°mekre tîltsîn',0dh,0ah
	db	'/E ................................. '
	db	'EMS-be kell tenni',0dh,0ah
	db	'/Mxxxxx ............................ '
	db	'mem¢riamÇret',0dh,0ah
	db	'/SR vagy /SWfile-specifik†ci¢ ...... '
	db	'stack-olvas†s vagy stack-mentÇs cÇlja',0dh,0ah
	db	'/Wfile-specifik†ci¢ ................ '
	db	'a konfigur†ci¢ mentÇs cÇlja',0dh,0ah
	db	'/Ffile-specifik†ci¢ ................ '
	db	'konfigur†l¢ file',0dh,0ah
	db	'/Lxx ............................... '
	db	'stack-elemsz†m',0dh,0ah
	db	'/U ................................. '
	db	'program remove',0dh,0ah
	db	'/I ................................. '
	db	'inicializ†l†s',0dh,0ah
	db	'/Nxx ............................... '
	db	'az ennÇl hosszabb t†rol¢dik',0dh,0ah
	db	'/? ................................. '
	db	'help ki°rat†s',0dh,0ah
	db	'Ha nincs file-specifik†ci¢ a W vagy az F kapcsol¢ '
	db	'ut†n a COMED.COM-ot ',0dh,0ah
	db	'tartalmaz¢ tartalomjegyzÇk COMED.CFG nevÅ file-ja, az '
	db	'SW Çs az SR kapcsol¢ ut†n',0dh,0ah
	db	'az aktu†lis hely COMED.STK nevÅ file-ja az '
	db	'az alapÇrtelmezÇs. A specifik†ci¢',0dh,0ah
	db	'nem tartalmazhat ''-'' karaktert ! A W vagy az SW '
	db	'kapcsl¢ haszn†lata esetÇn az F',0dh,0ah
	db	'Çs az SR figyelmen k°vÅl marad. A W kiz†rja SW, az F '
	db	'pedig az SR haszn†lat†t. ',0dh,0ah
	db	'A stack-elemsz†m 1-99 lehet, alapÇrtelmezÇs 24. '
	db	'A hossz 0-255 lehet, ',0dh,0ah
	db	'alapÇrtelmezÇs 2. Az M kapcsol¢ alapÇrtelmezÇse 1024, '
	db	'max. 61312 byte.',0dh,0ah,'$'

emsnin	db	'Nem tal†lok EMS-t, vagy nem megfelelî verzi¢ ! KilÇpek.$'
emshnd	db	'Sikertelen EMS h°v†s. Hibak¢d: $'
kilkel	db	'h. KilÇpek.$'
megres	db	'Nem sikerÅlt elt†vol°tani ! Ha majd lehet, elt†vol°tom.$'
versba	db	'Legal†bb 3.00 verzi¢sz†m£ DOS szÅksÇges !$'
lerror	db	'BetîltÇsi hiba!',0dh,0ah,'$'
merror	db	'Mem¢ria szegment†l†si hiba !',0dh,0ah,'$'

	endm

code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	ifdef	nyelv

		ifidn	nyelv,<english>
			yesjai	equ	'y'
		else
			ifidn	nyelv,<deutsch>
				yesjai	equ	'j'
			else
				yesjai	equ	'i'
			endif
		endif

	else
		yesjai	equ	'i'
	endif


	org	100h
start:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	St†tusz bitdefinici¢k.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
insjel	equ	0000000000000001b	; Besz£r†s Åzem jelzÇs
symoff	equ	0000000000000010b	; SYM - FIX †talak°t†s bit
stdjel	equ	0000000000000100b	; Nem kÇpernyî az output bit
cscomj	equ	0000000000001000b	; Nem kell elt†rolni jelzÇs
folmoz	equ	0000000000010000b	; Elîzî fîl jelzÇse
elomoz	equ	0000000000100000b	; Elîzî le jelzÇse
staelk	equ	0000000001000000b	; Stack tîltÇs jelzÇs
linjeb	equ	0000000010000000b	; Sor tîltÇs jelzÇs

deljel	equ	0000000100000000b	; VisszalÇpÇsnÇl tîrlÇs tilt†s
colibe	equ	0000001000000000b	; A parancssor is csak list†z¢dik
ressto	equ	0000010000000000b	; Le†ll°t†s bitje
nilira	equ	0000100000000000b	; LE ir†ny jelzÇse
hajelb	equ	0001000000000000b	; HangjelzÇs legyen bitje


spejel	equ	1000000000000000b	; Specifik†ci¢ bitje
filjel	equ	0100000000000000b	; 'F' kapcsol¢ bitje
wrijel	equ	0010000000000000b	; 'W' kapcsol¢ bitje
atjelz	equ	0001000000000000b	; AT jelzî bit
comext	equ	0000100000000000b	; Rezidens a COMED bitje
synini	equ	0000001000000000b	; Szinonima inicializ†l†s bitje
unijel	equ	0000000100000000b	; Uninstal†l†s bitje
helpje	equ	0000000010000000b	; Ha help lett ki°rva
emsmje	equ	0000000001000000b	; EMS-be tÇteli k°sÇrlet
hiloje	equ	0000000000100000b	; Magas c°mekre kell tîlteni
srijel	equ	0000000000010000b	; 'SW' kapcsol¢ bitje
ltojel	equ	0000000000001000b	; 'SR' kapcsol¢ bitje

stpoin	equ	bp - 2			; Itt van a stackt†bl†zat c°me
nyulci	equ	bp - 2			; Lehet azonos a stackc°mmel
parsok	equ	bp - 4			; Itt van a kezdîc°m
folcim	equ	bp - 6			; Itt van a folytat¢c°m

emsdar = ((paredc - emssta) - 1) / 2	; Ennyi sz¢ ellenîrizendî

ohdara = ((offset ohvege - offset int21r) - 1) / 2 ; Ennyi sz¢

emmseg = ((emsend - emsfej) + 15) / 16	; Paragrafussz†m

eddres = ((emsfej - start) + 100h) / 16 ; Paragrafussz†m



status	label	word			; Ez a rezidens rÇsz st†tusza
statul	label	byte			; A st†tusz L rÇszÇnek c°me
statuh	equ	statul + 1		; A st†tusz H rÇszÇnek c°me

sabpoi	equ	status + 2		; Hibak¢d t†rol¢

	jmp	masfel			; Itt kezdîdik a m†sol†s
	db	0			; HelykitîltÇs

moleal:
	push	ds			; Ez az eredeti paragrafus
	push	ax			; Ez az eredeti AX
	xor	ax,ax			; Null†z†s
	mov	ds,ax			; Ez az IT. t†bla
	cmp	ds:[21h * 4],offset int21r; Ide mutat mÇg ?
	jne	nemidm			; Nem, ez m†s
	mov	ax,cs			; Ez a paragrafus aktu†lis
	xor	ax,ds:[(21h * 4) + 2]	; Ide mutat mÇg ?
	jne	nemidm			; Nem, ez m†s
resdar	label	word
	mov	cs:[0f1h],ax		; Tulajdonos tîrlÇs (AX = 0)
	mov	ax,cs:[int21c]		; Ez az eredeti offszet
	mov	ds:[21h * 4],ax 	; Ide mutasson vissza
	mov	ax,cs:[int21c + 2]	; Ez az eredeti paragrafusc°m
	mov	ds:[(21h * 4) + 2],ax	; Ide mutasson vissza
nemidm:
	pop	ax			; Ez az eredeti AX
	pop	ds			; Ez az eredeti paragrafus
talazk:
	db	0eah			; DOS visszah°v†shoz JMP SEG:OFF
int21c	dw	?,?			; A DOS eredeti c°me

hibkok:
	pushf				; Flag mentÇs (IT. szimul†l†s)
	call	dword ptr cs:[int21c]	; Ez az eredeti vektor
	mov	cs:[parpoi + 4],ax	; Ez volt a hibak¢d
	iret				; Vissza a h°v¢hoz

int21r:
	test	byte ptr cs:[status + 1],ressto shr 8; Le†ll°tsuk ?
	jne	moleal			; Igen, le lehet †ll°tani
	cmp	ah,4dh			; Hibak¢d kÇrÇs ?
	je	hibkok			; Igen, mehetÅnk kÇrni
	cmp	ah,0ah			; String kÇrÇs ?
	jne	talazk			; Nem, eredeti h°v†s
	push	ax			; Ez h°v¢ AX
	push	bx			; Ez h°v¢ BX
	push	cx			; Ez h°v¢ CX
	push	dx			; Ez h°v¢ DX
	push	si			; Ez h°v¢ SI
	push	di			; Ez h°v¢ DI
	push	bp			; Ez h°v¢ BP
	push	ds			; H°v¢ szegmensregiszter
	push	es			; H°v¢ szegmensregiszter
	push	ds			; Ide kell majd tenni a stringet
	pop	es			; ES <- DS
	mov	si,dx			; Ez a c°m a cÇl c°me
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancssor szerkesztÇs. 			;
;							;
;	Input:	DS:DI -> Az aktu†lis stackle°r¢ 	;
;		ES:SI -> DOS stringpuffer c°me		;
;		[ES:SI + 0] -> a maxim†lis hossz	;
;							;
;	Output: [ES:SI + 1] -> a tÇnyleges hossz	;
;		[ES:SI + 2] -> a string 1. karaktere	;
;		[ES:SI + 3] -> a string 2. karaktere	;
;		       .	.	.		;
;		       .	.	.		;
;		[ES:SI + [ES:SI + 1] + 2] -> 0dh	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	cld				; A stringmÅveletek ir†nya
	and	[status],(ressto or atjelz or symoff or hajelb); TîrlÇsek
	mov	bp,sp			; SP m†solat
	sub	sp,6			; ParamÇterhely kÇszitÇs (3 db)
	mov	ax,ss			; Ez a pointer az
	xor	cx,cx			; CX <- 0
	mov	bx,offset comstp	; Itt van a stackszegmens
	cmp	[bx],cx 		; Nulla ?
	jne	nemust			; Nem, nem Åres a stack
	mov	[bx],ax 		; Ez az £j stackszegmens
nemust:
	mov	di,offset stackc	; Ez a command stack c°me
	cmp	[bx],ax 		; Ez az £j szegmens ?
	je	ecomst			; Igen, ez a c°m marad
	scasw				; DI <- DI + 2
	scasw				; DI <- DI + 2 (stackc + 4)
ecomst:
	mov	[parsok],si		; Itt kezdîdik a paramÇtersor
	mov	[stpoin],di		; Itt a stack pointere
	mov	bx,[parpoi + 2] 	; Id†ig ÇrtelmeztÅk
	mov	[folcim],bx		; Innen folytassa az elemzÇst
	or	bx,bx			; Van folytat†s ?
	je	nintsp			; Nincs, parancs eleje
	cmp	byte ptr [bx - 1],'^'   ; FeltÇtel nÇlkÅl ?
	je	kiiram			; Igen, mindenkÇpp
	cmp	cx,[parpoi + 4] 	; Nulla ? (Hib†tlan volt ?)
	jne	nintsp			; Nem, nem folytatjuk
kiiram:
	jmp	nintok			; Itt folytassuk
nintsp:
	mov	si,offset parpoi	; Itt a c°m
	mov	di,[si] 		; Az az eltÅntetendî
	call	lancik			; EltÅntetjÅk ezt a l†ncot
	mov	[si],di 		; A paramÇterek c°me 0
	mov	[si + 2],di		; Nincs elîzî c°m (folyat†s)
	mov	[si + 4],di		; Nincs hibak¢d
	mov	bx,di			; Standard input file-handle (0)
	mov	ax,4400h		; IOCTL k¢dja (AL = 0)
	int	21h			; DOS h°v†s
	rcl	dl,1			; Klaviat£ra ? (Carry !)
	jc	klavst			; Igen, mehet a 16-os IT.
	push	ds			; DS romlik
	push	es			; Ebbîl less DS
	pop	ds			; DS <- ES
	mov	dx,[parsok]		; Ide pakoljuk majd le
	mov	ah,0ah			; KÇrÇs m†solat
	pushf				; Flag mentÇs (IT. szimul†l†s)
	cli				; IT. tilt†s (IT. szimul†l†s)
	call	dword ptr cs:[int21c]	; Ez az eredeti vektor
	pop	ds			; Ez az eredeti szegmens
	jmp	talbef			; Beolvasott sor van
klavst:
	inc	bx			; Standard output file-handle (1)
	mov	ax,4400h		; IOCTL k¢dja
	int	21h			; DOS h°v†s
	rcl	dl,1			; KÇpernyî ? (Carry !)
	jc	klavta			; Igen, mehet a vide¢ IT.
	or	[statul],stdjel 	; Nem a kÇpernyî jelzÇse
	jmp	short escujk		; ètlÇpjÅk a lekÇrdezÇst
klavta:
	test	[statuh],hajelb SHR 8	; Kell hangjelzÇs ?
	jne	nekefu			; Nem kell a fÅtty
	mov	dl,'G' - '@'            ; FÅtty k¢dja
	call	kidosc			; FîttyentÅnk
nekefu:
	mov	ah,15			; LekÇrdezÇs
	int	10h			; Ez a vide¢ IT.
	mov	[oszsza],ah		; Ennyi oszlopos
	mov	[pagesz],bh		; Ez a lapsz†m
escujk:
	xor	ax,ax			; Darabsz†m null†z†s
	mov	[elemci],ax		; Az aktu†lis elemc°m tîrlÇs
	and	[status],ressto or atjelz or insjel or symoff or hajelb or stdjel; Bit tîrlÇs
kialav:
	call	inselt			; Besz£r†si m¢d tîrlÇs
	call	szuelt			; SzÅk°tÇs kikapcsol†s
	mov	si,[parsok]		; Ide pakoljuk majd le
	xor	ax,ax			; Karakter Çs a hossz lesz ilyen
	mov	di,si			; M†solat a cÇl c°mÇrîl
	inc	di			; Ez a hossz helye
	stosw				; Hossz Çs karakter null†z†s
	dec	di			; Ez az aktu†lis poz°ci¢
cikker:
	call	vegeta			; A vÇgÇn †ll ?
	jne	leurut			; Nem, nincs ki°rat†s elîre
	push	si			; Romolhat
	push	di			; Romolhat
	mov	ah,8			; Karakter lekÇrdezÇs
	mov	bh,[pagesz]		; Ez az oldal
	int	10h			; Ez a vide¢ IT.
	pop	di			; Regiszter vissza
	pop	si			; Regiszter vissza
	mov	dl,al			; Ezt ki kell °rni
	call	kidosc			; Ki°rat†s
	call	bcksp1			; Kurzor vissza rutin
leurut:
	xor	cx,cx			; CX <- 0
	call	kerleu			; LeÅtÇst v†runk
	jne	scanen			; Nem stack elemet kÇrÅnk
	cmp	es:[si + 1],ah		; Nulla a sor ?
	jne	scanen			; Nem, nem stack elemet kÇrÅnk
	cmp	[stelsz],al		; Nagyobb ennÇl ?
	jb	scanen			; Igen, nem stack elemet kÇrÅnk
	mov	cx,ax			; Ez a ciklussz†ml†l¢
	mov	si,[stpoin]		; Itt a stack pointere
bealtt:
	mov	[stujci],si		; Ez a mutat¢ r†m
	mov	si,[si] 		; Ez a kîvetkezî elem
	mov	[elemci],si		; Ez az elem van Çppen
	or	si,si			; Ez a vÇge ?
	je	escujk			; Igen, nincs annyi elem
	loop	bealtt			; Ha kell a kîvetkezî elem
	call	cimaru			; Ki°rjuk az elemet
	jmp	short vimcim		; Ide mehet
scanen:
	or	al,al			; ALT volt ?
	je	karbeo			; Igen, ALT-volt
	mov	ah,0			; SCAN k¢d tîrlÇs
karbeo:
	cmp	al,1bh			; ESC ?
	jne	nemesc			; Nem ESC karakter
	call	sordel			; SortîrlÇs
	jmp	short escujk		; Vissza az elejÇre
nemesc:
	cmp	al,7fh			; CONTROL BACKSPACE ?
	jne	nemctb			; Nem, gombot vizsg†lunk
	mov	bx,offset elemci	; Ez a c°me
	push	[bx]			; ElmentjÅk
	call	sordel			; SortîrlÇs
	pop	[bx]			; Az elem c°me vissza
	jmp	short kialav		; Mehet regiszterkialak°t†sra
nemctb:
	call	vizsgo			; Gombvizsg†lat
	jnc	csenku			; Megtal†lta
	call	vizsgo			; Gombvizsg†lat
vimcim:
	jnc	csenku			; Megtal†lta
tacata:
	or	al,al			; ALT gomb ?
	je	csenku			; Igen, kihagyjuk
	cmp	al,'S' - '@'            ; CNTRL - S ?
	je	csenku			; Igen, kihagyjuk
	mov	dl,'G' - '@'            ; Csengî karakter
	cmp	al,dl			; CNTRL - G (csengî) ?
	je	csenka			; Igen, kihagyjuk
	mov	bx,offset status	; Ez a st†tusz c°me
	test	byte ptr [bx],insjel	; Besz£r†si m¢d volt ?
	jne	besumo			; Igen, kompar†l†s
	call	vegeta			; A vÇgÇn †ll ?
	jne	nevitu			; Nem, nem ellenîrizzÅk a hosszat
besumo:
	mov	dh,es:[si]		; Ez a maximum
	dec	dh			; Bele kell a CR-nek is fÇrni !
	cmp	dh,es:[si + 1]		; Van maradÇk ?
	jbe	csenka			; Ha elfogyott a hely
nevitu:
	call	szuelt			; SzÅk°tÇs kikapcsol†s
	and	byte ptr [bx],not cscomj; SzerkesztÇsi m¢d jelzÇs
	test	byte ptr [bx],insjel	; Besz£r†si m¢d volt ?
	je	leusim			; Nem, sim†n mehet
	call	vegeta			; A vÇgÇn †ll ?
	je	leusim			; Igen, nincs insert m¢d
	push	ax			; Karakter mentÇs
	push	si			; Itt van az eleje
	push	di			; Itt van jelenleg
	push	ds			; Adatszegmens is v†ltozni fog
	push	es			; Ez a cÇl szegmense
	pop	ds			; A forr†s is ez
	mov	cl,[si] 		; Ez a hossz (CH = 0)
	add	cx,si			; Ez a cÇl vÇge
	mov	si,cx			; A vÇgÇn t£lra mutat
	sub	cx,di			; Ennyi a mozgatand¢
	mov	di,si			; Itt a cÇl c°me
	inc	di			; Innen lehet venni
	inc	cx			; Igy a hat†rol¢ is mozog
	std				; Csîkkenî stringmÅvelet legyen
	rep	movsb			; Mozgat†s h†tra
	cld				; Nîvekvî stringmÅvelet legyen
	pop	ds			; Szegmens vissza
	pop	di			; Itt van jelenleg
	pop	si			; Az eleje c°me vissza
	call	aktkii			; Az aktu†lis ki°rat†s
	pop	ax			; Karakter vissza
	inc	byte ptr es:[si + 1]	; Hossz nîvelÇs
leusim:
	call	vegeta			; A vÇgÇn †ll ?
	stosb				; A karakter elpakol†sa
	jne	nevena			; Nem, nem alak°tunk rajta
	inc	byte ptr es:[si + 1]	; Hossz nîvelÇs
	mov	es:[di],ch		; VÇgjel inserthez
nevena:
	mov	dl,al			; Ezt ki kell °rni
csenka:
	call	kidosc			; Ki°rat†s
csenku:
	jmp	cikker			; Kîvetkezî karakter beolvas†s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	ENTER karakter. 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
enteve:
	mov	di,si			; A c°m m†solata
	add	di,cx			; Itt a vÇge - 2
	mov	es:[di + 2],al		; A karakter elpakol†sa (0dh)
	mov	dl,al			; Ezt ki kell °rni
	call	kidosc			; Ki°rat†s
	call	inselt			; Besz£r†si m¢d tîrlÇs
	or	[statul],insjel 	; Ezzel jelezzÅk, hogy az elsît
talbef:
	call	stlete			; A stack lÇtezik ?
	je	nimost			; Ha 0, nincs stack
	or	[statuh],nilira shr 8	; Ny°l ir†ny lefele van
	call	folmor			; Ir†nyv†lt†s
nimost:
	test	[statul],cscomj 	; Szerkesztett parancs ?
	jne	ninsta			; Nem, nem szerkesztett parancs
	mov	si,[parsok]		; Ez a puffer eleje
	mov	al,es:[si + 1]		; Ez a hossz
	cmp	al,[parmih]		; Elpakoljuk ?
	jbe	ninsta			; Nem, ezt nem kell
	mov	si,[stpoin]		; Itt a stack pointere
	mov	di,si			; Ez mutat a stack elsî elemÇre
	mov	cl,[stelsz]		; Ennyi lehet maximum
	mov	ch,0			; Igy ciklussz†m
kerfej:
	mov	si,[si] 		; Pointer m†sol†s
	or	si,si			; Ez a vÇge ?
	je	talstv			; Igen, stack vÇge
	loop	kerfej			; Ciklus a parancsokon
elvisa:
	mov	si,[di] 		; Ez a visszaadand¢ c°me
	mov	ax,[si] 		; Ez a kîvetkezî
	mov	[di],ax 		; Ez lesz a kîvetkezî l†ncelem
	mov	[di + 2],ax		; Ez lesz az aktu†lis l†ncelem
	push	di			; Ez a stack-fej
	mov	di,si			; Visszaad†si c°m
	call	memvis			; Visszadtuk az elsît
	pop	di			; Uj fej vissza
talstv:
	mov	si,[parsok]		; Ez a keresÇs eleje
	inc	si			; Ez a kezdîc°m
	mov	ch,0			; Felsî byte null†z†s
	mov	cl,es:[si]		; Ez a hossz
	add	cx,4 + 2		; T†rol¢ hossz + hossz + vÇg
	call	memker			; Ez a stack-t†rol¢ kÇrÇs
	mov	cx,0			; Null†z†s
	jne	talsta			; Van stack a kÇrÇsre
	mov	di,[stpoin]		; Itt a stack pointere
	cmp	[di],cx 		; Nulla ?
	je	ninsta			; Igen, nincs stack
	jmp	short elvisa		; Nem, visszaadjuk az elsî elemet
talsta:
	mov	cl,es:[si]		; Ez a hossz
	inc	cx			; Ez a hossz miatt
	inc	cx			; Ez a vÇgjel miatt
	mov	bx,di			; Ez a kezdîc°m
	xchg	di,si			; Hogy mehessen a rutin
	lodsw				; A pointer †tlÇpÇs
	lodsw				; A hossz †tlÇpÇs
	call	formas			; Puffer m†sol†s
	mov	[bx],cx 		; Ez meg nulla
	mov	di,[stpoin]		; Itt a stack pointere
	mov	si,[di] 		; Ez mutat a stack elsî elemÇre
	mov	[di + 2],si		; Ez az aktu†lis stack-elem
	or	si,si			; Van benne elem ?
	jne	elteem			; Van elem benne
	mov	[di],bx 		; Ez a saj†t c°mem
	mov	[di + 2],bx		; Ez az aktu†lis stack-elem
	jmp	short ninsta		; Fel van a l†ncra kapcsolva
nemels:
	mov	si,[si] 		; Ez a kîvetkezî puffer c°me
elteem:
	cmp	cx,[si] 		; Utols¢ pointer ?
	jne	nemels			; Nem, nem az utols¢
	mov	[si],bx 		; Ez mutat a kîvetkezîre
ninsta:
	call	szuelt			; SzÅk°tÇs kikapcsol†s
	test	[statul],symoff 	; Kell †talak°tani ?
	jne	sninko			; Nem, befejeztÅk
	mov	di,[parsok]		; Ez a keresÇs eleje
	scasw				; Itt az elsî karakter
	call	parveg			; CX <- darabsz†m
	mov	dx,cx			; Hossz mentÇs
	mov	bx,offset syntab	; Szinonima elem c°me
azonok:
	mov	bx,[bx] 		; Ez kîvetkezî szinonima
	or	bx,bx			; Nulla ?
	je	sninko			; Igen, befejezve
	mov	di,[parsok]		; Ez a kezdîc°m
	scasw				; Itt az elsî karakter
	mov	cx,dx			; Hossz
	lea	si,[bx + 5]		; Ez a karakterek c°me
	mov	ch,[bx + 4]		; Ez a hossz
	cmp	cl,ch			; Azonosak ?
	jne	mashos			; Nem, tal†n negativ ?
	call	cmpstr			; ôsszehasonl°t†s
	jne	azonok			; Ha nem azonos
	inc	si			; Ez a FIX kezdete
	mov	bx,si			; ElmentjÅk a kezdetet
	dec	cx			; CX <- 0FFFFh (mivel 0 volt !)
strvkm:
	inc	cx			; Stringhossz nîvelÇs
	lodsb				; Karakter beolvas†s
	or	al,al			; Nulla ?
	jne	strvkm			; Vissza a keresÇsre
	mov	[nyulci],cx		; Ebben van a hossz
	mov	si,[parsok]		; Puffer kezdîc°m
	inc	si			; Itt lesz a hossz
	mov	al,es:[si]		; Ez a hossz
	sub	al,dl			; Ennyi a parancs ut†ni hossz
	sub	cl,dl			; Ennyivel lesz tîle hosszabb
	mov	dh,cl			; Ez a kÅlînbsÇg
	add	cl,es:[si]		; Ez lenne az îsszhossz
	cmp	cl,es:[si - 1]		; ElfÇr ?
	jae	sninko			; Nem, nem m†solunk
	mov	dl,es:[si]		; Ez az aktu†lis hossz
	mov	es:[si],cl		; Ez az £j hossz
	mov	cl,dh			; Ennyit mozgatunk
	mov	dh,0			; Null†z†s
	inc	si			; Itt lesz a m†soland¢ eleje
	add	si,dx			; Eltol†s a vÇgÇre
	mov	di,si			; Ide m†solunk
	add	di,cx			; Ez a vÇgc°m
	mov	cl,al			; Ennyi a visszam†soland¢
	inc	cx			; Hogy a CR is m†solva legyen
	std				; Visszafele
	db	26h			; ES elîtag
	rep	movsb			; ètm†soljuk
	cld				; Vissza az ir†nyflag
	mov	si,bx			; Kezdet vissza
	mov	cx,[nyulci]		; Itt a hossz
	mov	di,[parsok]		; Itt a cÇl c°me
	scasw				; Ide kell pakolni
	rep	movsb			; Az £j parancs m†sol†sa
sninko:
	mov	sp,bp			; Stackpointer vissza
	pop	es			; Ez volt a h°v¢ ES
	pop	ds			; Ez volt a h°v¢ DS
	pop	bp			; Ez volt a h°v¢ BP
	pop	di			; Ez volt a h°v¢ DI
	pop	si			; Ez volt a h°v¢ SI
	pop	dx			; Ez volt a h°v¢ DX
	pop	cx			; Ez volt a h°v¢ CX
	pop	bx			; Ez volt a h°v¢ BX
	pop	ax			; Ez volt a h°v¢ AX
	iret				; Befejezve a stringad†s
mashos:
	and	ch,01111111b		; Legfelsî bit eltÅntetÇs
	mov	dl,cl			; Hossz mentÇs
	cmp	cl,ch			; Azonosak ?
	jne	azonok			; Nem, nem ez a szinonima
	call	cmpstr			; ôsszehasonl°t†s
	jne	azonok			; Ha nem azonos
	inc	si			; Itt kezdîdik a helyettes°tendî
	mov	[folcim],si		; ôsszehasonl°t†svÇg
kertop:
	mov	al,es:[di]		; Ez a kîvetkezî karakter
	cmp	al,0dh			; Van mÇg karakter ?
	je	nintok			; Nem, nincs tîbb
	call	szokar			; Sz¢hat†rol¢ ?
	jne	neokar			; Nem, ugrunk
	inc	di			; LÇpÇs a kîvetkezîre
	jmp	short kertop		; Vissza, keressÅk mÇg
neokar:
	call	parele			; Az elv†laszt¢k †tugr†sa
	cmp	al,0dh			; Van mÇg karakter ?
	je	nintok			; Nem, nincs tîbb
	call	parveg			; ParamÇter keresÇs
	push	cx			; Ez az eredeti hossz
	add	cx,4 + 1		; A fejjel Çs a vÇggel tîbb
	call	memker			; Mem¢riakÇrÇs
	je	sninko			; Ha nincs mem¢ria
	pop	cx			; Hossz vissza
	mov	bx,di			; Ez a cÇl c°me
	lea	si,[di + 4]		; Ide m†soljon
	mov	di,dx			; Itt volt az eleje
	call	formas			; Ford°tott m†sol†s
	mov	[si],cl 		; Nulla kitÇtel (CX = 0 !)
	mov	[bx],cx 		; Nulla kitÇtel (CX = 0 !)
	mov	si,offset parpoi	; Ez a paramÇterek helye
parkov:
	cmp	[si],cx 		; Nincs kîvetkezî ?
	je	ezutol			; Igen, ide kapcsoljuk
	mov	si,[si] 		; Kîvetkezîre
	jmp	short parkov		; Kîvetkezî vizsg†lat
ezutol:
	mov	[si],bx 		; A kîvetkezîre mutasson
	jmp	short kertop		; Tov†bbi param†terkeresÇsre
nintok:
	mov	si,[parsok]		; Pufferc°m
	mov	cl,es:[si]		; Ez a parancs max. hossza
	mov	ch,0			; Felsî byte null†z†s
	lea	di,[si + 2]		; Ez is az eleje
	add	si,cx			; PuffervÇg
	mov	[nyulci],si		; PuffervÇg mentÇs
	mov	si,[folcim]		; ôsszehasonl°t†svÇgc°m
nemnul:
	lodsb				; Ez a karakter
	cmp	al,'%'                  ; ParamÇter ?
	je	parbem			; Igen, paramÇterbem†sol†s lesz
	stosb				; Karakter kipakol†s
	or	al,al			; VÇge a m†solatnak ?
	je	befpas			; Igen, id†ig tartott
	cmp	al,'^'                  ; VÇge az elsî parancsnak ?
	je	eljeve			; Igen, vÇge
	cmp	al,'~'                  ; VÇge az elsî parancsnak ?
	je	eljeve			; Igen, vÇge
nivepa:
	cmp	di,[nyulci]		; Nem ny£lik t£l ?
	jne	nemnul			; Nem, mehet
	jmp	short pufvis		; Nincs hely, befejeztÅk
parbem:
	lodsb				; Ez a sz†mjegy
	cmp	al,'0'                  ; '0' karakternÇl kisebb ?
	jbe	karmas			; Igen, bem†solunk
	cmp	al,'9'                  ; '9' karakternÇl nagyobb ?
	ja	karmas			; Igen, bem†solunk
	mov	bx,offset parpoi	; Itt van a parancspointer
	and	al,0fh			; Bin†riss† alak°t†s
nemkop:
	mov	bx,[bx] 		; Ide mutat
	or	bx,bx			; Nulla ?
	je	nemnul			; Igen, parancsm†sol†s vÇge
	dec	al			; Ezt m†soljuk ?
	jne	nemkop			; Nem kîvetkezî paramÇter
mapato:
	mov	al,[bx + 4]		; Ez a karakter
	or	al,al			; Nulla ?
	je	nemnul			; Igen, paramÇter bem†solva
	inc	bx			; C°m nîvelÇs
	stosb				; Karakter kipakol†s
	cmp	di,[nyulci]		; Nem ny£lik t£l ?
	jne	mapato			; M†solhatjuk tov†bb
pufvis:
	mov	di,[parsok]		; Puffer kezdîc°m
	mov	es:[di + 1],0d00h	; öres puffer
	mov	[parpoi + 2],0		; Null†zunk, nincs folytat†s
	jmp	short csapuv		; Visszaadjuk a puffert
karmas:
	mov	al,'%'                  ; Ez lesz a kipakoland¢
	stosb				; Karakter kipakol†s
	dec	si			; Vissza a % ut†nra
	jmp	short nivepa		; KitehetjÅk a m†solatot
befpas:
	xor	si,si			; Ha tÇnyleg vÇge null†zunk
eljeve:
	mov	[parpoi + 2],si 	; Itt a folytat¢c°m
	mov	byte ptr es:[di - 1],0dh; CR karakter kipakol†s
	mov	si,[parsok]		; Ez a puffer
	lodsw				; SI <- SI + 2
	sub	di,si			; Ennyi lesz a hossza
	mov	cx,di			; Hossz m†solat
	dec	cx			; Hossz - hat†rol¢
	mov	es:[si - 1],cl		; Hossz kipakol†s
	test	[statul],insjel 	; INSJEL be†ll°tva ?
	jne	csapuv			; Igen, mehetsz vissza
	push	ds			; VisszamentÇsre eltesszÅk
	push	es			; Ezt tesszÅk DS-be
	pop	ds			; DS a ki°ratand¢
	mov	bx,1			; Ez a file-sz†m (STDOUT !!!)
	call	nullba			; Null byte-ig ki°rat†s
	pop	ds			; Eredeti vissza
csapuv:
	jmp	sninko			; Vissza, CARRY tîrlÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	HangjelzÇs v†lt†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hajelv:
	xor	[statuh],hajelb SHR 8	; V†ltunk
vimeel:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	DEL karakter.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
delcve:
	call	vegeta			; A vÇgÇn †ll ?
	je	vimeel			; Igen, nincs visszalÇpÇs
	mov	dl,es:[di]		; Ezt emul†ljuk
	call	kidosc			; Ki°rat†s
	inc	di			; Mintha ki°rtuk volna

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	BACKSPACE karakter.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bcksve:
	and	[statul],not cscomj	; SzerkesztÇsi m¢d jelzÇs
	call	milhos			; A hosszra r†kÇrdezÇs, 0 ?
	je	szuelt			; Igen, nem kell visszalÇpni
	call	vegeta			; A vÇgÇn †ll ?
	je	vissim			; Igen, sima visszalÇpÇs
	push	si			; Itt van az eleje
	push	di			; Itt van jelenleg
	push	ds			; Adatszegmens is v†ltozni fog
	call	vislep			; VisszalÇpÅnk egyet
	push	es			; Ez a cÇl szegmense
	pop	ds			; A forr†s is ez
	mov	cl,[si + 1]		; Ennyi a mozgatand¢
	add	cx,si			; Darab + c°m
	sub	cx,di			; Levonjuk az aktu†lis helyet
	add	cx,3			; + darab + aktu†lis + null-byte
	mov	si,di			; Ez az aktu†lis poz°ci¢
	dec	di			; Erre kell m†solni
	rep	movsb			; M†sol†s
	pop	ds			; Szegmens vissza
	pop	di			; Ez a jelenlegi hely
	pop	si			; Itt van az eleje
	dec	di			; Innen kell ki°ratni
	call	aktkii			; Az aktu†lis ki°rat†s
	jmp	short vikelc		; VisszalÇpÇs kÇsz
vissim:
	dec	di			; Pointer visszalÇptetÇs
	mov	es:[di],ch		; Nulla a string vÇgÇre
	call	bcksp1			; Kurzor vissza rutin
vikelc:
	dec	byte ptr es:[si + 1]	; Hossz csîkkentÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	SzÅk°tî karaktersor visszaad†s. 		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
szuelt:
	push	di			; Ne romoljon
	mov	di,[parpoi + 6] 	; Ez a szÅk°tÇs c°me
	or	di,di			; Volt ilyen c°m ?
	je	neketu			; Nem, nem adunk vissza
	call	memvis			; Visszadtuk az elsît
	xor	di,di			; DI <- 0
	mov	[parpoi + 6],di 	; C°m nincs jelzÇse
	mov	[parpoi + 8],di 	; C°m nincs jelzÇse
neketu:
	pop	di			; Regiszter vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	CONTROL END karakter.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
coenve:
	push	di			; Itt van most
	call	kurker			; DX = kurzorpoz°ci¢
	push	dx			; Ez a kurzorpoz°ci¢
torciv:
	mov	al,0			; AL <- 0
	scasb				; Utols¢ ?
	je	igebef			; Igen, nincs tov†bb
	call	kidosp			; TîrîlÅnk
	jmp	short torciv		; Vissza a kîvetkezî tîrlÇsÇre
igebef:
	pop	dx			; Ez a kurzor poz°ci¢ja
	call	vizsst			; KÇpernyî az output ?
	jne	nebavi			; Nem, nem a kÇpernyîre kerÅl
	mov	ah,2			; Kurzor be°r†s k¢dja
	int	10h			; Ez a vide¢ IT.
nebavi:
	pop	di			; Itt a helye
	mov	es:[di],ch		; Null†z†s
	mov	cx,di			; Hossz sz†mol†shoz
	sub	cx,si			; Ez a hossz + 2
	dec	cx			; CsîkkentjÅk
	dec	cx			; CsîkkentjÅk
	mov	es:[si + 1],cl		; Ez az igazi hossz
	sub	cl,es:[si]		; CX-be negativan a maradÇk
	not	cl			; Igy az igazi
	clc				; Befejezve
neurvv:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stack elem tîrlÇs.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lindve:
	mov	bx,[stpoin]		; Itt a stack pointere
	cmp	[bx],dx 		; Nulla ?
	je	neurvv			; Igen, nem tîrlÅnk
	mov	bx,[elemci]		; Ez a c°m az aktu†lis.
	or	bx,bx			; Volt c°m ?
	je	neurvv			; Nem, nem tîrlÅnk
	test	[statul],staelk 	; JeleztÅk, hogy stack-elem ?
	je	neurvv			; Nem, nem tîrlÅnk
	call	sordel			; KitîrÅljÅk az aktu†lis sort
	mov	es:[si + 1],cx		; Null†zunk
	mov	di,bx			; Ez az aktu†lis c°m
	mov	bx,[stpoin]		; Itt a stack pointere
kovker:
	cmp	[bx],di 		; Ez mutat r† ?
	je	erremu			; Igen, ez
	mov	bx,[bx] 		; Ez az elem a kîvetkezî
	jmp	short kovker		; Nem, menjÅnk tov†bb
erremu:
	mov	cx,[di] 		; Ez a kîvetkezî pointere
	mov	[bx],cx 		; Bepakoltuk az elîzînek
	mov	cx,bx			; Ez az elîzî pointer
	mov	bx,[stpoin]		; Itt a stack pointere
	mov	[bx + 2],cx		; A kîvetkezîre mutat
	call	memvis			; Visszadjuk a mem¢ri†t
	lea	di,[si + 2]		; Igy null†ra mutat
	or	[statul],folmoz 	; St†tusz jelzÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Le ny°l.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lenive:
	or	[statuh],nilira shr 8	; Ny°l ir†ny lefele van
	jmp	short nilhel

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Fîl ny°l.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fonive:
	and	[statuh],not (nilira shr 8); Ny°l ir†ny felfele van
nilhel:
	call	stlete			; A stack lÇtezik ?
	je	svinle			; Ha 0, nincs stack
	call	folmor			; Ir†nyv†lt†s
	mov	dx,[bx] 		; Ezt teheti kezdîelemnek
	call	stszuk			; SzÅk°tÇs elapkol†s
	call	sordes			; SortîrlÇs szÅk°tî tîrlÇs nÇlkÅl
nepasz:
	call	stlete			; BX be†ll°t†sa
	or	[statul],folmoz or elomoz; St†tusz be†ll°t†s
	mov	si,[bx] 		; Ezt teheti kezdîelemnek
	call	folmor			; Ir†nyv†lt†s
	mov	dx,[parpoi + 8] 	; Ez a forr†s c°me
	test	[statuh],nilira shr 8	; Ny°l ir†ny lefele van
	jne	halene			; Ez kell, nem az aktu†lis
	xor	dx,si			; ElÇrte m†r ?
	mov	si,[bx] 		; Ezt teheti kezdîelemnek
	jmp	short elemen		; St†tuszvizsg†lat
halene:
	xor	dx,si			; ElÇrte m†r ?
elemen:
	jne	kekomu			; Ha kell mÇg keresni
	test	[statul],cscomj 	; Szerkesztett parancs ?
	je	kekomu			; Igen, szerkesztett parancs
	mov	[bx],si 		; Ujra az elîbbi c°m
	mov	si,[parpoi + 6] 	; Ez a keresett string
	call	cimaru			; Ki°rjuk
	and	[statul],not cscomj	; Nem szerkesztett parancs
	mov	[elemci],dx		; Nincs elem
	mov	[parpoi + 6],dx 	; Nincs string
	mov	ax,[parpoi + 8] 	; Ez a forr†s c°me
	call	stlete			; BX be†ll°t†sa
	mov	[bx],ax 		; Eredeti helyre poz°cion†lok
	mov	al,'G' - '@'            ; CsengetyÅ
	stc				; Nincs feldolgozva
svinle:
	ret				; CsengetÅnk
kekomu:
	mov	[elemci],si		; Ez az elem van Çppen
	mov	bx,[stpoin]		; Itt a stack pointere
vkermu:
	cmp	[bx],si 		; Ez mutat r†m ?
	je	emupak			; Igen, elpakolhat¢
	mov	bx,[bx] 		; Ez a kîvetkezî
	jmp	short vkermu		; Vissza keresni
kipufe:
	or	byte ptr [statul],cscomj or staelk; St†tusz be†ll°t†s
	mov	bx,[parpoi + 6] 	; Ez a cÇl c°me
	or	bx,bx			; Van ?
	je	nincit			; Nincs c°m
	call	ohstrk			; Azonos a kÇt string ?
	jne	nepasz			; Ha nem azonos
nincit:
	push	di			; Ez lesz majd az SI
	inc	di			; Kipakol†si hely
	inc	cx			; Mert a sz†ml†l¢t is kell
	rep	movsb			; Parancs m†sol†s
	mov	es:[di],cl		; Nulla kivitel
	and	byte ptr [statul],not linjeb; TîrîljÅk, hogy stackelem
	pop	si			; Ide pakoltuk le
	lea	di,[si + 2]		; DI <- SI + 2
	jmp	short kiitel		; Ki°rjuk teljesen
emupak:
	mov	[stujci],bx		; Ez az elem mutat r†m
cimaru:
	mov	di,[parsok]		; Ez a cÇl c°me
	lodsw				; A pointer †tlÇpÇs
	lodsw				; A hossz †tlÇpÇs
	mov	al,'G' - '@'            ; Csengî karakter
	mov	cl,[si] 		; Ez a hossz byte
	cmp	es:[di],cl		; Nem kicsi a puffer ?
	jnc	kipufe			; Nem, elÇg
	mov	si,di			; Ez a puffer c°me
	inc	di			; DI <- sz†ml†l¢
	mov	word ptr es:[di],0	; Null†zunk
	inc	di			; DI <- elsî karakter c°me
	ret				; VisszatÇrÇs hib†val

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sz¢lÇptetî gombok.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
conive:
	call	milhos			; A hosszra r†kÇrdezÇs, 0 ?
	je	vegena			; Igen, nem lÇpÅnk
	dec	di			; Elîzî karakterre
	call	szokar			; Sz¢vÇgi karakter ?
	jne	martar			; Nem, vissza tov†bb
	call	vislep			; VisszalÇpÅnk egyet
	jmp	short conive		; Eddig volt m†r meg
kersov:
	call	milhos			; A hosszra r†kÇrdezÇs, 0 ?
	je	vegena			; Igen, nem lÇpÅnk
	dec	di			; Elîzî karakterre
martar:
	call	vislep			; VisszalÇpÅnk egyet
	call	szokar			; Sz¢vÇgi karakter ?
	jne	kersov			; Nem, vissza tov†bb

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Jobbra ny°l.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
jobnve:
	call	karbev			; A vÇgÇn †ll ?
	je	vegena			; Igen, nem lÇpÅnk elîre
	inc	di			; Mintha ki°rtuk volna
	jmp	kidosc			; Ki°rat†s, CLC, RET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	HOME gomb.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
homeve:
	lea	cx,[di - 2]		; Ez az aktu†lis hely - 2
	sub	cx,si			; Ez az eleje
	je	nedels			; Ha nincs mit visszalÇpni
	mov	bx,offset status + 1	; Itt a DELJEL byte-ja
	or	byte ptr [bx],deljel shr 8; VisszalÇpÇsnÇl nem tîrlÅnk
	call	bckspc			; Kurzor vissza rutin
	and	byte ptr [bx],not (deljel shr 8); St†tusz vissza†ll°t†s
nedels:
	lea	di,[si + 2]		; Ez az elsî karakter helye
vegena:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Visszafele sz¢lÇptetî gombok.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
szoeve:
	call	szokar			; Sz¢vÇgi karakter ?
	je	kersom			; Igen, nem megyÅnk a sz¢n
	call	karbev			; Karakter beolvas†s, 0 ?
	je	vegeso			; Igen, nincs tov†bb
	inc	di			; Kîvetkezîre
	call	kidosc			; Ki°rat†s
	jmp	short szoeve		; Nem, vissza tov†bb
kersom:
	call	karbev			; Karakter beolvas†s, 0 ?
	je	vegeso			; Igen, nincs tov†bb
	inc	di			; Kîvetkezîre
	call	kidosc			; Ki°rat†s
	call	szokar			; Sz¢vÇgi karakter ?
	je	kersom			; Igen, keressÅk a vÇgÇt
vegeso:
	clc				; Befejezve
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancssorki°rat¢.				;
;							;
;	Input:	ES:DI <- a ki°rand¢ elsî eleme		;
;							;
;	Output: DL -> Hat†rol¢ karakter 		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
makika:
	inc	di			; Kîvetkezîre
	call	kidosc			; Ki°rat†s
kiitel:
	call	karbev			; Karakter beolvas†s, 0 ?
	je	befvis			; Igen, nincs tov†bb
	cmp	dl,0dh			; CR ?
	jne	makika			; Ki°ratjuk a karaktert
befvis:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Balra ny°l.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
balnve:
	call	milhos			; A hosszra r†kÇrdezÇs, 0 ?
	je	befvis			; Igen, nem lÇpÅnk
	dec	di			; Ide lÇphet

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	VisszalÇpÇs egyet, tîrlÇs nÇlkÅl.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vislep:
	mov	bx,offset status + 1	; Itt a DELJEL byte-ja
	or	byte ptr [bx],deljel shr 8; VisszalÇpÇsnÇl nem tîrlÅnk
	call	bcksp1			; Kurzor vissza rutin
	and	byte ptr [bx],not (deljel shr 8); St†tusz vissza†ll°t†s
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	LeÅtÇskÇrÇs.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
elobec:
	int	16h			; Klaviat£ra leÅtÇsv†r†s (AH = 0)
igtabr:
	mov	ah,0bh			; DOS st†tusz kÇrÇs
	int	21h			; DOS h°v†s
kerleu:
	mov	ax,[status]		; Ez a lekÇrdezÇshez az AT bit
	and	ah,atjelz shr 8 	; KÇrhetÅnk AT rutint ?
	inc	ah			; Csak st†tuszvizsg†lat
	int	16h			; Klaviat£ra leÅtÇsv†r†s
	je	kerleu			; Ha nincs leÅtÇs
	cmp	ax,2e03h		; CNTRL C ?
	je	igtabr			; Igen, CNTRL BREAK lesz
	or	ax,ax			; CNTRL BREAK ?
	je	elobec			; Igen, elîszîr beolvasunk
	mov	ax,[status]		; Ez a lekÇrdezÇshez az AT bit
	and	ah,atjelz shr 8 	; KÇrhetÅnk AT rutint ?
	int	16h			; Klaviat£ra leÅtÇsv†r†s
	cmp	al,0e0h 		; AT v†lasz ?
	jne	nematv			; Nem, lehet egyÇb
	mov	al,0			; Null†zzuk
nematv:
	or	ah,ah			; SCAN k¢d 0 ?
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	String îsszehasonl°t†s. 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ohstrk:
	push	si			; Elromlik
	push	di			; Elromlik
	push	cx			; Elromlik
	push	es			; Helyette
	push	ds			; Ebbîl lesz ES
	pop	es			; ES <- DS
	lea	di,[bx + 4]		; Itt lesz a sz†ml†l¢
	mov	cl,[di] 		; Ennyit hasonl°tunk
	cmpsb				; Darabsz†m †tlÇpÇs
	call	cmpstr			; Azonos ?
	pop	es			; Eredeti forr†s
	pop	cx			; Sz†ml†l¢ vissza
	pop	di			; CÇl vissza
	pop	si			; Forr†s vissza
	ret				; VisszatÇrÇs hib†val

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stack szÅk°tî c°m vizsg†lata.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stszuk:
	cmp	word ptr [parpoi + 6],0 ; Volt ilyen c°m ?
	jne	nemsem			; Igen, nem tesszÅk el mÇgegyszer
	jcxz	nemsem			; Ha nincs hossza
	test	[statul],cscomj 	; Szerkesztett parancs ?
	jne	nemsem			; Nem, nem szerkesztett parancs
	push	si			; El ne romoljon
	push	di			; El ne romoljon
	push	cx			; Ez az eredeti hossz
	add	cx,4 + 1		; A fejjel Çs a hosszal tîbb
	call	memker			; Mem¢riakÇrÇs
	pop	cx			; Hossz vissza
	je	nemmar			; Ha nincs mem¢ria
	mov	[parpoi + 6],di 	; Ez a cÇl c°me
	mov	[parpoi + 8],dx 	; Ez a stack jelenlegi pointere
	lea	si,[di + 4]		; Ide m†soljon
	mov	di,[parsok]		; Itt volt az eleje
	inc	di			; Itt van a darab
	inc	cx			; A darabsz†m miatt
	call	formas			; Ford°tott m†sol†s
nemmar:
	pop	di			; Visszaveszem
	pop	si			; Visszaveszem
nemsem:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stack lÇtezÇs vizsg†lat 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stlete:
	mov	bx,[stpoin]		; Itt a stack pointere
	inc	bx			; Ez egy fÇl nîvelÇs
	inc	bx			; Ez az aktu†lis hely
	cmp	word ptr [bx - 2],0	; Ez a stack vÇge
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Gombvizsg†latok.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vizsgo:
	mov	cl,es:[si + 1]		; Ennyi byte a parancs
	mov	bx,offset gomtab - 4	; Itt az ugr¢t†bla
vizsmi:
	add	bx,4			; LÇpÇs a kîvetkezîre
	cmp	word ptr [bx],0 	; Nulla ?
	je	parutv			; Igen, tov†bb
	cmp	[bx],ax 		; Ez a rutin ?
	jne	vizsmi			; Nem, m†sik
	push	[bx + 2]		; Ez a c°me a vÇgrehajt†snak
	mov	bx,1			; STDOUT file-sz†m
	or	cx,cx			; St†tusz be†ll°t†s
	ret				; MehetÅnk vÇgrehajtani

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancskiad†s vizsg†lat.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
parutv:
	stc				; Hibajel (nincs meg a karakter)
	jcxz	venepa			; Ha nincs a sorban
	ret				; VisszatÇrÇs
venepa:
	push	di			; ElmentjÅk ha az eleje
	mov	di,offset syntab + 2	; Parancskiad†s feje
covici:
	mov	bx,di			; Ez mutat r†
	mov	di,[di] 		; Ez a kîvetkezî
	or	di,di			; VÇge a parancsoknak ?
	je	igpave			; Igen, nÇzzÅk a sorokat
	cmp	ax,[di + 4]		; Ez a parancs volt ?
	jne	covici			; Nem, nÇzzÅk tov†bb a l†ncot
	mov	al,0dh			; Hogy vizsg†lat ut†n mehessen
	jmp	short combem		; Bem†soljuk
igpave:
	mov	di,offset syntab + 4	; Sorkiad†s feje
livici:
	mov	bx,di			; Ez mutat r†
	mov	di,[di] 		; Ez a kîvetkezî
	or	di,di			; VÇge a parancsoknak ?
	je	iglive			; Igen, nÇzzÅk a tov†bbit
	cmp	ax,[di + 4]		; Ez a parancs volt ?
	jne	livici			; Nem, nÇzzÅk tov†bb a l†ncot
	mov	ax,4f00h		; Hogy vizsg†lat ut†n ne mehessen
combem:
	push	di			; MentjÅk a kezdetet
	lea	di,[di + 5]		; Ez a kezdet szîvegben  - 1
	xor	dx,dx			; Null†zzuk
vikark:
	inc	di			; Kîvetkezîre a pointer
	inc	dl			; Hossz nîvelÇs
	cmp	[di],dh 		; Ez a karakter nulla ?
	jne	vikark			; Nem, vissza karaktervizsg†latra
	pop	di			; Ez az kezdîc°m
	dec	dx			; Vissza
	cmp	es:[si],dl		; Elfogadhat¢ ?
	jbe	iglive			; Nem, t£l hossz£ a sor
	pop	cx			; DI-t kivesszÅk a stack-bîl
	mov	cx,dx			; Ennyi hossz£
	mov	[stujci],bx		; Ez a mutat¢ r†m
	mov	[elemci],di		; Ez az elem van Çppen
	mov	bx,offset status	; Ez a st†tusz c°me
	or	byte ptr [bx],linjeb or cscomj; JelezzÅk, hogy sorelem
	and	byte ptr [bx],not staelk; TîrîljÅk, hogy stackelem
	lea	di,[di + 6]		; Ez a hossz c°me (DI <- DI + 6)
	xchg	si,di			; DI <- kezdet, SI <- parancs
	inc	di			; Kipakol†si hely
	mov	es:[di],cl		; Hossz kipakol†s
	inc	di			; Ide jîn a kîvetkezî karakter
	inc	cx			; A null-byte is !
	rep	movsb			; Bem†soljuk
	mov	si,[parsok]		; Ide pakoljuk majd le
	lea	di,[si + 2]		; DI <- SI + 2
	cmp	al,0dh			; A sor vÇgÇre ?
	jne	mebefl			; Ha £gyis a vÇgÇre megy
	call	kiitel			; Ki°rjuk teljesen
	mov	ax,0dh			; CR lesz
	mov	bx,offset status + 1	; Ez a COLIBE byte c°me
	test	byte ptr [bx],colibe shr 8; A parancssor list†z¢dik ?
	je	mebefl			; Nem, indulhat
	and	byte ptr [bx],not (colibe shr 8); St†tusz tîrlÇs
	ret				; VisszatÇrÇs
iglive:
	pop	di			; Ide kell tennie
mebefl:
	stc				; Kell folytatni
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szinonima kikapcsol†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
syatve:
	xor	[statul],symoff 	; ètalak°t†s ellentett (CY <- 0)
vitemo:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	LINE t°pus£ parancs hozz†ad†sa. 		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
liadve:
	mov	bx,offset syntab + 4	; Ez a fejpointer
	jmp	short inazon		; Igen, itt folytassuk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	COMMAND t°pus£ parancs hozz†ad†sa.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
coadve:
	mov	bx,offset syntab + 2	; Ez a fejpointer
inazon:
	jcxz	vitemo			; Igen, erre nem reag†lunk
	push	di			; Az aktu†lis c°m mentÇs
	add	cx,4 + 2 + 1		; Ennyi hely kell
	call	memkes			; Mem¢ria kÇrÇs sikeres lesz ?
	pop	di			; Az aktu†lis c°m vissza
	jne	siklek			; Ha sikeresen fog kÇrni
	mov	ax,'G' - '@'            ; Csengî karakter
	stc				; Ki kell °rni
	ret				; VisszatÇrÅnk
siklek:
	call	sordel			; KitîrîljÅk a sort
	mov	di,bx			; Ez a fejc°m
	mov	al,'?'                  ; Ezt villogtatjuk
	call	vilxor			; Villogtatunk
	call	kerleu			; LeÅtÇst v†runk
	je	hibazs			; ALT-sz†m, ez hiba
	mov	dx,ax			; Elmentem
	or	al,al			; ALT volt ?
	je	karnea			; Igen, ALT-volt
	mov	ah,0			; SCAN k¢d tîrlÇs
karnea:
	cmp	al,1bh			; ESC karakter ?
	je	nehijs			; Igen, nincs hibajelzÇs sem
	mov	bx,offset gomtab - 4	; Itt az ugr¢t†bla
vizfaj:
	add	bx,4			; LÇpÇs a kîvetkezîre
	cmp	[bx],ax 		; Ez a rutin ?
	je	hibazs			; Igen, van baj
	cmp	word ptr [bx],0 	; Nulla ?
	jne	vizfaj			; Nem, tov†bb
	mov	bx,offset syntab + 2	; Parancskiad†s feje
covime:
	push	bx			; ElmentjÅk
coviel:
	mov	bx,[bx] 		; Ez a kîvetkezî
	or	bx,bx			; VÇge a parancsoknak ?
	je	palave			; Igen, nÇzzÅk a sorokat
	cmp	ax,[bx + 4]		; Ez a parancs volt ?
	jne	coviel			; Nem, nÇzzÅk tov†bb a l†ncot
	pop	bx			; C°m vissza
hibazs:
	jmp	hibazc			; Elugrunk a hib†ra
palave:
	pop	bx			; C°m vissza
	inc	bx			; LÇptetÇs fÇl pointert
	inc	bx			; LÇptetÇs fÇl pointert
	cmp	bx,offset syntab + 4	; Sorkiad†s feje ?
	je	covime			; Igen, ezt is megnÇzzÅk
	mov	ax,dx			; Karakter vissza
	xchg	al,ah			; MegcserÇljÅk
	or	ah,ah			; Nem ASCII ?
	je	alkata			; Nem, mehet rîgtîn
	test	ah,not (' ' - 1)        ; Ez CNTRL karakter ?
	jne	hibazs			; Nem, ez hiba
	mov	al,0			; Ez null†zva
	jmp	short takaez		; Megtal†ltuk a karakter
alkata:
	mov	bx,offset scanta	; Ez a t†bl†zat eleje
	mov	cl,1fh			; Ennyi lehet maximum
kescta:
	mov	ah,[bx] 		; Ez egy SCAN k¢d
	inc	bx			; LÇpÇs a kîvetkezîre
	cmp	ah,al			; Azonos a SCAN k¢d ?
	je	talmir			; Igen, megtal†ltuk
	loop	kescta			; Keresî ciklusra
	mov	ah,0			; Felsî byte null†z†s
	mov	bx,offset pkodta	; Ez e fej c°me
befgok:
	mov	cl,[bx] 		; Beolvassuk a karakter
	inc	bx			; Ez a kîvetkezî c°me
	cmp	cl,ch			; Nulla ?
	jne	befgok			; Nem keresÅnk tov†bb
	cmp	[bx],ax 		; Sima gomb ?
	je	takaez			; Igen, ÇrvÇnys gomb
	cmp	[bx + 2],ax		; SHIFT gomb ?
	je	takaez			; Igen, ÇrvÇnys gomb
	cmp	[bx + 4],ax		; CNTRL gomb ?
	je	takaez			; Igen, ÇrvÇnys gomb
	cmp	[bx + 6],ax		; ALT gomb ?
	je	takaez			; Igen, ÇrvÇnys gomb
	add	bx,8			; Itt lesz a kîvetkezî
	cmp	[bx],cl 		; VÇge ?
	jne	befgok			; Nem kîvetkezî azonos°t¢
	jmp	short hibazc		; Ha ki°rtam m†r a karaktert
nehijs:
	jmp	short nehije		; BefejeztÅk
talmir:
	mov	ah,0			; Ezt le kell null†zni
takaez:
	xchg	ah,al			; Most vissza kell cserÇlni
felfuk:
	mov	bx,di			; Ez a fej
	mov	cl,es:[si + 1]		; Ennyi byte a parancs
	add	cx,4 + 2 + 1		; Ennyi hely kell
	call	memker			; Mem¢ria kÇrÇs
	je	hibazc			; Ha nincs mem¢ria
kefefh:
	mov	cx,bx			; Ez elîzî
	mov	bx,[bx] 		; Ez a kîvetkezî
	or	bx,bx			; Nulla ?
	je	itjohe			; Igen, ide fÅzzÅk
	cmp	[bx + 4],ax		; Ide jîhet ?
	jb	kefefh			; Keresse tov†bb a helyet
itjohe:
	mov	[di + 4],ax		; Ez a karakter
	mov	[di],bx 		; R†mutatunk a kîvetkezîre
	mov	bx,cx			; Eddig ez mutatott ide
	mov	[bx],di 		; Most r†m mutat
	add	di,6			; Ide °rhatja a karaktereket
	inc	si			; Itt lesz a hossz
	mov	cl,es:[si]		; Ennyi byte a parancs
	mov	ch,0			; CX-be a darabsz†m
	inc	si			; Itt kezdîdik a string
	xchg	di,si			; Igy m†sol helyesen
	call	formas			; Bem†soljuk a stringet
	mov	[si],cl 		; Hat†rol¢ karakter (0)
	mov	si,[parsok]		; Itt az eredeti c°m
	jmp	short nehije		; BefjeztÅk
hibazc:
	mov	dl,'G' - '@'            ; Csengî karakter
	call	kidosc			; Ki°rat†s
nehije:
	mov	al,' '                  ; TîrlÇs Çs villogtat†s kikapcs.
	call	vilxor			; Villogtatunk
	lea	di,[si + 2]		; Itt †ll jelenleg
vizveg:
	jmp	kiitel			; Ki°rjuk teljesen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	STACK-v†lt†s.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
strove:
	mov	ax,offset stackc	; Ez a command stack c°me
	cmp	ax,[stpoin]		; Ez a pointer az ?
	jne	ekozst			; Nem, ez a c°m marad
	mov	ax,offset stackc + 4	; Ez a kîzîs stack c°me
ekozst:
	mov	[stpoin],ax		; Itt a stack £j pointere
	clc				; St†tusz be†ll°t†s
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	COMMAND t°pus£ parancs edit†l†s bekapcsol†sa.	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
edcove:
	or	[statuh],colibe shr 8	; Csak list†z¢dik (CY <- 0)
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	LINE t°pus£ parancs list†z†s.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
liatvg:
	jne	befsyr			; Ha nem Åres a sor
	mov	cx,offset syntab + 4	; Ez a fej c°me
	mov	dx,offset linres	; Ez a szîveg c°me
kiliva:
	jmp	kiliso			; Kilist†zzuk a szimb¢lumokat

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	COMMAND t°pus£ parancs list†z†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
coatvg:
	jne	befsyr			; Ha nem Åres a sor
	mov	cx,offset syntab + 2	; Ez a fej c°me
	mov	dx,offset comres	; Ez a szîveg c°me
	jmp	short kiliva		; Csak a c°mek m†sak

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szinonima list†z†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
synlve:
	jne	befsyr			; Ha nem Åres a sor
	test	[statul],symoff 	; Kell †talak°tani ?
	jne	befsyr			; Nem, nÇzzÅk tov†bb
	push	di			; Ez a fejpointer
	call	crlfki			; Uj sor karakterek ki°r†sa
szikif:
	push	si			; Ez lesz a c°m forr†sa
	mov	di,offset syntab	; Szinonima elem c°me
	push	di			; C°m mentÇs
szinki:
	mov	di,[di] 		; Ez a kîvetkezî
	or	di,di			; Van egy†ltal†n ?
	je	befsym			; BefejezzÅk, vÇge
	cmp	byte ptr [di + 4],ch	; Negativ ?
	jns	szinki			; Nem, ezt nem °ratjuk ki
	mov	si,offset synres	; Ez akkor ha szinonima
	call	egyszi			; Egy szinonima ki°rat†s
	jmp	short szinki		; LÇpÇs a kîvetkezîre
befsym:
	call	crlfki			; Uj sor karakterek ki°r†sa
	pop	di			; Szinonima elem c°me
fixkii:
	mov	di,[di] 		; Ez a kîvetkezî
	or	di,di			; Van egy†ltal†n ? (CY <- 0)
	je	befkil			; BefejezzÅk, vÇge
	cmp	byte ptr [di + 4],ch	; Negativ ?
	js	fixkii			; Igen, ezt nem °ratjuk ki
	mov	si,offset fixres	; Ez akkor ha fix parancs
	call	egyszi			; Egy szinonima ki°rat†s
	je	fixkii			; LÇpÇs a kîvetkezîre
befkil:
	pop	si			; A ki°rat†si c°m vissza
	pop	di			; Eredeti vissza
befsyr:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stack tîrlÇs.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stdeve:
	call	sordel			; KitîrÅljÅk az aktu†lis sort
	mov	es:[si + bx],cx 	; Nincs karakter (BX = 1 !!!!)
	mov	bx,[stpoin]		; Itt a stack pointere
	cmp	[bx],cx 		; Nulla ?
	je	neurvs			; Nem, nem tîrlÅnk (CY = 0)
	mov	di,[bx] 		; Ez a fej
	mov	[bx],cx 		; Nincs elem
	mov	[bx + 2],cx		; Nincs aktu†lis elem
	call	lancik			; Visszadjuk a mem¢rial†ncot
	lea	di,[si + 2]		; Igy null†ra mutat
neurvs:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stack list†z†s. 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stacve:
	jne	neurvs			; Nem, akkor nem list†zunk
	push	si			; Elrontjuk
	push	di			; Ez majd most romlik
	mov	si,[stpoin]		; Itt a stack pointere
	cmp	[si],cx 		; Nulla ?
	je	necxvi			; Ha nincs mit list†zni
	mov	di,si			; Ez a ki°ratand¢ c°m
kostki:
	call	crlfki			; Uj sor karakterek ki°r†sa
	jne	necxvi			; Ha hib†s a ki°rat†s
	mov	di,[di] 		; Ez a kîvetkezî elem
	or	di,di			; Ez £jra a fej ?
	jne	neujfe			; Nincs £j elem list†z†s
necxvi:
	pop	di			; DI vissza
	pop	si			; Sz†ml†l¢ vissza
vimeni:
	ret				; VisszatÇrÇs
neujfe:
	call	altjki			; Ki°ratjuk a karaktert
	inc	cx			; A kîvetkezî
	mov	ax,cx			; Hogy dec°m†lis lehessen
	aam				; Dek¢dol†s
	or	ah,ah			; Van tizes ?
	je	tininc			; Ha nics tizes
	push	ax			; Elpakoljuk kÇsîbbre
	mov	al,ah			; Ez lesz a tizes
	or	al,'0'                  ; Karakteres°tÅnk
	call	tabkto			; Ki°ratjuk a karaktert
	pop	ax			; Ez a ciklussz†m m†solata
tininc:
	or	al,'0'                  ; KarakteresitÅnk
	call	tabkto			; Ki°ratjuk a karaktert
	cmp	[si + 2],di		; Erre mutat ?
	jne	nemcsi			; Nem, nincs csillag
	call	spkiir			; Ki°runk sz¢kîzt
	mov	al,'*'                  ; Ez lesz az jelzî
	call	tabkto			; Ki°ratjuk a karaktert
nemcsi:
	call	tabkii			; Ki°ratjuk a karaktert
	push	si			; ElmentjÅk az elejÇt
	lea	si,[di + 5]		; Ez a ki°ratand¢
	call	nullba			; Ki°ratjuk az elem tartalm†t
	pop	si			; Fejc°m vissza
	jmp	short kostki		; Uj elem list†z†sra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Visszajav°t†s.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vijave:
	mov	bx,offset status	; Ez a st†tusz c°me
	or	byte ptr [bx],cscomj	; JelezzÅk, hogy ne tegye el
	test	byte ptr [bx],staelk or linjeb; Stack, sor vagy parancs ?
	je	vimeni			; Nem, nem tesszÅk el
	mov	bx,[elemci]		; Ez az elem van Çppen
	or	bx,bx			; Van elem ?
	je	vimeni			; Nem, nem tesszÅk el
	push	di			; Ez az eredeti c°m
	mov	di,bx			; Ezt kell visszaadni
	push	[di]			; Ez az eredeti tovapointer
	mov	ax,[di + 2]		; Hossz kiolvas†s
	push	[di + 4]		; H°v¢ karakter mentÇs (ha az !)
	call	memvis			; Ez az elem
	mov	cl,es:[si + 1]		; Ez a hossz
	jcxz	hautot			; Ha nincs benne elem
	test	[statul],linjeb 	; Stack, sor vagy parancs ?
	je	nenoli			; Nem, nem nîveljÅk
	inc	cx			; Nincs hossz, de van karakter
nenoli:
	add	cx,4 + 2		; T†rol¢ hossz + hossz + vÇg
	call	memker			; Mem¢ria kÇrÇs
	jne	talcse			; Sikeres volt a kÇrÇs
	mov	cx,ax			; Ez a (visszaadott) hossz
	call	memkes			; St†tusz kÇrÇs
	lea	si,[bx + 6]		; Ez az eredeti
	add	di,6			; A hossz a pointer Çs a karakter
	sub	cx,6			; Ennyivel kevesebbet
	push	es			; Ez a h°v¢Ç
	push	ds			; Ez a saj†t szegmensem
	pop	es			; Igy ugyanoda mutat
	rep	movsb			; ètm†soljuk
	pop	es			; Ez a h°v¢Ç
	mov	cx,ax			; Ez az a (visszaadott) hossz
	call	memker			; Mem¢ria kÇrÇs
	mov	dl,'G' - '@'            ; Csengî karakter
	pop	[di + 4]		; Ez a karakter
	pop	[di]			; Ide mutasson tov†bb
	jmp	short nemopo		; Itt folytassa
hautot:
	pop	ax			; Karakter ÅritÇs
	mov	bx,[stujci]		; Ez a mutat¢ r†m
	pop	[bx]			; Ide mutasson tov†bb
	jmp	short nemope		; Sikeresen eltÅntettÅk
talcse:
	pop	[di + 4]		; Ez a karakter
	pop	[di]			; Ide mutasson tov†bb
	inc	si			; SI <- hosszbyte c°me
	mov	cl,es:[si]		; Ez a hossz
	mov	ch,0			; Lehet maradÇk is
	inc	cx			; Ez a hossz miatt
	inc	cx			; Ez a vÇgjel miatt
	mov	bx,di			; Ez a kezdîc°m
	xchg	di,si			; Hogy mehessen a rutin
	lodsw				; A pointer †tlÇpÇs
	lodsw				; A hossz †tlÇpÇs
	test	[statul],linjeb 	; Stack, sor vagy parancs ?
	je	nemahi			; Nem, nem nîveljÅk
	lodsw				; A karakter †tlÇpÇs
	inc	di			; A hosszt ne mozgassuk
	dec	cx			; A hossz csîkkentÇse
nemahi:
	call	formas			; Puffer m†sol†s
	mov	si,[stujci]		; Ez a mutat¢ r†m
	mov	cx,[si] 		; Ez az eredeti
	mov	[si],bx 		; Ez most m†r r†m mutat
	mov	si,[stpoin]		; Ez a stack feje
	lodsw				; SI <- SI + 2
	cmp	[si],cx 		; Ez az aktu†lis elem ?
	jne	nemope			; Nem, nem m¢dositjuk
	mov	[si],bx 		; Ez most m†r r†m mutat
nemope:
	mov	dl,0			; JelezzÅk, hogy sikeres
nemopo:
	xor	ax,ax			; AX <- 0 (ezt kell kitenni)
	mov	[elemci],ax		; Null†zunk
	and	[statul],not (staelk or linjeb) ; St†tusz tîrlÇs
	mov	si,[parsok]		; Ez a puffer eleje
	pop	di			; A karakterpointer is vissza
	or	dl,dl			; Van csngî karakter ?
	je	csenni			; Igen, menjen csengetni
	stc				; Folytassa !
csenni:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°rjuk a command/line sort.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiliso:
	push	si			; Ez lesz a ki°rat†si c°m
	push	di			; Ez lesz a pointer
	push	dx			; Rontj†k a ki°rat†sok
	mov	di,cx			; Ez a pointer a fejre
kecrki:
	call	crlfki			; Uj sort ind°tunk
kerfec:
	mov	di,[di] 		; Ez a kîvetkezî ki°ratand¢
	or	di,di			; Nulla ? (CY <- 0)
	je	befkcl			; Igen, befejeztÅk
	pop	si			; DX vissza
	push	si			; Rontj†k a ki°rat†sok
	call	nullba			; Ki°ratjuk a megnevezÇs
	call	tabkii			; Ki°ratjuk a tabul†tort
sikiir:
	mov	ax,[di + 4]		; Ezt vizsg†ljuk
	call	bilazo			; BillentyÅ azonos°t¢ ki°rat†s
	call	tabkii			; Ki°ratjuk a tabul†tort
	lea	si,[di + 6]		; Inne °rja ki
	call	nullba			; Ki°rjuk a sringet
	je	kecrki			; Ha sikeres
befkcl:
	pop	dx			; DX vissza
	pop	di			; DI vissza
	pop	si			; SI vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°rjuk a billentyÅazonos°t¢t.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bilazo:
	cmp	ax,0ah			; CNTRL ENTER ?
	je	egyevi			; Ha az
	or	al,al			; CNTRL karakter ?
	je	altkar			; Nem, akkor ALT lehet
	push	ax			; A karakter mentÇse
	call	cntrlj			; Ki°runk CNTRL jelet
	pop	ax			; Karakter vissza
	jne	bilabe			; Ha nem sikeres
	jmp	short kiicat		; Ki°ratjuk a karaktert
altkar:
	mov	si,offset scanta	; H†tha ALT karakter
	mov	cx,1fh			; Ennyi karakter van
altker:
	lodsb				; Ez az ALT karakter
	cmp	al,ah			; Ez az ?
	je	metalt			; Igen, ki°ratjuk
	loop	altker			; Vissza az elejÇre
	mov	al,0			; Ilyen volt az eredeti
	jmp	short egyevi		; Ha nem ALT karakter
metalt:
	push	cx			; A karakter mentÇse
	call	altjki			; Ki°runk ALT jelet
	pop	ax			; Karakter vissza
	jne	bilabe			; Ha nem sikeres
	sub	al,1fh			; Ez a karakter
	neg	al			; Elîjel v†lt†s
kiicat:
	or	al,60h			; Igy lesz karakter belîle
	call	tabkto			; Ki°ratjuk a karaktert
bilabe:
	ret				; BefejzzÅk
egyevi:
	mov	si,offset pkodta	; Ez e fej c°me
befkak:
	mov	cx,si			; Ez a karaktersor eleje
	push	ax			; Ezt vizsg†ljuk
ujcaol:
	lodsb				; Beolvassuk a karakter
	cmp	al,0			; Nulla ?
	jne	ujcaol			; Nem keresÅnk tov†bb
	pop	ax			; Ez a keresett k¢d
	xchg	ah,al			; Igy van a t†bl†zatban
	cmp	[si],ax 		; Sima gomb ?
	je	simgot			; Igen, nem °runk ki semmit
	cmp	[si + 2],ax		; SHIFT gomb ?
	je	shfgot			; Igen, ki°ratjuk
	cmp	[si + 4],ax		; CNTRL gomb ?
	je	cntgot			; Igen, ki°ratjuk
	cmp	[si + 6],ax		; ALT gomb ?
	je	altgot			; Igen, ki°ratjuk
	xchg	ah,al			; Igy van a t†bl†zatban
	add	si,8			; Itt lesz a kîvetkezî
	cmp	byte ptr [si],0 	; VÇge ?
	jne	befkak			; Nem kîvetkezî azonos°t¢
	ret				; Ha ki°rtam m†r a karaktert
altgot:
	call	altjki			; Ki°runk ALT jelet
	jmp	short simgou		; Ki°rtuk
cntgot:
	call	cntrlj			; Ki°runk CNTRL jelet
	jmp	short simgou		; Ki°rtuk
shfgot:
	call	shfjki			; Ki°runk SHIFT jelet
	jmp	short simgou		; Ki°rtuk
simgot:
	call	spkiir			; Ki°runk sz¢kîzt
simgou:
	jne	bilabe			; Ha nem sikeres
	mov	si,cx			; Itt van az string eleje

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°rat†s null byte-ig.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
nullba:
	push	cx			; Ez lesz a sz†ml†l¢
	mov	dx,si			; MentjÅk az indul†s helyÇt
	mov	cx,0ffffh		; CX <- -1
kiirka:
	inc	cx			; Sz†ml†l¢ nîvelÇs
	lodsb				; Ezt a karakter kell ki°ratni
	or	al,al			; Nulla ?
	je	haskii			; Igen, ki°ratjuk
	cmp	al,0dh			; CR ?
	jne	kiirka			; Nem, ki°rjuk
	jmp	short haskii		; Ki°ratjuk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Egy szinonima ki°rat†s				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
egyszi:
	call	nullba			; Null byte-ig ki°rat†s
	call	tabkii			; Tabul†tor ki°trat†s
	lea	si,[di + 5]		; Ez a szinonima kezdete
	call	nullba			; Null byte-ig ki°rat†s
	call	tabkii			; Tabul†tor ki°trat†s
	call	nullba			; Null byte-ig ki°rat†s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	CR Çs LF ki°rat†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
crlfki:
	push	cx			; Ez lesz a sz†ml†l¢
	mov	dx,offset crlfch	; CRLF c°m tîltÇs
	mov	cx,2			; Ennyi karakter a ki°rand¢
haskii:
	mov	ah,40h			; Ki°rat†s k¢dja
	int	21h			; DOS h°v†s
	cmp	cx,ax			; Annyit °rt ki ?
	pop	cx			; CX vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°ratunk egy sz¢kîz karaktert. 		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
spkiir:
	mov	al,' '                  ; Ezt kell ki°ratni
	jmp	short tabkto		; ètlÇpÅnk a ki°rat†sra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°ratunk '~' karaktert.                        ;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
shfjki:
	mov	al,'~'                  ; Ezt kell ki°ratni
	jmp	short tabkto		; ètlÇpÅnk a ki°rat†sra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°ratunk '\' karaktert.                        ;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
altjki:
	mov	al,'\'                  ; Ezt kell ki°ratni
	jmp	short tabkto		; ètlÇpÅnk a ki°rat†sra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°ratunk '^' karaktert.                        ;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cntrlj:
	mov	al,'^'                  ; Ezt kell ki°ratni
	jmp	short tabkto		; ètlÇpÅnk a ki°rat†sra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°ratunk tabul†tor karaktert.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tabkii:
	mov	al,9			; Ezt kell ki°ratni

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Tabul†tor ki°rat†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
tabkto:
	mov	[tabuch],al		; Ezt kell ki°ratni
	push	cx			; Ez lesz a sz†ml†l¢
	mov	dx,offset tabuch	; TAB c°m tîltÇs
	mov	cx,1			; Ennyi karakter a ki°rand¢
	jmp	short haskii		; Ugyanigy ki°ratjuk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ir†nyv†lt†si problÇma "vissz†"-r¢l "elîre".     ;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
folmor:
	push	si			; Elrontom
	mov	si,offset status	; Ez mehet
	test	[si],nilira		; Elîre kell ?
	je	elomor			; Igen, elîre
	test	byte ptr [si],folmoz	; St†tusz vizsg†lat
	je	nekelp			; Ha nincs ilyen korrekci¢
	and	byte ptr [si],not folmoz; St†tusz tîrlÇs
	mov	si,[bx] 		; Ide mutat most
	mov	si,[si] 		; Ez a kîvetkezî
	or	si,si			; Ez az utols¢ ?
	jne	elpata			; Nem, elpakolhat¢
	mov	si,[bx - 2]		; Ha ez az utols¢, akkor az elsî
elpata:
	mov	[bx],si 		; Az aktu†lis a kîvetkezî
nekelp:
	pop	si			; Rontott regiszter vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ir†nyv†lt†si problÇma "elîrÇ"-rîl "vissza".     ;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
elomor:
	test	byte ptr [si],elomoz	; St†tusz vizsg†lat
	je	nekelp			; Ha nincs ilyen korrekci¢
	and	byte ptr [si],not elomoz; St†tusz tîrlÇs
	mov	ax,[bx] 		; Ide mutat most
	mov	si,[bx - 2]		; Ez az eleje
	cmp	si,ax			; Az elsî elemre mutat ?
	jne	kerkoe			; Nem az elsîre
	xor	ax,ax			; Ha igen, akkor az utols¢ kell
kerkoe:
	cmp	ax,[si] 		; Ez a kîvetkezîre mutat¢ ?
	je	elpata			; Ha ez az utols¢
	mov	si,[si] 		; Kîvetkezî elem elîvÇtel
	jmp	short kerkoe		; Elemvizsg†latra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	ParamÇter vÇge keresÇs. 			;
;							;
;	Input:	[ES:DI] -> a string			;
;							;
;	Output: DI	-> a paramÇter vÇge		;
;		DX	-> a paramÇter kezdete		;
;		CX	-> a paramÇter hossza		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
parveg:
	mov	dx,di			; A kezdetet mentjÅk
kerazo:
	call	szokar			; Sz¢vÇgi karakter ?
	je	idaiga			; Igen, eddig azonos°t¢
	inc	di			; Itt a kîvetkezî karakter
	jmp	short kerazo		; Vissza sz¢vÇg keresÇsre
idaiga:
	mov	cx,dx			; Ez volt az eredeti
	sub	cx,di			; Ennyi a hossza
	neg	cx			; Elîjelv†lt†s
netcum:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	ParamÇter eleje keresÇs.			;
;							;
;	Input:	[ES:DI] -> a string			;
;							;
;	Output: DI	-> a paramÇter vÇge		;
;		DX	-> a paramÇter kezdete		;
;		CX	-> a paramÇter hossza		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
parele:
	mov	dx,di			; A kezdetet mentjÅk
keraze:
	call	szokar			; Sz¢vÇgi karakter ?
	jne	idaiga			; Igen, eddig azonos°t¢
	inc	di			; Itt a kîvetkezî karakter
	jmp	short keraze		; Vissza sz¢vÇg keresÇsre

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Villog¢ st†tusz megv†ltoztat†sa.		;
;							;
;	Input:	AL <- ki°ratand¢ karakter.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vilxor:
	call	vizsst			; Az output kÇpernyî ?
	jne	netcum			; Nem, nem a kÇpernyîre kerÅl
	push	si			; èllit¢lag a 10-es IT. rontja
	push	di			; èllit¢lag a 10-es IT. rontja
	mov	bh,[pagesz]		; Oldalsz†m be†ll°t†s
	mov	ah,8			; St†tusz Çs karakter
	push	ax			; Ebben van a karakter
	int	10h			; Ez a vide¢ IT.
	mov	bl,ah			; Eredeti attributum
	xor	bl,80h			; Hogy ellentÇtes legyen
	pop	ax			; Karakter vissza
	inc	ah			; St†tusz Çs karakter ki°r†s
	mov	cx,1			; Karaktersz†m
	jmp	short befdeu		; 10H IT., stack ÅritÇs Çs vissza

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Az aktu†lis sor ki°rat†s.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
aktkii:
	push	si			; èllit¢lag a 10-es IT. rontja
	push	di			; èllit¢lag a 10-es IT. rontja
	call	kurker			; LekÇrdezzÅk a poz°ci¢t
	jne	megkii			; Nem a kÇpernyîre kerÅl
	push	dx			; Ez a jelenlegi kurzorpoz°ci¢
megkii:
	call	kiitel			; Ki°rjuk az eddigi parancssort
	call	vizsst			; KÇpernyî az output ?
	jne	befakt			; Nem, nem a kÇpernyîre kerÅl
	call	kidosp			; Ki°rat†s
	call	kurker			; LekÇrdezzÅk a poz°ci¢t
	mov	ax,dx			; Ez a jelenlegi poz°ci¢
	pop	dx			; Ez a jelenlegi kurzorpoz°ci¢
	cmp	dh,ah			; Azonos sorok ?
	jne	neviso			; Nem, nem vizsg†ljuk
	cmp	dl,al			; Milyen az oszlopok viszonya ?
	jbe	neviso			; Ha az elîzî kisebb, nem b†ntjuk
	dec	dh			; Ekkor volt scroll, elîzî sorra
neviso:
	mov	ah,2			; Kurzor be†ll°t†s k¢dja
befdeu:
	jmp	short befdev		; Video IT, stack ÅritÇs, vissza

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	INSERT m¢d be†ll°t†sa.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
inselt:
	test	[statul],insjel 	; Kell beolvasni ?
	je	netcum			; Nem, mehetsz vissza
insbea:
	call	vizsst			; KÇpernyî az output ?
	jne	netcum			; Nem, nem a kÇpernyîre kerÅl
	push	si			; èllit¢lag a 10-es IT. rontja
	push	di			; èllit¢lag a 10-es IT. rontja
	mov	cx,0607h		; Alacsony kurzor
	mov	di,offset status	; Ez a st†tusz c°me
	xor	byte ptr [di],insjel	; Besz£r†si m¢d v†lt†s
	test	byte ptr [di],insjel	; Besz£r†si m¢d volt ?
	je	nevobe			; Igen, tîrîljÅk
	mov	ch,2			; Magas kurzor
nevobe:
	mov	ah,1			; Kurzor hosszbe†ll°t†s k¢dja
befdev:
	int	10h			; Ez a vide¢ IT.
befakt:
	clc				; Befejezve
	jmp	short regvis		; Stack ÅritÇs Çs vissza

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Kurzor visszalÇptetÇs rutin.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bcksp1:
	mov	cx,1			; Egy visszalÇpÇs lesz
	jmp	short bckspc		; Innen azonos

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A ki°rt sor tîrlÇse.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sordel:
	call	szuelt			; SzÅk°tÇs kikapcsol†s
sordes:
	call	kiitel			; Ki°rjuk az eddigi parancssort
	xor	cx,cx			; Null†z†s
	mov	[elemci],cx		; Az aktu†lis elemc°m tîrlÇs
	mov	cl,es:[si + 1]		; Ciklussz†m
	jcxz	nevisl			; Ha, nincs tîbb

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Kurzor visszalÇptetÇs CX szerint.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bckspc:
	push	si			; èllit¢lag a 10-es IT. rontja
	push	di			; èllit¢lag a 10-es IT. rontja
	push	bx			; Ezt Çn rontom
	push	dx			; Ezt Çn rontom
loopvi:
	call	kurker			; DX = kurzorpoz°ci¢
	jne	vimedo			; Nem a kÇpernyîre kerÅl
	or	dl,dl			; VisszalÇptethet ?
	jne	vimedo			; Igen, igy visszamehet
	dec	dh			; Elîzî sor
	mov	dl,[oszsza]		; Ez az oszlopsz†m
	dec	dl			; Utols¢ poz°ci¢
	test	[statuh],deljel shr 8	; Kell tîrîlni ?
	jne	cubeam			; Nem, nem is tîrlÅnk
	push	dx			; Ez az a poz°ci¢
	mov	ah,2			; Kurzor be°r†s k¢dja
	int	10h			; Ez a vide¢ IT.
	call	kidosp			; Ki°rat†s
	pop	dx			; Ide kell a kurzor
cubeam:
	mov	ah,2			; Kurzor be°r†s k¢dja
	int	10h			; Ez a vide¢ IT.
	jmp	short elegle		; Ha a sorok kîzîtt is sikerÅlt
vimedo:
	mov	dx,offset egybsp	; Ez egy visszalÇpÇs stringje
	test	[statuh],deljel shr 8	; Kell tîrîlni ?
	je	tokeli			; Igen, nem v†ltoztatunk
	inc	dx			; ètlÇpÇs
	inc	dx			; ètlÇpÇs
tokeli:
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
elegle:
	loop	loopvi			; Tîrlî ciklus
	pop	dx			; A rontott regiszter vissza
	pop	bx			; A rontott regiszter vissza
regvis:
	pop	di			; A rontott regiszter vissza
	pop	si			; A rontott regiszter vissza
nevisl:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Mem¢ria hosszkorrekci¢, fejc°m betîltÇs.	;
;							;
;	Input:	CX <- Az igÇnyelt mem¢riamÇret		;
;							;
;	Output: CX <- A korrig†lt hossz (4-el oszthat¢) ;
;		BX <- Mem¢riafej c°me			;
;							;
;		ZêRO	 <- A hossz nulla (hiba !!!)	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hoskor:
	mov	bx,offset sabpoi	; Ez a mem¢riafej c°me
	add	cx,3			; Ennyivel lehet tîbb
	and	cx,not 3		; Az utols¢ kÇt bit tîrlÇse
	ret				; VisszatÇrÇs


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Mem¢ria kÇrÇs vizsg†lat.			;
;							;
;	Input:	CX <- Az igÇnyelt mem¢riamÇret		;
;							;
;	Output: NEM ZêRO <- Sikeresen teljesithetî	;
;		DI	 <- Mem¢riac°m			;
;		CX	 <- A tÇnyleges hossz		;
;							;
;		ZêRO	 <- A kÇrÇs nem teljesithetî	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
memkes:
	push	bx			; Ez a pointerkeresî
	push	si			; Erre fog mutatni BX
	call	hoskor			; A hossz korrig†l†sa
	jz	ninmem			; Ennyit (0) nem lehet adni
	mov	di,cx			; Ez a tÇnyleges hossz
talmes:
	mov	si,[bx] 		; Ez lesz a kîvetkezî blokk
	or	si,si			; Nulla ?
	je	ninmem			; Igen, nincs blokk
	cmp	[si + 2],cx		; Ebbîl a blokkb¢l adht¢ annyi ?
	jae	sivice			; Igen, kiad†s lesz
	mov	bx,si			; Ez a kîvetkezî blokk
	jmp	short talmes		; Tal†n a kîvetkezîben van

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Mem¢ria kÇrÇs.					;
;							;
;	Input:	CX <- Az igÇnyelt mem¢riamÇret		;
;							;
;	Output: NEM ZêRO <- Sikeres mem¢riafoglal†s	;
;		DI	 <- Mem¢riac°m			;
;		CX	 <- A tÇnyleges hossz		;
;		[DI + 2] <- A tÇnyleges hossz		;
;							;
;		ZêRO	 <- A kÇrÇs nem teljesithetî	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
memker:
	push	bx			; Ez a pointerkeresî
	push	si			; Erre fog mutatni BX
	call	hoskor			; A hossz korrig†l†sa
	jz	ninmem			; Ennyit (0) nem lehet adni
	mov	di,cx			; Ez a tÇnyleges hossz
talmeb:
	mov	si,[bx] 		; Ez lesz a kîvetkezî blokk
	or	si,si			; Nulla ?
	je	ninmem			; Igen, nincs blokk
	cmp	[si + 2],cx		; Ebbîl a blokkb¢l adhat¢ annyi ?
	jae	talmer			; Igen, kiad†s lesz
	mov	bx,si			; Ez a kîvetkezî blokk
	jmp	short talmeb		; Tal†n a kîvetkezîben van
talmer:
	jne	egblne			; Ha nem kell az egÇsz blokk
	mov	cx,[si] 		; Ez a mi blokkunk feje
	mov	[bx],cx 		; Ez az £j fej
sivice:
	mov	cx,si			; Ez a szabad blokk c°me
	jmp	short vitsik		; Sikeres visszatÇrÇsre
egblne:
	sub	[si + 2],cx		; Ennyi fog maradni
	add	[bx],cx 		; Ez a kîvetkezî fej c°me
	mov	bx,[bx] 		; Ez a kîvetkezî fej
	mov	cx,[si] 		; Ez a mi blokkunk feje
	mov	[bx],cx 		; Ez az £j fej
	mov	cx,[si + 2]		; Ennyi fog maradni
	mov	[bx + 2],cx		; Ennyi az £j hely hossza
	mov	[si + 2],di		; HosszkitîltÇs
	jmp	short sivice		; VissztÇrÇs a c°mmel
ninmem:
	xor	cx,cx			; HibajelzÇs
vitsik:
	pop	si			; Regiszter visszatîltÇs
	pop	bx			; Regiszter visszatîltÇs
	xchg	di,cx			; CX-be hossz DI-be c°m
	or	di,di			; St†tuszbe†ll°t†s
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Mem¢ria visszaad†s.				;
;							;
;	Input:	DI	 <- A visszadott mem¢ria c°me	;
;		[DI + 2] <- A visszadott mem¢riamÇret	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
memvis:
	push	bx			; Ez a pointerkeresî
	push	si			; Erre fog mutatni BX
	mov	cx,[di + 2]		; Hossz kitîltÇs
	call	hoskor			; A hossz korrig†l†sa betîltÇssel
	je	hosvis			; 0 hossz£t nem lehet visszaadni
kovtal:
	mov	si,[bx] 		; Ez lesz a kîvetkezî blokk
	or	si,si			; Nulla ?
	je	utblkt			; Igen, nincs blokk
	add	si,[si + 2]		; Ez a blokkvÇg
	jc	onblkk			; Ha Çppen a 64 kbyte vÇge
	cmp	si,di			; Ez a kîvetkezî ?
	je	talnab			; Igen, ez a blokk folytat†sa
	ja	onblkk			; Ide kell kapcsolni
	mov	bx,[bx] 		; Ez lesz a kîvetkezî blokk
	jmp	short kovtal		; Uj blokk vizsg†lat
onblkk:
	mov	si,[bx] 		; Ez lesz a kîvetkezî blokk
	mov	[di],si 		; Ez a kîvetkezî blokk c°me
	mov	[bx],di 		; Az elîzî a blokkra mutat
	mov	si,di			; SI-be a saj†t blokkc°m
	jmp	short addvis		; BlokkîsszegzÇs vizsg†latra
talnab:
	mov	si,[bx] 		; Ez lesz a kîvetkezî blokk
	add	[si + 2],cx		; Ez az £j mÇret
addvis:
	mov	bx,si			; Ez a c°me a blokknak
	add	bx,[si + 2]		; Ez lehetne a kîvetkezî blokkc°m
	jc	hosvis			; Ha utols¢, kÇsz a visszaad†s
	cmp	[si],bx 		; Ez a kîvetkezî c°m ?
	jne	hosvis			; Nem, kÇsz a visszaad†s
	mov	di,[bx] 		; Ez a pointere
	mov	bx,[bx + 2]		; Ez a hossza
	mov	[si],di 		; Ez az £j pointer
	add	[si + 2],bx		; NîvelÇs a hosszal
	jmp	short addvis		; Ez a blokk îsszeadva
utblkt:
	mov	[bx],di 		; Akkor ide mutat
	mov	[di],si 		; Nincs tîbb blokk jelzÇs (0)
hosvis:
	pop	si			; Regiszter visszatîltÇs
	pop	bx			; Regiszter visszatîltÇs
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	St†tusz vizsg†lat.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vizsst:
	test	[statul],stdjel 	; KÇpernyî st†tusz vizsg†lat
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Egy l†nc eltÅntetî.				;
;							;
;	Input:	DI <- a l†nc elsî elemÇnek c°me 	;
;							;
;	Output: DI -> 0 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
eltumo:
	push	[di]			; Ez a kîvetkezî c°me
	call	memvis			; Visszaadtuk
	pop	di			; Ez a kîvetkezî
lancik:
	or	di,di			; Nulla ?
	jne	eltumo			; Adjunk vissza ha mÇg van
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A kurzor a vÇgÇn †ll-e ?			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vegeta:
	cmp	byte ptr es:[di],0	; A vÇgÇn van ?
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stringîsszehasonl°t†s kisbetÅ-nagybetÅ		;
;		   konverzi¢val.			;
;							;
;	Input:	[ES:DI] -> az egyik string		;
;		[DS:SI] -> a m†sik string		;
;		CL	-> a vizsg†land¢ hossz		;
;							;
;	Output: ZERO	 -> azonosak a stringek 	;
;		NEM ZERO -> nem azonosak a stringek	;
;							;
;	Rontott regiszter: AX				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cmpstr:
	mov	ch,0			; Felsî byte null†z†s
cmpmeg:
	mov	ah,es:[di]		; Ez az egyik karakter
	inc	di			; A kîvetkezî karakterre
	lodsb				; Ez a m†sik karakter
	cmp	al,'A'                  ; EnnÇl kisebb ?
	jb	alneko			; Igen, nem nagybetÅ
	cmp	al,'Z'                  ; EnnÇl nagyobb ?
	ja	alneko			; Igen, nem nagybetÅ
	or	al,' '                  ; KisbetÅsitÇs
alneko:
	cmp	ah,'A'                  ; EnnÇl kisebb ?
	jb	ahneko			; Igen, nem nagybetÅ
	cmp	ah,'Z'                  ; EnnÇl nagyobb ?
	ja	ahneko			; Igen, nem nagybetÅ
	or	ah,' '                  ; KisbetÅsitÇs
ahneko:
	cmp	al,ah			; Azonosak ?
	jne	nemazr			; Nem, visszatÇrÇs
	loop	cmpmeg			; CiklusszervezÇs
nemazr:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Hossz vizsg†lat.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
milhos:
	lea	dx,[di - 2]		; Itt van jelenleg - 2
	sub	dx,si			; Ez a kÅlînbîzet
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Karakter beolvas†s †s 0-ra vizsg†lat.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
karbev:
	mov	dl,es:[di]		; Ez a kîvetkezî karakter
	or	dl,dl			; Nulla ?
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sz¢hat†rol¢ karakter keresÇs.			;
;							;
;	Input:	[ES:DI] -> a vizsg†land¢ karakter	;
;							;
;	Output: ZERO	 -> a karakter sz¢hat†rol¢	;
;		NEM ZERO -> a karakter nem sz¢hat†rol¢	;
;							;
;	Rontott regiszter: AL				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
szokar:
	mov	al,es:[di]		; Ez a karekter az
	cmp	al,' '                  ; Ez a hat†rol¢ ?
	je	sohatk			; Igen, ez az
	cmp	al,9			; Ez a hat†rol¢ ?
	je	sohatk			; Igen, ez az
	cmp	al,0dh			; Ez a hat†rol¢ ?
	je	sohatk			; Igen, ez az
	or	al,al			; Sz¢vÇg ?
sohatk:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Ki°rjuk a DL szerinti karaktert.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kidosp:
	mov	dl,' '                  ; Ez a ki°rand¢ oda
kidosc:
	mov	ah,2			; Karakterki°rat†s
	int	21h			; DOS h°v†s
	clc				; Sikeres volt
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	M†sol†s movsb-vel ellentÇtesen. 		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
formas:
	mov	al,es:[di]		; Ez a karakter
	mov	[si],al 		; ètm†sol†s
	cmpsb				; SI <- SI + 1, DI <- DI + 1
	loop	formas			; M†sol†sra
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Kurzor beolvas†s.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kurker:
	call	vizsst			; KÇpernyî az output ?
	jne	nebacu			; Nem, nem a kÇpernyîre kerÅl
	mov	bh,[pagesz]		; Oldalsz†m be†ll°t†s
	push	cx			; Rontja a vide¢ IT.
	mov	ah,3			; Kurzor lekÇrdezÇs k¢dja
	int	10h			; Ez a vide¢ IT.
	pop	cx			; Ciklussz†m vissza
	xor	ah,ah			; Null†z†s
nebacu:
	ret				; VisszatÇrÇs

ohvege:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	êrvÇnyes gombok t†bl†zata.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pkodta	label	byte
	db	'tab',0                 ; TABULèTOR
	dw	0,0,148,165		; -, SHIFT, CNTRL, ALT

	db	'esc',0                 ; ESCAPE
	dw	0,0,0,1 		; -, SHIFT, CNTRL, ALT

	db	'bckspc',0              ; BACKSPACE
	dw	0,0,0,14		; -, SHIFT, CNTRL, ALT

	db	'enter',0               ; ENTER
	dw	0,0,2560,28		; -, SHIFT, CNTRL, ALT

	db	'left',0                ; LEFT
	dw	0,0,0,155		; -, SHIFT, CNTRL, ALT

	db	'right',0               ; RIGHT
	dw	0,0,0,157		; -, SHIFT, CNTRL, ALT

	db	'up',0                  ; UP
	dw	0,0,141,152		; -, SHIFT, CNTRL, ALT

	db	'down',0                ; DOWN
	dw	0,0,145,160		; -, SHIFT, CNTRL, ALT

	db	'home',0                ; HOME
	dw	0,0,119,151		; -, SHIFT, CNTRL, ALT

	db	'end',0                 ; END
	dw	0,0,0,159		; -, SHIFT, CNTRL, ALT

	db	'pgup',0                ; PAGE UP
	dw	73,0,132,153		; -, SHIFT, CNTRL, ALT

	db	'pgdn',0                ; PAGE DOWN
	dw	81,0,118,161		; -, SHIFT, CNTRL, ALT

	db	'ins',0                 ; INS
	dw	0,0,146,162		; -, SHIFT, CNTRL, ALT

	db	'del',0                 ; DEL
	dw	0,0,147,163		; -, SHIFT, CNTRL, ALT

	db	'minus',0               ; SZöRKE -
	dw	0,0,142,74		; -, SHIFT, CNTRL, ALT

	db	'plus',0                ; SZöRKE +
	dw	0,0,144,78		; -, SHIFT, CNTRL, ALT

	db	'star',0                ; SZöRKE *
	dw	0,0,150,55		; -, SHIFT, CNTRL, ALT

	db	'slash',0               ; SZöRKE /
	dw	0,0,149,164		; -, SHIFT, CNTRL, ALT

	db	'center',0              ; CENTER (5)
	dw	76,0,143,0		; -, SHIFT, CNTRL, ALT

	db	'f1',0                  ; FUNKCIO GOMB
	dw	59,84,94,104		; -, SHIFT, CNTRL, ALT

	db	'f2',0                  ; FUNKCIO GOMB
	dw	60,85,95,105		; -, SHIFT, CNTRL, ALT

	db	'f3',0                  ; FUNKCIO GOMB
	dw	61,86,96,106		; -, SHIFT, CNTRL, ALT

	db	'f4',0                  ; FUNKCIO GOMB
	dw	62,87,97,107		; -, SHIFT, CNTRL, ALT

	db	'f5',0                  ; FUNKCIO GOMB
	dw	63,88,98,108		; -, SHIFT, CNTRL, ALT

	db	'f6',0                  ; FUNKCIO GOMB
	dw	64,89,99,109		; -, SHIFT, CNTRL, ALT

	db	'f7',0                  ; FUNKCIO GOMB
	dw	65,90,100,110		; -, SHIFT, CNTRL, ALT

	db	'f8',0                  ; FUNKCIO GOMB
	dw	66,91,101,111		; -, SHIFT, CNTRL, ALT

	db	'f9',0                  ; FUNKCIO GOMB
	dw	67,92,102,112		; -, SHIFT, CNTRL, ALT

	db	'f10',0                 ; FUNKCIO GOMB
	dw	68,93,103,113		; -, SHIFT, CNTRL, ALT

	db	'f11',0                 ; FUNKCIO GOMB
	dw	133,135,137,139 	; -, SHIFT, CNTRL, ALT

	db	'f12',0                 ; FUNKCIO GOMB
	dw	134,136,138,140 	; -, SHIFT, CNTRL, ALT

	db	'1',0                   ; '1' KARAKTER
	dw	0,0,0,120		; -, SHIFT, CNTRL, ALT

	db	'2',0                   ; '2' KARAKTER
	dw	0,0,0,121		; -, SHIFT, CNTRL, ALT

	db	'3',0                   ; '3' KARAKTER
	dw	0,0,0,122		; -, SHIFT, CNTRL, ALT

	db	'4',0                   ; '4' KARAKTER
	dw	0,0,0,123		; -, SHIFT, CNTRL, ALT

	db	'5',0                   ; '5' KARAKTER
	dw	0,0,0,124		; -, SHIFT, CNTRL, ALT

	db	'6',0                   ; '6' KARAKTER
	dw	0,0,0,125		; -, SHIFT, CNTRL, ALT

	db	'7',0                   ; '7' KARAKTER
	dw	0,0,0,126		; -, SHIFT, CNTRL, ALT

	db	'8',0                   ; '8' KARAKTER
	dw	0,0,0,127		; -, SHIFT, CNTRL, ALT

	db	'9',0                   ; '9' KARAKTER
	dw	0,0,0,128		; -, SHIFT, CNTRL, ALT

	db	'0',0                   ; '0' KARAKTER
	dw	0,0,0,129		; -, SHIFT, CNTRL, ALT

	db	'-',0                   ; '-' KARAKTER
	dw	0,0,0,130		; -, SHIFT, CNTRL, ALT

	db	'=',0                   ; '=' KARAKTER
	dw	0,0,0,131		; -, SHIFT, CNTRL, ALT

	db	0

stelsz	db	24			; Stack elemsz†m maximuma
crlfch	db	0dh,0ah 		; Ez a CRLF karakter ki°rat†shoz
tabuch	db	9			; Ez a TAB  karakter ki°rat†shoz
parmih	db	2			; Az ennÇl hosszabb stack-be
pagesz	db	?			; Lapsz†m helye
oszsza	db	?			; Oszlopsz†m helye
egybsp	db	8,' ',8,'$'             ; Egyet visszalÇp
synres	db	'syn',0                 ; Szinonima megad†s stringje
fixres	db	'fix',0                 ; Fix parancs megad†s stringje
comres	db	'command',0             ; Parancsad†s stringje
linres	db	'line',0                ; Parancsfelaj†nl†s stringje


scanta	db	03h			; @ scan k¢d
	db	1eh			; A scan k¢d
	db	30h			; B scan k¢d
	db	2eh			; C scan k¢d
	db	20h			; D scan k¢d
	db	12h			; E scan k¢d
	db	21h			; F scan k¢d
	db	22h			; G scan k¢d
	db	23h			; H scan k¢d
	db	17h			; I scan k¢d
	db	24h			; J scan k¢d
	db	25h			; K scan k¢d
	db	26h			; L scan k¢d
	db	32h			; M scan k¢d
	db	31h			; N scan k¢d
	db	18h			; O scan k¢d
	db	19h			; P scan k¢d
	db	10h			; Q scan k¢d
	db	13h			; R scan k¢d
	db	1fh			; S scan k¢d
	db	14h			; T scan k¢d
	db	16h			; U scan k¢d
	db	2fh			; V scan k¢d
	db	11h			; W scan k¢d
	db	2dh			; X scan k¢d
	db	15h			; Y scan k¢d
	db	2ch			; Z scan k¢d
	db	1ah			; [ scan k¢d
	db	2bh			; \ scan k¢d
	db	1bh			; ] scan k¢d
	db	07h			; ^ scan k¢d
	db	0ch			; _ scan k¢d

	even

gomtab	label	word			; A gombok eleje

syatch	label	word			; SYN, FIX v†lt†s
	db	0,45			; \X
	dw	syatve			; Rutinc°m

liadch	label	word			; Sorhozz†ad¢ karakter
	db	0,30			; \A
	dw	liadve			; Rutinc°m

coadch	label	word			; Parancshozz†ad¢ karakter
	db	0,33			; \F
	dw	coadve			; Rutinc°m

stroch	label	word			; Stack-rot†l¢ karakter
	db	0,19			; \R
	dw	strove			; Rutinc°m

edcoch	label	word			; Ez a sorkilist†z¢ karakter
	db	0,18			; \E
	dw	edcove			; Rutinc°m

liatli	label	word			; Ez a sorkilist†z¢ karakter
	db	0,38			; \L
	dw	liatvg			; Rutinc°m

coatli	label	word			; Ez a sorkilist†z¢ karakter
	db	0,46			; \C
	dw	coatvg			; Rutinc°m

synlch	label	word			; Ez a szinonima list†z¢ karakter
	db	0,20			; \T
	dw	synlve			; Rutinc°m

stdelc	label	word			; Ez a stack tîrlî karakter
	db	0,132			; ^PG UP
	dw	stdeve			; Rutinc°m

lindel	label	word			; Ez a stack sor tîrlî karakter
	db	0,118			; ^PG DN
	dw	lindve			; Rutinc°m

stackl	label	word			; Ez a stack kilist†z¢ karakter
	db	0,31			; \S
	dw	stacve			; Rutinc°m

vijach	label	word			; Visszajavit¢ karakter
	db	10,0			; ^ENTER
	dw	vijave			; Rutinc°m

havach	label	word
	db	0,23h			; \H karakter
	dw	hajelv			; Rutinc°m

	db	8,0			; BACKSPACE
	dw	bcksve			; Rutinc°m

	db	9,0			; TABULèTOR
	dw	szoeve			; Rutinc°m

	db	0,74h			; CONTROL JOBBRA ny°l
	dw	szoeve			; Rutinc°m

	db	0dh,0			; ENTER
	dw	enteve			; Rutinc°m

	db	0,75h			; CONTROL END
	dw	coenve			; Rutinc°m

	db	0,48h			; FôL ny°l
	dw	fonive			; Rutinc°m

	db	0,50h			; LE ny°l
	dw	lenive			; Rutinc°m

	db	0,53h			; DEL
	dw	delcve			; Rutinc°m

	db	0,52h			; INS
	dw	insbea			; Rutinc°m

	db	0,4bh			; BALRA ny°l
	dw	balnve			; Rutinc°m

	db	0,4dh			; JOBBRA ny°l
	dw	jobnve			; Rutinc°m

	db	0,47h			; HOME
	dw	homeve			; Rutinc°m

	db	0,4fh			; END
	dw	kiitel			; Rutinc°m

	db	0,0fh			; SHIFT TAB
	dw	conive			; Rutinc°m

	db	0,73h			; CONTROL BALRA ny°l
	dw	conive			; Rutinc°m

	dw	0			; T†bl†zat lez†r¢

stujci	dw	0			; Ez az elîh°vott elem pointere
elemci	dw	0			; Ez az aktu†lis elem c°me

syntab	label	word
	dw	0			; Szinonimat†bl†zat feje
	dw	0			; Parancst†bl†zat feje
	dw	0			; Felaj†nl†st†bl†zat feje

parpoi	label	word
	dw	0			; ParamÇterl†nc feje
	dw	0			; êrtelmezÇsi hat†r
	dw	0			; Hibak¢d t†rol¢
	dw	0			; SzÅk°tî c°me
	dw	0			; Ez a r†m mutat¢

stackc	label	word
	dw	0			; Itt van a command stack feje
	dw	0			; A command stack aktu†lis eleme
	dw	0			; Itt van a kîzîs stack feje
	dw	0			; A kîzîs stack aktu†lis eleme

	if	($ - start) and 3

comstp	dw	0			; Stackszegmens t†rol¢

	else

comstp	dw	0,0ffffh		; Stackszegmens t†rol¢

	endif

rescim:

emsver	db	?			; EMS verzi¢

comeds	db	'COMED',0               ; Szegmens tulajdonos szîveg

comedh	db	'COMED'                 ; EMS handle tulajdonos szîveg
	hndnum				; Verzi¢ a handle-hoz

filspe	db	'comed.cfg',0           ; AlapÇrtelmezett file-nÇv

staspe	db	'comed.stk',0           ; AlapÇrtelmezett file-nÇv

nevcim	db	64 + 3 + 13 dup (0)	; Itt az adott specifik†ci¢

kialat	db	64 + 3 + 13 dup (0)	; Itt jîn îssza az egÇsz

emmszo	db	'EMMXXXX0',0            ; EMS neve

tablci	label	near
	db	'syn',0                 ; Szinonima megad†s stringje
	dw	synrut			; Ezt a rutint h°vja meg
	db	'fix',0                 ; Fix parancs megad†s stringje
	dw	fixrut			; Ezt a rutint h°vja meg
	db	'command',0             ; Parancsad†s stringje
	dw	comrut			; Ezt a rutint h°vja meg
	db	'line',0                ; Parancsfelaj†nl†s stringje
	dw	linrut			; Ezt a rutint h°vja meg
syncho	db	'synlch',0              ; Szinonima-list†z¢ karakter
	dw	sylrut			; Ezt a rutint h°vja meg
stliof	db	'stlich',0              ; Stack list†z¢ karakter
	dw	stcrut			; Ezt a rutint h°vja meg
liliof	db	'lilich',0              ; Sorlist†z¢ karakter
	dw	licrut			; Ezt a rutint h°vja meg
coliof	db	'colich',0              ; Parancslist†z¢ karakter
	dw	cocrut			; Ezt a rutint h°vja meg
edcoof	db	'edcoch',0              ; Command szerekesztî karakter
	dw	edchru			; Ezt a rutint h°vja meg
stroof	db	'stroch',0              ; Stack rot†l¢ karakter
	dw	stroru			; Ezt a rutint h°vja meg
liadof	db	'liadch',0              ; Sor kiegÇszitî karakter
	dw	liadru			; Ezt a rutint h°vja meg
coadof	db	'coadch',0              ; Parancs kiegÇszitî karakter
	dw	coadru			; Ezt a rutint h°vja meg
stdeof	db	'stdelc',0              ; Stack tîrlî karakter
	dw	stdelr			; Ezt a rutint h°vja meg
lideof	db	'lindel',0              ; Stack sor tîrlî karakter
	dw	lindec			; Ezt a rutint h°vja meg
javcoc	db	'vijach',0              ; Javit¢ karakter
	dw	vijaru			; Ezt a rutint h°vja meg
syatoc	db	'syatch',0              ; SYM, FIX v†lt¢ karakter
	dw	syatru			; Ezt a rutint h°vja meg
havatc	db	'havach',0              ; Hangv†lt¢ karakter
	dw	havaru			; Ezt a rutint h°vja meg

	db	0			; Ez az utols¢

memhos	dw	1024			; AlapÇrtelmezÇsi hossza
blkmas	dw	1000h			; Ez a blokk mÇrete

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancssor Çrtelmezî.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
parert:
	call	kapert			; Kapcsol¢k ÇrtelmezÇse
	je	kavute			; Ha nincs baj
	ret				; Baj van, visszatÇrÇs
kavute:
	pop	di			; Ez a vissztÇrÇsi c°m
	mov	ax,cs			; Ez lesz a stack-szegmens
	mov	sp,offset sajsta	; Ez a saj†t stack pointer
	push	di			; VisszatÇrÇsi c°m
	push	es			; ES kell kÇsîbb, mentem
	mov	dx,es:[status]		; St†tusz mentÇs
	mov	es,ax			; ES tîltÇs CS-el
	mov	di,offset kialat	; Itt a m†solat helye
	push	ds			; DS kell kÇsîbb, mentem
	mov	ds,cs:[2ch]		; Itt az environment szegmense
	xor	si,si			; Kezdete 0
ujbeol:
	lodsb				; Ez az a byte
	or	al,al			; Nulla ?
	jne	ujbeol			; Nem, m†s
	lodsb				; Ez a kîvetkezî
	or	al,al			; Nulla ?
	jne	ujbeol			; Nem, m†s
	lodsw				; Egy sz¢ †tugr†s
	test	es:[status],srijel OR ltojel; 'SR' vagy 'SW' kapcsol¢ ?
	jne	nemelo			; Igen, elîtag nem kell
	call	copynu			; M†sol†s null byte-ig
	mov	di,bx			; Itt folytathatja
nemelo:
	pop	ds			; Ez m†r nem az environment
	test	dx,spejel		; Volt specifik†ci¢ ?
	je	nispej			; Nincs, nem m†soljuk be
	mov	di,offset kialat	; Itt a helye
	mov	si,offset nevcim	; Innen pakoljuk
	call	copynu			; M†sol†s null byte-ig
	cmp	bx,di			; Azonosak ?
	jne	taline			; Nem, van nÇv is
	jmp	short mebesp		; Ha nincs nÇv
nispej:
	mov	si,offset nevcim	; Innen pakoljuk ha van
	cmp	byte ptr [si],0 	; Nulla ?
	jne	ezlema			; Nem, ezt m†soljuk
mebesp:
	mov	si,offset filspe	; Innen pakoljuk
	test	es:[status],srijel OR ltojel; 'SR' vagy 'SW' kapcsol¢ ?
	je	ezlema			; Nics ilyen kapcsol¢
	mov	si,offset staspe	; Innen pakoljuk
ezlema:
	call	copynu			; M†sol†s null byte-ig
taline:
	mov	si,di			; M†solat
	mov	cx,4			; Ennyi helyet vizsg†lunk
kelmer:
	dec	si			; Ez az elîzî
	mov	ah,[si] 		; Ez a karakter
	cmp	ah,'.'                  ; KiterjesztÇs van ?
	je	nekipo			; Ha kîzben kiterjesztÇs van
	cmp	ah,':'                  ; Kîzben eszkîzjel van ?
	je	kiteoc			; Ha kîzben eszkîzjel van
	cmp	ah,'\'                  ; Kîzben direktoryjel van ?
	je	kiteoc			; Ha kîzben direktoryjel van
	loop	kelmer			; Ciklusban vizsg†ljuk
kiteoc:
	test	es:[status],srijel OR ltojel;'SW' vagy 'SR' kapcsol¢ ?
	jne	skapta			; Ha van
	mov	[di],'c.'               ; '.c' karakterek kipakol†sa
	mov	[di + 2],'gf'           ; 'fg' karakterek kipakol†sa
	mov	byte ptr [di + 4],0	; Nulla kipakol†s
	jmp	short nekipe
skapta:
	mov	[di],'s.'               ; '.s' karakterek kipakol†sa
	mov	[di + 2],'kt'           ; 'tk' karakterek kipakol†sa
nekipe:
	mov	byte ptr [di + 4],0	; Nulla kipakol†s
nekipo:
	mov	dx,offset kialat	; Itt a helye
	pop	es			; ES vissza
	push	es			; Kell mÇg a stack-ben
	test	es:[status],wrijel OR srijel; 'W' vagy 'S' kapcsol¢ van ?
	je	newris			; Nem, vizsg†ljunk tov†bb
	test	es:[status],comext	; Rezidens a COMED ?
	jne	recowr			; Igen, nyissunk
newris:
	jmp	newrif			; Vizsg†ljunk tov†bb
recowr:
	mov	ah,5bh			; Nyit†s k¢dja
opisme:
	xor	cx,cx			; Attrib£tum
	int	21h			; DOS h°v†s
	jnc	smegop			; Ha sikeresen nyitott
	cmp	ax,50h			; Ez a hiba volt ?
	jne	nemops			; Igen, nem lÇtezett
kerdis:
	push	dx			; A nÇv mentÇse
	mov	dx,offset leteh1	; Ez a szîveg
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	si			; NÇv vissza
	push	si			; NÇv mentÇs
	mov	bx,1			; Ez a file-sz†m (STDOUT !!!)
	call	nullba			; Null byte-ig ki°rat†s
	mov	dx,offset leteh2	; Ez a szîveg
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	mov	ah,1			; Olvas†s k¢dja
	int	21h			; DOS h°v†s
	push	ax			; V†lasz mentÇs
	mov	bx,1			; Ez az STDOUT file-sz†m
	call	crlfki			; Ez CRLF ki°rat†s
	pop	ax			; V†lasz vissza
	mov	ah,3ch			; FelÅl°r¢s megnyit†s
	or	al,' '                  ; Igy kisbetÅ lett
	pop	dx			; NÇv vissza
	cmp	al,yesjai		; FelÅl kell °rni ?
	je	opisme			; Igen, °rjuk
	cmp	al,'n'                  ; Nem °rjuk felÅl ?
	jne	kerdis			; Ha hib†s a v†lasz
nemops:
	push	dx			; A nÇv mentÇse
	mov	dx,offset openh1	; Ez a szîveg
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	si			; NÇv vissza
	mov	bx,1			; Ez a file-sz†m (STDOUT !!!)
	call	nullba			; Null byte-ig ki°rat†s
	mov	dx,offset openh2	; Ez a szîveg
	mov	ah,9			; Stringki°rat†s k¢dja
	jmp	bakiir			; Folytassuk
smegop:
	pop	ds			; DS-be az ÇrvÇnyes paragrafus
	push	ds			; VisszamentjÅk
	mov	bx,ax			; Ez a file-sz†m
	test	es:[status],wrijel	; 'W' kapcsol¢ van ?
	jne	wkapva			; Igen, az
	jmp	ninwri			; Nincs, akkor 'S' lehet
wkapva:
	mov	ax,offset synveg	; Ide jîjjîn vissza
	push	ax			; Stack tîltÇs
	push	bx			; Stack tîltÇs
	mov	ch,0			; Ezzel lehet îsszehasonl°tani
	jmp	szikif			; 'SYN' Çs 'FIX' ki°rat†sra
synveg:
	jne	bajkis			; Ha elfogyott a hely
	mov	cx,offset syntab + 4	; Ez a fej c°me
	mov	dx,offset linres	; Ez a szîveg c°me
	call	kiliso			; Kilist†zzuk a szimb¢lumokat
	jne	bajkis			; Ha elfogyott a hely
	mov	cx,offset syntab + 2	; Ez a fej c°me
	mov	dx,offset comres	; Ez a szîveg c°me
	call	kiliso			; Kilist†zzuk a szimb¢lumokat
	jne	bajkis			; Ha elfogyott a hely
	call	crlfki			; Ki°runk CRLF-et
	jne	bajkis			; Ha elfogyott a hely
	mov	si,offset syncho	; Ez a karakterstring
	mov	ax,[synlch]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
bajkis:
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset stliof	; Ez a karakterstring
	mov	ax,[stackl]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset coliof	; Ez a karakterstring
	mov	ax,[coatli]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset liliof	; Ez a karakterstring
	mov	ax,[liatli]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset edcoof	; Ez a karakterstring
	mov	ax,[edcoch]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset stroof	; Ez a karakterstring
	mov	ax,[stroch]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset liadof	; Ez a karakterstring
	mov	ax,[liadch]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset coadof	; Ez a karakterstring
	mov	ax,[coadch]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset stdeof	; Ez a karakterstring
	mov	ax,[stdelc]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset lideof	; Ez a karakterstring
	mov	ax,[lindel]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset syatoc	; Ez a karakterstring
	mov	ax,[syatch]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	jne	bajkii			; Ha elfogyott a hely
	mov	si,offset havatc	; Ez a karakterstring
	mov	ax,[havach]		; Ez a karakter
	call	kiirca			; Ki°rjuk ezt
	je	cloout			; Ha sikeres a ki°r†s
bajkii:
	push	cs			; Itt a szÅksÇges paragrafus
	pop	ds			; Ez a szîveg miatt kell
	mov	dx,offset helyhi	; Szîvegc°m
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	jmp	short cloout		; Lez†rjuk az outputot
ninwri:
	mov	di,offset stackc	; Itt a stack pointere
	mov	bp,di			; M†solat
kircir:
	mov	di,[di] 		; Ez a kîvetkezî elem
	or	di,di			; Ez £jra a fej ?
	je	netokr			; Nincs £j elem list†z†s
	lea	si,[di + 5]		; Ez a ki°ratand¢
	call	nullba			; Ki°ratjuk az elem tartalm†t
kociki:
	call	crlfki			; Uj sor karakterek ki°r†sa
	jmp	short kircir		; Ha hib†s a ki°rat†s
netokr:
	add	bp,4			; Itt a stack kîvetketî pointere
	mov	di,bp			; M†solat
	cmp	di,offset stackc + 4	; Ez a kîvetkezî
	je	kociki			; Ha van mÇg mit °rni
newrif:
	test	es:[status],comext	; Rezidens a COMED ?
	je	norolv			; Nem, mindenkÇp elolvassuk
	test	es:[status],filjel or ltojel; 'F' vagy 'SR' kapcsol¢ ?
	je	nemerf			; Nem, nem ÇrtelmezzÅnk file-t
norolv:
	mov	ax,3d00h		; Open k¢dja olvas†skor
	test	es:[status],wrijel OR srijel; 'W' vagy 'SW' kapcsol¢ ?
	je	nefiln			; Nem volt, mehet
	mov	dx,offset helpsz	; Szîvegc°m
	inc	ax			; St†tusz be†ll°t†s
	pop	ax			; Stack År°tÇs
	ret				; VisszatÇrÇs
nefiln:
	int	21h			; DOS h°v†s
	jc	nemsin			; Ha nem sikeres a nyit†s
	pop	ds			; DS-be az ÇrvÇnyes paragrafus
	push	ds			; VisszamentjÅk
	push	cs			; Ez legyen az ES-be
	pop	es			; Ez a t†bl†zat paragrafusa
	call	syntor			; Szinonimat†bl†zat tîrlÇs
	mov	bx,ax			; File-sz†m vissza
	test	es:[status],ltojel	; 'SR' kapcsol¢ ?
	jne	maskaf			; Igen, °gy teszÅnk
	call	filert			; File-beolvas†s
	jmp	short cloout		; BefejeztÅk
maskaf:
	call	filers			; File-beolvas†s
cloout:
	mov	ah,3eh			; Close k¢dja
bakiir:
	int	21h			; DOS h°v†s
nemerf:
	pop	ax			; ES ÇrtÇke
	push	ds			; El fog romlani
	mov	ds,ax			; DS <- ES
	mov	es,ax			; ES <- ES
	jmp	short vistes		; Folytassuk tov†bb
nemsin:
	push	dx			; A nÇv mentÇse
	mov	dx,offset openh1	; Ez a szîveg
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	si			; NÇv vissza
	mov	bx,1			; Ez a file-sz†m (STDOUT !!!)
	call	nullba			; Null byte-ig ki°rat†s
	mov	dx,offset openh2	; Ez a szîveg
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ax			; ES ÇrtÇke
	mov	ds,ax			; DS <- ES
	mov	es,ax			; ES <- ES
	call	syntor			; Szinonimat†bl†zat tîrlÇs
	push	es			; Ez legyen a DS
vistes:
	pop	ds			; Szegmens vissza
	xor	al,al			; St†tusz be†ll°t†s
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	M†sol†s null byte-ig.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
copynu:
	mov	bx,di			; Itt volt utolj†ra
envcik:
	lodsb				; Karakter beolvas†s
	or	al,al			; Nulla ?
	je	vissza			; Igen, befejezve
	stosb				; Kivitel
	cmp	al,'\'                  ; Direktoryjel ?
	je	copynu			; Elpakoljuk a c°mÇt
	cmp	al,':'                  ; Eszkîzjel ?
	je	copynu			; Elpakoljuk a c°mÇt
	jmp	short envcik		; VisszalÇpÇs m†sol†sra
vissza:
	mov	es:[di],al		; Hat†rol¢ karakter
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A mem¢ria statisztika ki°r†sa.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
memsta:
	test	es:[status],unijel	; Le†ll°tjuk ?
	jne	vibede			; Igen, nincs statisztika
	push	ds			; Ez a rezidens paragrafus
	push	cs			; Hogy legyen mit ki°rni
	pop	ds			; Ez a szîveg paragrafusa
	xor	cx,cx			; Nulla az alaphossz
	xor	si,si			; Ez a darabsz†m
	mov	di,es:[sabpoi]		; Ez a szabdok feje
vitala:
	or	di,di			; Van itt mem¢ria ?
	je	nintof			; Nincs tîbb, befejezve
	inc	si			; Darabsz†m nîvelÇs egyel
	add	cx,es:[di + 2]		; Ennyi byte-os a blokk
	mov	di,es:[di]		; Ez a kîvetkezî c°m
	jmp	short vitala		; Vissza a mem¢risz†mol†sra
nintof:
	push	si			; Darabsz†m
	push	cx			; MÇret
	push	bp			; Foglalt mÇret
	mov	dx,offset memme1	; Mem¢riamÇret szîvege 1. darab
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ax			; Ennyi byte foglalt
	call	bindek			; A dek¢dolt AX ki°rat†sa
	mov	dx,offset memme2	; Mem¢riamÇret szîvege 2. darab
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ax			; Ez a dek¢doland¢ mÇret
	call	bindek			; A dek¢dolt AX ki°rat†sa
	mov	dx,offset memme3	; Mem¢riamÇret szîvege 2. darab
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	mov	dx,offset memme5	; Mem¢riamÇret szîvege 4. darab
	pop	ax			; Ez a dek¢doland¢ darab
	or	ax,ax			; Nulla ?
	je	neirnu			; Igen, nem azt °rjuk ki
	call	bindek			; A dek¢dolt AX ki°rat†sa
	mov	dx,offset memme4	; Mem¢riamÇret szîvege 3. darab
neirnu:
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ds			; Szegmens vissza
vibede:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	AX ki°rat†sa dec°m†lisan.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bindek:
	mov	bx,10			; Ez lesz az oszt¢
	xor	dx,dx			; Igy kÇtszavas
	push	dx			; ElmentÇs
ujosva:
	mov	dl,0			; Igy kÇtszavas
	div	bx			; Ez lesz a soron kîvetkezî jegy
	or	dl,'0'                  ; KarakteresitÇs
	push	dx			; ElmentÇs
	or	ax,ax			; Nulla a maradÇk ?
	jne	ujosva			; Nem, £jra elosztjuk
vikkir:
	pop	dx			; Ez a kîvetkezî karakter
	or	dl,dl			; Nulla a karakter
	je	vibede			; Igen visszatÇrÅnk
	call	kidosc			; Ki°rat†s
	jmp	short vikkir		; Tov†bbi ki°rat†sra

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	ètpakoljuk ES-bîl DS-be.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
atpako:
	push	si			; Ez a fej c°me
	push	cx			; Ez a maradÇk darab
	mov	si,di			; Ez a forr†s c°me
	mov	bx,di			; Ez a forr†s c°me
ujgema:
	mov	si,[si] 		; Ez a kîvetkezî c°me
	or	si,si			; Nulla ?
	je	befsam			; Igen, befejezve
	mov	di,es:[di]		; Ez a kîvetkezîre mutat¢
	mov	cx,[si + 2]		; Ennyi hossz£ a m†solat
	mov	es:[di],di		; Ez a kîvetkezîre fog mutatni
	add	es:[di],cx		; Ez a kîvetkezîre mutat
	push	di			; A cÇl c°mÇt mentjÅk
	push	si			; A forr†s c°mÇt mentjÅk
	lodsw				; ètlÇpjÅk a fej c°mÇt
	scasw				; A cÇl is ki van tîtve
	shr	cx,1			; Igy lehet szavas mozgat†s
	dec	cx			; A pointert nem m†soljuk
	rep	movsw			; ètm†soljuk
	pop	si			; A forr†s c°me vissza
	pop	di			; A cÇl c°me vissza
	jmp	short ujgema		; Vissza a kîvetkezît m†solni
befsam:
	mov	es:[di],si		; A mi l†ncunknak is vÇge
	mov	di,[bx] 		; Visszaadand¢ l†ncc°m
	call	lancik			; Visszaadjuk a mem¢rial†ncot
	pop	cx			; Darabsz†m vissza
	pop	si			; Az eredeti vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	MegcserÇlî.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
csepak:
	push	ds			; Ez lesz a cÇl
	push	es			; Ez lesz a forr†s
	pop	ds			; DS <- ES
	pop	es			; ES <- DS
	mov	di,[parpoi]		; Az az eltÅntetendî
	call	lancik			; EltÅntetjÅk ezt a l†ncot
	mov	[parpoi],di		; A paramÇterek c°me 0
	mov	[parpoi + 2],di 	; A folytat†s is 0
	mov	si,offset syntab	; Szinonima elem c°me
	mov	cx,3			; Ennyi fej van
kofepa:
	mov	di,si			; Ez a fej a visszaadand¢
	call	atpako			; Idepakoljuk
	lodsw				; NîvelÇs 2-vel
	loop	kofepa			; Foglal¢ ciklus
	mov	di,offset stackc	; Itt kezdîdik a command stack
	call	atpako			; Idepakoljuk
	mov	di,offset stackc + 4	; Itt kezdîdik a kîzîs stack
	jmp	atpako			; Idepakoljuk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Hossz birizg†l¢.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
hoorda:
	mov	si,offset syntab	; Szinonima elem c°me
	mov	cx,3			; Ennyi fej van
kofevi:
	mov	di,si			; Ez a fej a visszaadand¢
	call	foghos			; Mennyit foglalt eddig
	je	nemsiv			; Nem sikerÅlt
	lodsw				; NîvelÇs 2-vel
	loop	kofevi			; Foglal¢ ciklus
	mov	di,offset stackc	; Itt kezdîdik a command stack
	call	foghos			; Mennyit foglalt eddig
	je	nemsiv			; Sikertelen foglal†s volt
	mov	di,offset stackc + 4	; Itt kezdîdik a kîzîs stack
	call	foghos			; Mennyit foglalt eddig
nemsiv:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Tîmîritî ford°tott ir†nyban.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gerbaf:
	xor	bp,bp			; Ennyi a foglalt eddig
	push	cs			; Ez a saj†t paragrafusom
	push	es			; Ez lesz a forr†s
	push	cs			; Ez nem a mienk
	pop	es			; BetîltjÅk
	call	hoorda			; Hossz keresÇs
	je	nemsif			; Ha baj van
	call	csepak			; ètpakol¢ ciklus
	pop	es			; Eredeti
	pop	ds			; Az eredeti vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Tîmîritî.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gerbag:
	push	ds			; Ez nem biztos, hogy a mienk
	push	cs			; Ez lesz a saj†t paragrafusom
	pop	ds			; BetîltjÅk
	call	hoorda			; Hossz keresÇs
	jne	jolsif			; Sikeres foglal†s volt
nemsif:
	pop	ds			; Az eredeti vissza
	ret				; VisszatÇrÇs
jolsif:
	push	ds			; Ez lesz a cÇl
	push	es			; Ez lesz a forr†s
	call	csepak			; ètpakol¢ ciklus
	mov	dx,cs:[blkmas]		; Blokkhossz beolvas†s
	xor	ax,ax			; Null†z†s
	mov	cl,3			; LelÇpÇs sz†ma
	mov	[parpoi + 2],ax 	; Nincs folytat†s
	mov	di,offset sabpoi	; Ez a szabad terÅlet feje
	mov	si,offset rescim	; Itt a vÇge, ha nincs
	mov	bx,si			; M†solat
	cmp	[di],ax 		; Nulla ?
	je	ezamac			; Igen, nincs mem¢ria
	cmp	si,[di] 		; Ez az elsî pointer ?
	jne	hibnet			; Ha nem a j¢ helyre mutat
vsamem:
	cmp	[si],ax 		; Nulla a tov†bbmutat¢ ?
	jne	hibnet			; Ha nem a j¢ helyre mutat
	add	si,[si + 2]		; Itt a vÇge
ezamac:
	rcr	si,1			; LelÇpÇs 1. f†zis (CARRY !)
	shr	si,cl			; LelÇpÇs pargrafusssz†mnak
	cmp	si,dx			; A teljes rezidens a foglalt ?
	je	metony			; Igen, menjen tov†bb
hibnet:
	mov	[di],ax 		; Nincs szabad mutat¢
	inc	cl			; FellÇptetÇsi sz†m m†r nÇgy
	shl	dx,cl			; Igy c°m lett
	sub	dx,bx			; A maradÇk a hossz
	je	nepaho			; Ha nulla, igy hagyjuk
	mov	[di],bx 		; Ez a szabad mutat¢
	mov	[bx],ax 		; Ez kîvetkezî mutat¢
	mov	[bx + 2],dx		; Most m†r helyes
nepaho:
	push	ds			; MentjÅk a ki°rat†shoz
	push	cs			; Ez szîveg paragrafusa
	pop	ds			; Hogy az °r¢djon ki
	mov	dx,offset memhib	; Szîvegc°m
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ds			; DS vissza
metony:
	xor	bp,bp			; Ennyi a foglalt eddig
	call	hoorda			; Hossz keresÇs
bizifk:
	pop	es			; Az eredeti vissza
	pop	ds			; Az eredeti vissza
	mov	si,offset syntab	; Szinonima elem c°me
	mov	cx,3			; Ennyi fej van
kofeap:
	mov	di,si			; Ez a fej a visszaadand¢
	call	atpako			; Idepakoljuk
	lodsw				; NîvelÇs 2-vel
	loop	kofeap			; Foglal¢ ciklus
	mov	si,offset stackc	; Itt kezdîdik a command stack
	mov	di,si			; Ez a stack feje
	call	atpako			; Idepakoljuk
	db	26h			; ES elîtag
	lodsw				; Az £j c°m AX-be
	mov	es:[si],ax		; Ez lesz az aktu†lis is
	mov	si,offset stackc + 4	; Itt kezdîdik a kîzîs stack
	mov	di,si			; Ez a stack feje
	call	atpako			; Idepakoljuk
	db	26h			; ES elîtag
	lodsw				; Az £j c°m AX-be
	mov	es:[si],ax		; Ez lesz az aktu†lis is
	pop	ds			; Az eredeti vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Foglal†si hossz sz†mit¢.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
foghos:
	push	cx			; Ez kell m†snak
	xor	cx,cx			; A kezdeti hossz nulla
	mov	bx,di			; Ez az eredeti c°m
tovake:
	mov	di,es:[di]		; Ez a kîvetkezî pointer
	or	di,di			; Nulla ?
	je	befesa			; Ha nulla, vÇge
	add	cx,es:[di + 2]		; Ennyi a puffer
	jmp	short tovake		; Vissza a l†nc kîvetkezî elemÇre
befesa:
	add	bp,cx			; KiegÇszitjÅk
	jcxz	nekefg			; Igen, nem kell foglalni
	call	memker			; Ennyit lefoglalunk
	je	nemvom			; Nem sikerÅlt
nekefg:
	mov	[bx],di 		; Ez a c°m
	inc	di			; St†tusz be†ll°t†s
nemvom:
	pop	cx			; Regiszter vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Foglal†si hossz sz†mit¢.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kemeci:
	add	bx,es:[di + 2]		; Ennyi a puffer
hoviza:
	mov	di,es:[di]		; Ez a kîvetkezî pointer
	or	di,di			; Nulla ?
	jne	kemeci			; Ha nem nulla van adat
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	File Çrtelmezî. 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiirca:
	push	ax			; Ez a billentyÅk¢d
	push	ds			; Ezt megv†ltoztatjuk
	push	cs			; Itt lesznek az adatok
	pop	ds			; Hogy ki°rhat¢ legyen
	call	nullba			; Ki°rjuk a szîveget
	pop	ds			; Vissza a szegmens
	pop	ax			; BillentyÅk¢d vissza
	jne	nestih			; Ha sikertelen az °r†s
	push	ax			; Ez a billentyÅk¢d
	call	tabkii			; Tabul†tor ki°rat†s
	pop	ax			; BillentyÅk¢d vissza
	jne	nestih			; Ha sikertelen az °r†s
	call	bilazo			; BillentyÅ azonos°t¢ rutin
	jne	nestih			; Ha sikertelen az °r†s
	call	crlfki			; CRLF kitÇtel
nestih:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	File Çrtelmezî. 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filers:
	mov	cx,256			; Ez a maximum hossz
	call	memker			; Mem¢ri†t kÇrÅnk
	je	nestih			; Ha nincs mem¢ria
	mov	si,offset stackc	; Itt van stack eleje
koelem:
	push	si			; Ez a c°m az
	mov	cl,[stelsz]		; Ennyi darab
	mov	ch,0			; H byte null†z†s
kevere:
	cmp	word ptr [si],0 	; Ez kîvtekezî elem ?
	je	visuje			; Nem, utols¢
	mov	si,[si] 		; A kîvetkezî elem c°me
	dec	cl			; Elemsz†m csîkkenÇs
	jmp	short kevere		; Haladunk a l†ncon
visuje:
	push	cx			; El ne romoljon
	mov	dx,di			; Ez a c°m ahova olvashat
	call	sorbeo			; Egy sor beolvas†s
	pop	cx			; Vissza
	je	filevs			; Ha file-vÇg jel volt
	sub	ax,di			; öres sor ?
	je	visujk			; Igen, kîvetkezî stack
ertelm:
	cmp	byte ptr [di],';'       ; MegjegyzÇs ?
	je	visuje			; Igen, vissza beolvas†sra
	jcxz	elsvia			; Ha nincs az elemnek helye
	dec	cx			; Egyel kevesebb
	push	cx			; El ne romoljon
elevia:
	call	sorvis			; MegnÇzzÅk mi van a sorban
	pop	cx			; Vissza
	jmp	short visuje		; Uj sor beolvas†s†s†ra
elsvia:
	pop	bp			; Ez a stack feje
	push	bp			; Ez a stack feje
	push	cx			; Elromlana
	push	di			; Elromlana
	push	si			; Elromlana
	mov	si,bp			; Ez a stack feje
	mov	di,[si] 		; Ez az elsî elem c°me
	push	[di]			; Ez a kîvetkezî pointere
	pop	[si]			; Ez a kîvetkezî pointere
	cmp	di,[si + 2]		; Az aktu†lis is r† mutat ?
	jne	csevsa			; Nem, az nem
	push	[di]			; Ez a kîvetkezî pointere
	pop	[si + 2]		; Ez is megv†ltozik
csevsa:
	call	memvis			; Visszaadjuk
	pop	si			; Vissza az aktu†lis pointer
	pop	di			; Vissza a puffer pointere
	jmp	short elevia		; Ez elem visszaadva
visujk:
	pop	si			; A stackc°m vissza
	lodsw				; SI <- SI + 2
	lodsw				; SI <- SI + 2
	cmp	si,offset stackc + 4	; Ez a kîvetkezî ?
	je	koelem			; Igen, mehet
	jmp	short fileve		; Eddig ÇrtelmeztÅk
filevs:
	pop	si			; Stack År°tÇs
	jmp	short fileve		; Eddig ÇrtelmeztÅk

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	File Çrtelmezî. 				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
filert:
	mov	cx,256			; Ez a maximum hossz
	call	memker			; Mem¢ri†t kÇrÅnk
	je	befert			; Ha nincs mem¢ria
	mov	bp,di			; Hogy DI felszabaduljon
visujs:
	mov	dx,di			; Ez a c°m ahova olvashat
	call	sorbeo			; Egy sor beolvas†s
	je	fileve			; Ha file-vÇg jel volt
	cmp	ax,di			; öres sor ?
	je	visujs			; Igen, vissza beolvas†sra
	cmp	byte ptr [di],';'       ; MegjegyzÇs ?
	je	visujs			; Igen, vissza beolvas†sra
	call	sorviz			; MegnÇzzÅk mi van a sorban
	jmp	short visujs		; Uj sor beolvas†s†s†ra
fileve:
	mov	word ptr [di + 2],256	; Ez a hossz
	call	memvis			; Visszaadjuk a mem¢ri†t
befert:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Egy stacksor vizsg†lata.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sorvis:
	push	di			; DI elromlik
	mov	cx,ax			; Ez a hossz
	push	cx			; Darab mentÇs
	add	cx,4 + 1 + 1		; Fej + sz†ml†l¢ + vÇgkarakter
	call	memker			; Mem¢ri†t kÇrÅnk
	pop	cx			; Darab vissza
	je	stoshi			; Ha nincs annyi
	mov	[si],di 		; R†m mutasson
	mov	si,di			; Ez a tov†bbi pointer
	mov	word ptr [di],0 	; VÇgpointer
	scasw				; DI <- DI + 2
	scasw				; DI <- DI + 2
	mov	[di],cl 		; Hossz
	inc	di			; A hossz †tlÇpÇse
	pop	ax			; Innen °rjuk ki
	push	ax			; Vissza a stack-re
	push	si			; SI nem romolhat
	mov	si,ax			; Ez a kezdîc°m
atstak:
	lodsb				; Byte beolvas†s
	mov	[di],al 		; Kipakol†s
	inc	di			; Kîvetkezî karakterre
	loop	atstak			; M†sol†si hurok
	mov	byte ptr [di],0dh	; VÇgkarakter
	jmp	short csvire		; BefejeztÅk
stoshi:
	pop	ax			; Innen °rjuk ki
	push	ax			; Vissza a stack-re
	push	si			; SI nem romolhat
	mov	si,ax			; Ez a kezdîc°m
	push	bx			; File-sz†m mentÇs
	mov	bx,1			; Ez a file-sz†m (STDOUT !!!)
	call	crlfki			; Ki°runk CRLF-et
	call	nullba			; Null byte-ig ki°rat†s
	call	crlfki			; Ki°runk CRLF-et
	pop	bx			; File-sz†m vissza
csvire:
	pop	si			; SI vissza
	pop	di			; DI vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Egy sor vizsg†lata.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sorviz:
	mov	si,di			; Itt kezdîdik a sor
	push	dx			; DX lesz a nîvekmÇny
	push	di			; DI lesz a t†bl†zat c°m
	mov	di,offset tablci	; Ez a t†bl†zat c°me
	mov	dx,3			; Ennyi a nîvekmÇny
	call	strazo			; String keresÇs
	je	strhik			; Nem tal†ltunk stringet
	call	cs:[di + 1]		; Van string, ez a rutinja
	jne	nirjak			; Ha nincs benne hiba
strhik:
	pop	si			; Innen °rjuk ki
	push	si			; Vissza a stack-re
	push	bx			; File-sz†m mentÇs
	mov	bx,1			; Ez a file-sz†m (STDOUT !!!)
	call	crlfki			; Ki°runk CRLF-et
	call	nullba			; Null byte-ig ki°rat†s
	call	crlfki			; Ki°runk CRLF-et
	pop	bx			; File-sz†m vissza
nirjak:
	pop	di			; DI-be vissza a kezdîc°m
	pop	dx			; DX-be vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stringkeresî rutin.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
strazo:
	call	kiskar			; Karakter beolvas†s
	je	nisemm			; Igen, befejeztÅk
	cmp	al,' '                  ; Ez sz¢kîz ?
	je	strazo			; Igen, †tlÇpjÅk
	cmp	al,9			; Ez tabul†tor ?
	je	strazo			; Igen, †tlÇpjÅk
	dec	si			; Vissza az elejÇre
synohk:
	push	si			; A kezdetet elmentjÅk
kartal:
	call	kiskar			; Karakter beolvas†s
	je	urstvi			; VÇge, sikertelen azonosit†s
	xor	al,cs:[di]		; Azonos ?
	jne	ujrale			; Nem, kîvetkezîre lÇpÇs
	inc	di			; Ez lesz a kîvetkezî
	cmp	cs:[di],al		; VÇge az azonosit†snak ?
	jne	kartal			; Uj îsszehasonl°t†s
	jmp	short azoveg		; Igen, vÇge
ujrale:
	inc	di			; Ez lesz a kîvetkezî
	cmp	cs:[di],dh		; VÇge az azonos°t¢nak ?
	jne	ujrale			; Nem, kîvetkezîre lÇpÇs
ujelem:
	pop	si			; Ujra az elejÇre †llunk
	add	di,dx			; Ez lesz a kîvetkezî eleje
	cmp	cs:[di],dh		; VÇge az îsszes azonos°t¢nak ?
	jne	synohk			; Nem, £j îsszehasonl°t†s
	ret				; Nem tal†ltunk, visszatÇrÇs
azoveg:
	call	kiskar			; Beolvas†s
	je	urstpa			; Nem tal†ltunk, visszatÇrÇs
	cmp	al,' '                  ; Ez sz¢kîz ?
	je	talazo			; Igen, †tlÇpjÅk
	cmp	al,9			; Ez tabul†tor ?
	jne	ujelem			; Nem, £j elemzÇs lesz
talazo:
	call	kiskar			; Beolvas†s
	je	urstpa			; Nem tal†ltunk, visszatÇrÇs
	cmp	al,' '                  ; Ez sz¢kîz ?
	je	talazo			; Igen, †tlÇpjÅk
	cmp	al,9			; Ez tabul†tor ?
	je	talazo			; Igen, †tlÇpjÅk
urstpa:
	dec	si			; Vissza az elejÇre
urstvi:
	pop	dx			; Eleje vissza
nisemm:
	ret				; Nem tal†ltunk, visszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	HangjelzÇs v†lt†s karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
havaru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset havach	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sor kiegÇszitî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
syatru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset syatch	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sor kiegÇszitî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vijaru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset vijach	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sor kiegÇszitî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
liadru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset liadch	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancs kiegÇszitî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
coadru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset coadch	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stack rot†l¢ karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stroru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset stroch	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Command list†z¢ karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
edchru:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset edcoch	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Felaj†nl†s list†z¢ karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lindec:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset lindel	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancs list†z¢ karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stdelr:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset stdelc	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stacklista kÇrî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
stcrut:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset lindel	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Sorlista kÇrî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
licrut:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset liatli	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancslista kÇrî karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cocrut:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset coatli	; Ezt kell vizsg†lni
	jmp	short karmev		; A karakter vizsg†lata

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szinonima list†z¢ karakter m¢dosit†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sylrut:
	push	bx			; ElmentjÅk a c°met
	mov	bx,offset synlch	; Ezt kell vizsg†lni
karmev:
	call	bevcam			; A karakter meg†llapit†sa
	je	bester			; BefejeztÅk
	mov	[bx],ax 		; M¢dosit†s
bester:
	pop	bx			; C°mregiszter vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	A vezÇrlî karakter beolvas†sa.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bevcam:
	push	bx			; Ez lesz az index
	mov	bx,7			; Az ALT indexe
	call	kiskar			; Beolvas†s
	je	nemstc			; BefejeztÅk
	cmp	al,'\'                  ; ALT JELZô ?
	je	igazta			; Igen, mehet a keresÇs
	mov	bl,5			; A CNTRL indexe
	cmp	al,'^'                  ; CNTRL JELZô ?
	je	igazta			; Igen, mehet a keresÇs
	mov	bl,3			; A SHIFT indexe
	cmp	al,'~'                  ; SHIFT JELZô ?
	je	igazta			; Igen, mehet a keresÇs
	mov	bl,1			; A norm†l
	dec	si			; Vissza, merty ez nem az
igazta:
	mov	al,[si] 		; Ez a karakter lesz a kîvetkezî
	cmp	al,' '                  ; Sz¢kîz ?
	je	nemstc			; Igen, hib†s a sor
	cmp	al,9			; Tabul†tor ?
	je	nemstc			; Igen, hib†s a sor
	mov	al,[si + 1]		; Ez a karakter tal†n hat†rol¢
	or	al,al			; Nulla ?
	je	talhat			; Igen, hat†rol¢
	cmp	al,' '                  ; Hat†rol¢ ?
	je	talhat			; Igen, hat†rol¢
	cmp	al,9			; Hat†rol¢ ?
	je	talhat			; Igen, hat†rol¢
kerpko:
	mov	di,offset pkodta	; Ez a t†bl†zat c°me
	mov	dx,9			; Ennyi a nîvekmÇny
	call	strazo			; String keresÇs
	je	nemstc			; Ha nem tal†l stringet
	mov	ax,cs:[di + bx] 	; Ez az aktu†lis k¢d
	or	ax,ax			; êrvÇnyes k¢d ?
nemstc:
	xchg	al,ah			; CserÇvel ÇrvÇnyes
cntrlg:
	pop	bx			; Index vissza
	ret				; VisszatÇrÇs
talhat:
	mov	al,[si] 		; Beolvas†s
	mov	ah,0			; Ez a felsî byte
	cmp	bl,1			; Sima karakter ?
	je	nemstc			; Igen, ilyen nem lehet
	cmp	bl,3			; SHIFT karakter ?
	je	nemstc			; Igen, ilyen sem lehet
	cmp	al,'a'                  ; EnnÇl kisebb ?
	jb	kerpko			; Igen, ez nem lehet
	inc	si			; ètlÇpjÅk
	push	ax			; A kakrektert elmentjÅk
kekato:
	call	kiskar			; Beolvas†s
	je	ivavet			; BefejeztÅk
	cmp	al,' '                  ; Sz¢kîz ?
	je	kekato			; Igen, olvassuk a kîvetkezît
	cmp	al,9			; Tabul†tor ?
	je	kekato			; Igen, olvassuk a kîvetkezît
ivavet:
	dec	si			; VisszalÇpÅnk
	pop	ax			; A karakter vissza
	and	al,' ' - 1              ; Igy csak az alja marad
	cmp	bl,7			; CNTRL karakter ?
	jne	cntrlg			; Ha CNTRL
	mov	bx,offset scanta	; Ez a t†bl†zat eleje
	add	bx,ax			; Ez az offszet rajta
	mov	al,es:[bx]		; Beolvassuk a scan k¢dot
	jmp	short nemstc		; VisszatÇrhetÅnk


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Direkt parancs kiÇrtÇkelî.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
comrut:
	push	bx			; ElmentÇs
	mov	bx,offset syntab + 2	; Ez a feje a list†nak
	jmp	short azolic		; Innen azonos a rutin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Parancsfelaj†nl†s kiÇrtÇkelî.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
linrut:
	push	bx			; ElmentÇs
	mov	bx,offset syntab + 4	; Ez a feje a list†nak
azolic:
	push	es			; ElmentjÅk a saj†t paragrafust
	call	bevcam			; A karakter meg†llapit†sa
	je	nemtak			; Ha nem tal†l rendes azonos°t¢t
	push	ds			; Ez a rezidens szegmensrÇsz
	pop	es			; Ez a rezidens szegmensrÇsz
	push	ax			; Ez a karakter
	call	strlen			; Hossz vizsg†lat
	pop	ax			; Ez a karakter az aktu†lis
	jcxz	nemtak			; Ha nem tal†l stringet
	add	cx,4 + 2 + 1		; Fej + karakter + vÇg
	call	memker			; Mem¢ri†t kÇrÅnk
	je	nemtak			; Ha nincs mem¢ria
	push	di			; A fej c°mÇt elmentjÅk
	add	di,4			; Ez az eleje
	stosw				; Ez a karakter kipakol†s
	sub	cx,6			; Ennyivel kevesebbet
	rep	movsb			; Bem†soljuk a stringet
	pop	di			; Fejc°m vissza
kercfe:
	mov	si,[bx] 		; Ez a kîvetkezî pointer
	or	si,si			; Nulla ?
	je	talvef			; Igen, ez az utols¢
	cmp	ax,[si + 4]		; Ez lesz a kîvetkezî ?
	je	pontil			; Nem, pont ez az, m¢dositjuk
	jb	talvef			; Igen, ide felkapcsol¢dunk
	mov	bx,[bx] 		; Ez a kîvetkezî
	jmp	short kercfe		; Vissza az elejÇre
talvef:
	mov	[bx],di 		; Ez r†m mutasson
	mov	[di],si 		; ên mutatok tov†bb
	jmp	short utolpu		; VisszatÇrÅnk
pontil:
	mov	[bx],di 		; Ez lesz a kîvetkezî
	mov	ax,[si] 		; Ez a kîvetkezîre mutat
	mov	[di],ax 		; Ide mutat a saj†t is
	mov	di,si			; Ezt adjuk vissza
	call	memvis			; Visszaadjuk az elîzît
utolpu:
	or	bx,bx			; St†tusz
nemtak:
	pop	es			; Ez a saj†t szegmens
	pop	bx			; Regiszter vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Fix parancs kiÇrtÇkelî. 			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fixrut:
	push	dx			; ElmentÇs
	mov	dh,0ffh 		; Ez a fix konstansa
	jmp	short szinkf		; Folytassuk innen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szinonima kiÇrtÇkelî.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
synrut:
	push	dx			; ElmentÇs
	mov	dh,7fh			; Ez a szinonima konstansa
szinkf:
	push	bx			; ElmentÇs
	push	es			; ElmentjÅk a saj†t paragrafust
	push	ds			; Ez a rezidens szegmensrÇsz
	pop	es			; Ez a rezidens szegmensrÇsz
	call	strlen			; Hossz vizsg†lat
	jcxz	parhon			; Ha nulla a hossz
	add	cx,4 + 1 + 1		; + egyebek
	call	memker			; Mem¢ri†t kÇrÅnk
	je	parhon			; Ha nincs
	mov	bx,di			; ElmentjÅk a kezdîc°met
	add	di,5			; Itt lesz az azonos°t¢
matosy:
	inc	ch			; Sz†ml†l¢ nîvelÇs
	call	kiskar			; Beolvas†s
	stosb				; Kipakol†s
	jne	motosy			; Ha nincs vÇge
	add	ch,dh			; Egyel tîbbet mutat
	mov	[bx + 4],ch		; Ez a hossz
tahave:
	call	kerlah			; KeressÅk, hogy van-e ?
	mov	ax,0ffffh		; HibajelzÇshez
	jnc	igvisa			; Ha nincs, hiba van
	mov	di,[si] 		; Ez a mostani mutat¢ja
	mov	ax,[di] 		; Ide mutat tov†bb a tîrlendî
	mov	[si],ax 		; Most m†r †tlÇpi
	call	memvis			; Mem¢ria visszaad†s
igvisa:
	mov	di,bx			; Mem¢ria kezdîc°m
	call	memvis			; Mem¢ria visszaad†s
	inc	ax			; Hogy ne legyen nulla
	jmp	short parhon		; BefejeztÅk
motosy:
	cmp	al,' '                  ; Ez sz¢kîz ?
	je	talhts			; Igen, hat†rol¢
	cmp	al,9			; Ez tabul†tor ?
	jne	matosy			; Nem, m†solunk tov†bb
talhts:
	xor	[di - 1],al		; Null†zzuk
	add	ch,dh			; Egyel tîbbet mutat
	mov	[bx + 4],ch		; Ez a hossz
talelk:
	call	kiskar			; Beolvas†s
	je	tahave			; Nincs tîbb, befejeztÅk
	cmp	al,' '                  ; Ez sz¢kîz ?
	je	talelk			; Igen, †tlÇpjÅk
	cmp	al,9			; Ez tabul†tor ?
	je	talelk			; Igen, †tlÇpjÅk
	dec	si			; Vissza az elejÇre
mavema:
	call	kiskar			; Beolvas†s
	stosb				; Kipakol†s
	jne	mavema			; Ha van mÇg a stringbîl
	call	kerlah			; KeressÅk, hogy van-e ?
	jc	poilta			; Ha ilyen van, javitunk
	je	utolso			; Ez a hely az utols¢ lesz
	mov	di,[si] 		; Ez a kîvetkezî c°me
	mov	[bx],di 		; R†mutatunk a kîvetkezîre
	jmp	short lafelc		; Felcsatoljuk a miÇnket
poilta:
	mov	di,[si] 		; Ez a mostani c°me
	mov	ax,[di] 		; Ide mutat tov†bb az elîzî
	mov	[bx],ax 		; Most m†r az £j is
	call	memvis			; Mem¢ria visszaad†s
	jmp	short lafelc		; Felcsatoljuk a miÇnket
utolso:
	mov	[bx],di 		; Nulla kipakol†sa
lafelc:
	mov	[si],bx 		; Ez a l†nc utols¢ eleme
	or	bx,bx			; Igy jelzem, hogy sikeres
parhon:
	pop	es			; Ez a saj†t szegmens
	pop	bx			; Regiszter vissza
	pop	dx			; Regiszter vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szinonimal†ncon keresÇs.			;
;							;
;	Input:	BX -> a kiÇrtÇkelendî string		;
;							;
;	Output: CARRY	 -> Ilyen Çppen van		;
;		SI	 -> Az azonosra mutat¢ c°me	;
;							;
;		NINCS CARRY:				;
;							;
;		ZêRO -> utols¢ legyen a l†ncon		;
;		DI   -> 0				;
;		SI   -> Az jelenlegi utols¢ c°me	;
;							;
;		NEM ZêRO -> Nem az utols¢ a l†ncon	;
;		SI	 -> A stringet megelîzî c°me	;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kerlah:
	mov	si,offset syntab	; Szinonima elem c°me
kerhel:
	mov	di,[si] 		; Ez a kîvetkezî
	or	di,di			; Nulla ?
	je	felfuv			; Igen, a hely az utols¢ lesz
	mov	al,[bx + 4]		; Ez az egyik hossza
	xor	al,[di + 4]		; Csak a felsî bit miatt
	js	lameto			; Ha nem azonos tipus, tov†bb
	push	bx			; Kezdîc°m mentÇs
	add	bx,4			; Itt az eleje
	scasw				; DI <- DI + 2
	scasw				; DI <- DI + 2
ohtova:
	inc	bx			; NîvelÇs a kîvetkezîre
	inc	di			; NîvelÇs a kîvetkezîre
	mov	al,[bx] 		; Ez az egyik
	mov	ah,[di] 		; Ez a m†sik
	or	ax,ax			; Pont ilyen van ?
	je	poilva			; Igen, az elîzît visszaadjuk
	cmp	ah,al			; Azonosak ?
	je	ohtova			; Igen, kîvetkezî vizsg†latra
	pop	bx			; Ez a kezdîc°m
	jae	felfuv			; Ide kell felfÅzni (JNC)
lameto:
	mov	si,[si] 		; Ez az eleje
	jmp	short kerhel		; Vissza az elejÇre
poilva:
	pop	bx			; Ez a kezdîc°m
	stc				; Van ilyen jelzÇs
felfuv:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Karakterbeolvas†s Çs †talak°t†s.		;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiskar:
	lodsb				; Karakter beolvas†s
	cmp	al,'A'                  ; EnnÇl kisebb ?
	jb	mehkic			; Igen, nem †talak°tand¢
	cmp	al,'Z'                  ; EnnÇl nagyobb ?
	ja	mehkic			; Igen, nem †talak°tand¢
	or	al,' '                  ; ètalak°t†s kisbetÅre
mehkic:
	or	al,al			; Nulla ?
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Egy sor beolvas†sa.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sorbeo:
	push	si			; El ne romoljon
sorbek:
	mov	cx,1			; Ennyit olvasson be
	mov	si,dx			; Ide olvas be
	sub	dx,di			; Ennyi a kÅlînbsÇg
	cmp	dx,256			; Van ennyi a kÅlînbsÇg ?
	je	befolv			; Igen, vÇge a sornak
	mov	dx,si			; Ide olvas be
	mov	ah,3fh			; Olvas†s k¢dja
	int	21h			; DOS h°v†s
	or	ax,ax			; Sikeresen beolvasta ?
	je	beffiv			; Nem, vÇge a file-nak
	lodsb				; Ezt olvasta be
	or	al,al			; Nulla ?
	je	sorbek			; Igen, £j karakter beolvas†s
	cmp	al,0ah			; LF-volt ?
	je	sorbek			; Igen, £j karakter beolvas†s
	inc	dx			; A kîvetkezî helyre olvasson
	cmp	al,0dh			; CR-volt ?
	je	befolv			; Igen, befejezve a sor
	xor	al,1ah			; File-vÇg ?
	jne	sorbek			; Nem, £j karakter beolvas†s
befolv:
	dec	si			; VisszalÇpÅnk
beffiv:
	mov	[si],ah 		; Nulla kipakol†s
	or	al,al			; St†tusz be†ll°t†s
	mov	ax,si			; AX <- a vÇge
	pop	si			; SI vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	LekÇpzÇs vissza†ll°t¢.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lekvis:
	push	dx			; Elmentem, mert romlik
	mov	dx,cs:[rehndl]		; Ez a file-sz†m
	cmp	dx,0ffffh		; Nem ÇrvÇnyes ?
	je	necsil			; Igen, nem z†runk
	mov	ah,48h			; Restore k¢dja
	int	67h			; EMS h°v†s
necsil:
	pop	dx			; VisszatîltÇs
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Szinonima tîrlî.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
syntor:
	test	[status],synini 	; Inicializ†l¢ kapcsol¢ ?
	je	nekein			; Nincs be†ll°tva
	and	[status],not synini	; Inicializ†l¢ kapcsol¢ kikapcs.
	push	cx			; Ez lesz a sz†ml†l¢ ezÇrt mentem
	push	si			; Ez lesz a c°m ezÇrt mentem
	push	di			; Ez lesz a pointer ezÇrt mentem
	mov	di,[syntab]		; A szinonim†k feje
	call	lancik			; Visszaadjuk a mem¢rial†ncot
	mov	[syntab],di		; A szinonim†k feje
	mov	di,[syntab + 4] 	; A sorok feje
	call	lancik			; Visszaadjuk a mem¢rial†ncot
	mov	[syntab + 4],di 	; A sorok feje
	mov	di,[syntab + 2] 	; A parancsok feje
	call	lancik			; Visszaadjuk a mem¢rial†ncot
	mov	[syntab + 2],di 	; A parancsok feje
	pop	di			; Pointer-regiszter vissza
	pop	si			; C°m-regiszter vissza
	pop	cx			; Sz†ml†l¢-regiszter vissza
nekein:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Stringhossz meg†llapit†s.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
strlen:
	push	si			; ElmentjÅk a kezdetet
	mov	cx,0ffffh		; Null†z†s - 1
strvkr:
	inc	cx			; Stringhossz nîvelÇs
	lodsb				; Karakter beolvas†s
	or	al,al			; Nulla ?
	jne	strvkr			; Vissza a keresÇsre
	pop	si			; Kezdet vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Le†ll°t†s pr¢ba.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
lealpr:
	push	ds			; Elrontjuk
	mov	ax,cs			; AX <- CS
	mov	ds,ax			; DS <- CS
	or	es:[status],ressto	; Le†ll°tjuk
	mov	ax,[rehndl]		; Ez a file-sz†m
	inc	ax			; êrvÇnyes ? (FFFF volt ?)
	je	renems			; Igen, akkor nem is EMS-ben van
	mov	es,[emsseg]		; Ez a DOS rezidens pargagrafusa
	xor	ax,ax			; Null†z†s
	mov	bx,es			; Ez a paragrafus
	mov	es,ax			; Ez az IT. t†bla
	cmp	es:[21h * 4],offset emssta; Ide mutat mÇg ?
	jne	stakir			; Nem, ez m†s
	cmp	bx,es:[(21h * 4) + 2]	; Ide mutat mÇg ?
	jmp	short stakir		; St†tuszvizsg†lat
renems:
	mov	ah,4dh			; K¢dkÇrÇs k¢dja
	int	21h			; DOS h°v†s
	cmp	word ptr es:[0f1h],0	; Tulajdonos tîrîlve ?
stakir:
	je	martot			; M†r tîrîlve, nem °runk ki
	mov	dx,offset megres	; Szîvegc°m
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
martot:
	pop	ds			; Vissza
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Kapcsol¢ beolvas¢-Çrtelmezî.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kapert:
	mov	ax,80h			; Ez a sor hossza
	mov	si,ax			; Ez a c°m beolvas†s
	lodsb				; Hossz betîltÇs
	and	al,7fh			; Elîjel kikapcsol†s
	mov	cx,ax			; Igy most ciklussz†ml†l¢
	or	cx,cx			; St†tusz be†ll°t†s
	jne	beolca			; Ha beolvashatott
	jmp	alaper			; Ha befuccsolt
beolca:
	lodsb				; Karakter beolvas†s
	cmp	al,' '                  ; Sz¢kîz ?
	je	elegbs			; Igen, nem ÇrvÇnyes a karakter
	cmp	al,9			; Tabul†tor ?
	jne	talneo			; Nem, keressÅk tov†bb
elegbs:
	jmp	elegbe			; Igen, nem ÇrvÇnyes a karakter
talneo:
	cmp	al,'?'                  ; Help kÇrÇs ?
	je	talhel			; Igen, ez az
	cmp	al,'/'                  ; Kapcsol¢jel ?
	je	talper			; Igen, ez az
	cmp	al,'-'                  ; Kapcsol¢jel ?
	je	talper			; Igen, ez az
elegrs:
	jmp	elegro			; Nem, ez hiba
talper:
	dec	cx			; Olvasni kell
	jcxz	elegrs			; Ha befuccsolt
	lodsb				; Karakter beolvas†s
	cmp	al,'?'                  ; Help kÇrÇs ?
talhel:
	mov	dx,offset helpsz	; Szîvegc°m
	jne	nehels			; Nem help
	or	es:[status],helpje	; St†tusz be†ll°t†s
	ret				; VisszatÇrÅnk
nehels:
	or	al,' '                  ; KisbetÅsitÇs
	cmp	al,'h'                  ; High c°mekre ?
	jne	nehira			; Nem, nem kell magasba
	or	es:[status],hiloje	; St†tusz be†ll°t†s
	jmp	short elegbm		; Karakter beolvas†sra
nehira:
	cmp	al,'e'                  ; EMS-be ?
	jne	nemems			; Nem, nem kell EMS-be tenni
	or	es:[status],emsmje	; St†tusz be†ll°t†s
	jmp	short elegbm		; Karakter beolvas†sra
nemems:
	cmp	al,'n'                  ; Hossz m¢dosit†s ?
	jne	nehomo			; Nem, nem a minim†lis hossz
	call	conbeo			; Konstans beolvas†s
	mov	es:[parmih],dl		; Ezt olvasta be
	jcxz	salape			; Ha befuccsolt
	jmp	short elegbm		; Karakter beolvas†sra
nehomo:
	cmp	al,'i'                  ; Szinonima inicializ†l†s ?
	jne	nemsii			; Nem, m†s lesz
	or	es:[status],synini	; Inicializ†l¢ kapcsol¢
	jmp	short elegbm		; Karakter beolvas†sra
nemsii:
	cmp	al,'u'                  ; Uninstall kÇrÇs ?
	jne	nemilk			; Nem ez a kapcsol¢
	or	es:[status],unijel	; Le†ll°tjuk (ha a miÇnk !)
	jmp	short elegbm		; Karakter beolvas†sra
nemilk:
	cmp	al,'m'                  ; Mem¢riamÇret be†ll°t†s ?
	jne	filnel			; Nem, m†s kapcsol¢
	call	conbeo			; Konstans beolvas†s
	mov	cs:[memhos],dx		; Ezt olvasta be
salape:
	jcxz	salapm			; Ha befuccsolt
elegbm:
	jmp	elegbe			; Karakter beolvas†sra
filnel:
	cmp	al,'l'                  ; Stack-elemsz†m ?
	jne	ezneml			; Nem, m†s kapcsol¢
	call	conbeo			; Konstans beolvas†s
	mov	al,24			; Ennyi sor az alapÇrtelmezÇs
	or	dx,dx			; Nulla ?
	je	korrel			; Igen, korrekci¢
	cmp	dx,99			; Ez a maximum
	ja	korrel			; Ha kell korrig†lni
	mov	al,dl			; Ennyi van a parancsban
korrel:
	mov	es:[stelsz],al		; Elemsz†m kitÇtel
salapm:
	jcxz	alaper			; Ha befuccsolt
	jmp	short elegbe		; Karakter beolvas†sra
ezneml:
	cmp	al,'w'                  ; File-specifik†ci¢ °r†sra ?
	jne	nemtaw			; Nem, tal†n 'F'
	or	es:[status],wrijel	; 'W' kapcsol¢t tal†ltam
	jmp	short talwri		; Ott folytatjuk, ahol az olvasna
nemtaw:
	cmp	al,'s'                  ; File-specifik†ci¢ °r†sra ?
	jne	nemtas			; Nem, tal†n 'F'
	dec	cx			; Olvasni kell
	jcxz	elegro			; Ha befuccsolt
	lodsb				; Karakter beolvas†s
	or	al,' '                  ; KisbetÅs°tÅnk
	cmp	al,'w'                  ; 'W'rite ?
	je	wrstat			; Igen, write
	cmp	al,'r'                  ; 'R'ead ?
	jne	elegro			; Igen, write
	or	es:[status],ltojel	; 'R' kapcsol¢t tal†ltam
	jmp	short talwri		; Ott folytatjuk, ahol az olvasna
wrstat:
	or	es:[status],srijel	; 'W' kapcsol¢t tal†ltam
	jmp	short talwri		; Ott folytatjuk, ahol az olvasna
nemtas:
	cmp	al,'f'                  ; File-specifik†ci¢ ?
	jne	elegro			; Nem, m†s kapcsol¢ nincs
	or	es:[status],filjel	; 'F' kapcsol¢t tal†ltam
talwri:
	mov	bx,offset nevcim	; Ide lehet pakolni
cikfil:
	dec	cx			; Olvasni kell
	jcxz	confin			; Ha befuccsolt
	lodsb				; Karakter beolvas†s
	cmp	al,'\'                  ; Van specifik†ci¢ ?
	je	talsts			; Igen, jelezzÅk
	cmp	al,':'                  ; Van specifik†ci¢ ?
	jne	netali			; Nem, eddig nincs
talsts:
	or	es:[status],spejel	; Specifik†ci¢t tal†ltam
netali:
	cmp	al,' '                  ; Sz¢kîz ?
	je	confil			; Igen, vÇge a karakternek
	cmp	al,9			; Tabul†tor ?
	je	confil			; Igen, vÇge a karakternek
	cmp	al,'-'                  ; Kapcsol¢jel ?
	je	confie			; Igen, vÇge a karakternek
	cmp	al,'/'                  ; Kapcsol¢jel ?
	je	confie			; Igen, vÇge a karakternek
	mov	[bx],al 		; Karakter kipakol†s
	inc	bx			; Kîvetkezî karakter
	jmp	short cikfil		; Vissza karakterolvas†sra
confin:
	mov	[bx],ch 		; Z†r¢karakter kipakol†s
	jmp	short alaper		; VÇge a ciklusnak
confie:
	inc	cx			; Darab korrekci¢
	dec	si			; VisszalÇpÇs
confil:
	mov	[bx],ch 		; Z†r¢karakter kipakol†s
elegbe:
	dec	cx			; Ciklussz†ml†l¢ dekrement
	je	alaper			; Ha vÇge a ciklusnak
	jmp	beolca			; Parancssorbeolvas¢ ciklus
alaper:
	dec	cx			; St†tusz elîzetes
elegro:
	mov	dx,offset hibszo	; Szîvegc°m
vandxb:
	inc	cx			; St†tusz
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Paragrafusc°m kÇrî.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mesegk:
	test	es:[status],hiloje	; Magas c°mekre tîltÇs ?
	je	nekema			; Nem, alacsonyra
	push	bx			; Ez a hossz
	mov	ah,52h			; Elsî blokk keresÇs k¢dja
	int	21h			; DOS h°v†s
	cli				; IT. nem jîhet
	mov	bx,es:[bx - 2]		; Itt az elsî blokk paragrafusa
	xor	ax,ax			; Ha nincs blokk
	mov	di,ax			; DI <- 0
	pop	si			; Ennyi kell
hoelci:
	mov	es,bx			; Ez a paragrafus vizsg†land¢
	add	bx,es:[3]		; Hossz
	inc	bx			; Le°r¢ miatt
	cmp	es:[1],di		; Szabad blokk ?
	jne	neblsz			; Nem, †tlÇpjÅk
	cmp	es:[3],si		; ElfÇrne ?
	jb	neblsz			; Nem, †tlÇpjÅk
	mov	ax,es			; ElfÇrne, ez az aktu†lis
neblsz:
	cmp	byte ptr es:[0],5ah	; Utols¢ volt ?
	jne	hoelci			; Nem, kîvetkezî vizsg†lata
	stc				; Sikertelen jelzÇse
	or	ax,ax			; Nulla ?
	je	nisegi			; Igen, nincs blokk
	mov	es,ax			; Errîl van sz¢
	inc	ax			; Ez maga a blokk
	mov	bx,es:[3]		; Ez a hossz
	sub	bx,si			; Ennyi maradna
	je	meveza			; Ha nincs maradÇk
	dec	bx			; A kîvetkezî MCB miatt
	push	es:[0]			; Ez a blokk jelzîje
	mov	byte ptr es:[0],4dh	; Van ut†na mÇg
	mov	es:[3],bx		; Ez az £j hossz
	add	ax,bx			; Ez a kîvetkezî paragrafus
	mov	es,ax			; Ez a tulaj
	inc	ax			; Ez maga a blokk
	pop	es:[0]			; Kezdet
	mov	es:[1],ax		; Nincs tulajdonos
	mov	es:[3],si		; Ez a hossz
	jmp	short meveza		; Mehet odaadni
nekema:
	mov	ah,48h			; Blokk kÇrÇs k¢dja
	int	21h			; DOS h°v†s
	jc	nisegi			; Ha nem sikeres
meveza:
	sti				; IT. jîhet
	push	ds			; Elrontjuk
	push	cs			; Ez lesz a DS
	pop	ds			; DS <- CS
	mov	si,ax			; Ez a paragrafusc°m
	dec	si			; Igy MCB
	mov	es,si			; Ez a c°me a paragrafusnak
	mov	di,8			; Ide tîltse
	mov	si,offset comeds	; Szîvegc°m
	movsw				; M†solunk
	movsw				; M†solunk
	movsw				; M†solunk
	pop	ds			; VisszatîltÇs
	clc				; Nincs CARRY
nisegi:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	EMS vizsg†lat.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
emsope:
	push	dx			; Ennyi paragrafus lenne
	push	bx			; Ez az utols¢ blokk c°me
	push	si			; Ez az utols¢ mutat¢ c°me
	mov	dx,offset emmszo	; Ezt a file-t nyitjuk
	mov	ax,3d00h		; Megnyitjuk olvas†sra
	int	21h			; DOS h°v†s
	jnc	sinyie			; Ha sikeresen megnyitotta
niemse:
	jmp	ninemm			; Ha nincs, ki°rjuk
sinyie:
	mov	bx,ax			; File-sz†m †tpakol†s
	mov	ax,4400h		; IOCTL h°v†s k¢dja
	int	21h			; DOS h°v†s
	test	dl,80h			; Eszkîz ?
	je	niemse			; Ez file, nincs EMS
	mov	ax,4407h		; IOCTL h°v†s k¢dja
	int	21h			; DOS h°v†s
	or	al,al			; Van EMS ?
	je	niemse			; Nincs EMS
	mov	ah,3eh			; CLOSE k¢dja
	int	21h			; DOS h°v†s
	mov	ah,46h			; EMS verzi¢ kÇrdÇs
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres a h°v†s ?
	jne	niemse			; Hib†s, nincs EMS
	cmp	al,32h			; BCD 3.2 verzi¢
	jb	niemse			; Hib†s, nincs EMS
	mov	[emsver],al		; EltesszÅk a verzi¢t
	pop	si			; Ez mutat az utols¢ra
	pop	bx			; Ez az utols¢ blokk c°me
	pop	ax			; Ennyi paragrafus kellene
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	EMS lekÇpzÇs.					;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
emsmap:
	mov	ah,43h			; Szegmens open k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	emsers			; Ha nem sikeres a h°v†s
	mov	[hndems],dx		; Elpakoljuk a file-sz†mot
	cmp	[emsver],40h		; Van 4.0 legal†bb ?
	jb	ninanv			; Nincs
	mov	si,offset comedh	; ô a tulajdonos
	mov	ax,5301h		; Tulajdonos be†ll°t†s k¢dja
	int	67h			; Tulajdonos kÇrdÇs
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	emsers			; Ha nem sikeres a h°v†s
ninanv:
	mov	ah,41h			; SzegmenskÇrÇs k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	emsers			; Ha nem sikeres a h°v†s
	sub	bx,10h			; Ennyivel elîbb
	mov	[emsseg],bx		; Ez a szegmens a rezidens
	mov	ah,47h			; LekÇpzÇs mentÇs k¢dja
	mov	dx,[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	je	sivata			; Igen, sikeres
emsers:
	jmp	emserr			; Ha nem sikeres a h°v†s
sivata:
	mov	cx,[fizpnu]		; Oldalsz†m betîltÇs
lekmas:
	mov	ax,cx			; AL <- lapsz†m + 1
	dec	ax			; AL <- lapsz†m
	mov	bx,ax			; Ez a lekÇpzendî lapsz†m
	mov	ah,44h			; MAP k¢dja
	mov	dx,[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	emsers			; Ha nem sikeres a h°v†s
	loop	lekmas			; Ha tîbb lapot kell lekÇpezni
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	EMS hossz sz†m°tgat¢.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leptet:
	mov	cl,4			; Ennyit lÇptetek fel
	shl	ax,cl			; FellÇptetÇs
	mov	dx,ax			; M†solat
	add	dx,3fffh		; 16k byte - 1
	pushf				; Ugyan volt carry ?
	and	dx,not 3fffh		; Ennyi maradt igy
	popf				; Ha volt carry vissza
	rcr	dx,1			; Ennyi sz¢
	or	dx,dx			; Elîjele ?
	jns	eresza			; Ha nem 64 Kbyte
	xor	ax,ax			; AX <- 0 (Nem nîvelînk hosszat)
	ret				; VisszatÇrÇs
eresza:
	sub	ax,dx			; Ennyivel tîbb (negativban)
	sub	ax,dx			; Ennyivel tîbb (negativban)
	neg	ax			; Igy a hossz pozitiv
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	LekÇpzÇs sz†m°t†ssal.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
leksam:
	mov	cl,3			; Igy darabsz†m lesz
	shr	dx,cl			; Ennyi darab 16 kbyte
	mov	es:[resdar],dx		; Ez a paragrafus c°me
	mov	cl,10			; Igy darabsz†m lesz
	shr	dx,cl			; Ennyi darab 16 kbyte
	mov	cs:[fizpnu],dx		; Oldalsz†m betîltÇs
	cmp	dx,4			; 64 Kbyte ?
	jne	nehatv			; Ha nem 64 Kbyte
	sub	word ptr es:[resdar],10h; Ez a paragrafusc°m a vÇgleges
nehatv:
	mov	bx,dx			; Ennyi 16-kbyte kell
	jmp	emsmap			; EMS lekÇpzÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	Konstans beolvas¢.				;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
conbeo:
	xor	dx,dx			; Null†z†s
ujcaro:
	dec	cx			; Olvasni kell
	jcxz	nemaza			; Ha befuccsolt
	lodsb				; Karakter beolvas†s
	cmp	al,'0'                  ; 0 karaktern†l kisebb ?
	jb	nemazk			; Ha nem sz†mjegy karakter
	cmp	al,'9'                  ; 0 karaktern†l kisebb ?
	ja	nemazk			; Ha nem sz†mjegy karakter
	and	ax,0fh			; Csak a karakter marad
	mov	bx,ax			; Karakter mentÇs
	mov	ax,dx			; Ezt kell szorozni
	mov	dx,10			; Ez a szorz¢
	mul	dx			; AX <- AX * 10
	add	ax,bx			; NîvelÇs
	mov	dx,ax			; Ez a szorzat
	jmp	short ujcaro		; Uj karakter beolvas†s
nemazk:
	cmp	al,'-'                  ; Kapcsol¢ karakter ?
	je	igekak			; Igen, visszalÇpÅnk
	cmp	al,'/'                  ; Kapcsol¢ karakter ?
	jne	nemaza			; Nem, befejezzÅk
igekak:
	inc	cx			; Sz†ml†l¢ vissza
	dec	si			; Pointer vissza
nemaza:
	ret				; VisszatÇrÇs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;							;
;	MegnÇzzÅk, hogy Çlî k¢d-e.			;
;							;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
valodi:
	push	di			; Ez a c°m
	push	bx			; Szegmensc°m
	mov	ax,es:[di]		; 1. kÇt byte mentÇs
	mov	[seghik],ax		; Itt a helyÅk
	mov	ax,es:[di + 2]		; 2. kÇt byte mentÇs
	mov	[seghik + 2],ax 	; Itt a helyÅk
	mov	ax,es:[di + 4]		; 3. kÇt byte mentÇs
	mov	[seghik + 4],ax 	; Itt a helyÅk
	cli				; IT. ne jîjjîn
	mov	byte ptr es:[di],9ah	; Visszah°v†shoz CALL SEG:OFF
	cmp	byte ptr es:[di],9ah	; Ram volt ?
	jne	nevolv			; Nem, ez nem RAM
	mov	word ptr es:[di + 1],offset meghik; Ide ugorjon (offszet)
	cmp	word ptr es:[di + 1],offset meghik; Ram volt ?
	jne	nevolv			; Nem, ez nem RAM
	mov	ax,cs			; Ezt kell kipakolni
	mov	word ptr es:[di + 3],ax ; Ide ugorjon (szegmens)
	cmp	word ptr es:[di + 3],ax ; Ram volt ?
	jne	nevolv			; Nem, ez nem RAM
	mov	ah,4dh			; Hibak¢d kÇrÇs
	int	21h			; Ha itt van megh°v¢dik a COMED
	sti				; Most m†r lehet IT.
	mov	ax,[seghik]		; Paragrafusc°m
	or	ax,ax			; Volt szegmens ?
	jne	nevols			; Nem, ez a k¢drÇsz nem akt°v
	mov	ax,bx			; Ez a k¢d fejrÇsze
	dec	ax			; Ez a k¢d "MCB"-je
	cmp	ax,ax			; St†tusz (saj†t k¢d)
	jmp	short vliter		; VisszatÇrhetÅnk
nevols:
	cli				; IT. ne jîjjîn
nevolv:
	mov	ax,[seghik]		; 1. kÇt byte vissza
	mov	es:[di],ax		; Itt a helyÅk
	mov	ax,[seghik + 2] 	; 2. kÇt byte vissza
	mov	es:[di + 2],ax		; Itt a helyÅk
	mov	ax,[seghik + 4] 	; 2. kÇt byte vissza
	mov	es:[di + 4],ax		; Itt a helyÅk
	sti				; Most m†r lehet IT.
	or	al,1			; St†tusz (nem saj†t k¢d)
vliter:
	pop	bx			; Szegmensc°m vissza
	pop	di			; C°m vissza (stack År°tÇs)
	ret				; VisszatÇrÇs

meghik:
	push	bp			; Pointer
	mov	bp,sp			; Itt †ll a stack
	sub	word ptr [bp + 2],5	; Ide kell vissztÇrnie
	push	ds			; Ezt rontom el
	push	bx			; Ezt rontom el
	mov	ds,[bp + 4]		; Ez a h°v¢ szegmense
	mov	bx,[bp + 2]		; Ez az offszet

	push	cs:[seghik]		; Ez a k¢d 1. kÇt byte-ja
	pop	[bx]			; Ide tesszÅk
	push	cs:[seghik + 2] 	; Ez a k¢d 2. kÇt byte-ja
	pop	[bx + 2]		; Ide tesszÅk
	push	cs:[seghik + 4] 	; Ez a k¢d 3. kÇt byte-ja
	pop	[bx + 4]		; Ide tesszÅk
	mov	cs:[seghik],0		; JelezzÅk, hogy saj†t h°v†s volt
	cmp	ah,4dh			; Saj†t h°v†s ?
	je	emosah			; Igen, saj†t
	mov	cs:[seghik + 2],bx	; Ez a h°v†s offszetje
	mov	cs:[seghik + 4],ds	; Ez a h°v†s paragrafusa
	pop	bx			; Elrontottam
	pop	ds			; Elrontottam
	pop	bp			; Pointer vissza
	pushf				; Hogy IT. jellegÅ legyen
	call	dword ptr cs:[seghik + 2]; Megh°vjuk
	push	ds			; Ezt rontom el
	push	bx			; Ezt rontom el
	mov	bx,cs:[seghik + 2]	; Ez a h°v†s offszetje
	mov	ds,cs:[seghik + 4]	; Ez a h°v†s paragrafusa
	push	[bx]			; Ez a k¢d 1. kÇt byte-ja
	pop	cs:[seghik]		; Ide tesszÅk
	push	[bx + 2]		; Ez a k¢d 2. kÇt byte-ja
	pop	cs:[seghik + 2] 	; Ide tesszÅk
	push	[bx + 4]		; Ez a k¢d 3. kÇt byte-ja
	pop	cs:[seghik + 4] 	; Ide tesszÅk
	mov	byte ptr [bx],9ah	; Visszah°v†shoz CALL SEG:OFF
	mov	word ptr [bx + 1],offset meghik; Ide ugorjon (offszet)
	mov	word ptr [bx + 3],cs	; Ide ugorjon (szegmens)
	pop	cs:[seghik + 6] 	; Megint elrontan†m (BX)
	pop	ds			; Elrontottam
	pop	bx			; FAR offset År°tÇs
	pop	bx			; FAR szegmens År°tÇs
	mov	bx,cs:[seghik + 6]	; Ez az eredeti BX
	iret				; Mintha semmi sem tîrtÇnt volna
emosah:
	pop	bx			; Elrontottam
	pop	ds			; Elrontottam
	pop	bp			; Pointer vissza
	retf				; Csak visszatÇrek

seghik	dw	0,0,0,0 		; Ez a k¢d mentÇs helye

fogkel	equ	($ - start) and 15	; Ennyi byte marad

	if	fogkel NE 0

	db	16 - fogkel  dup(?)

	endif

emsfej:
hndems	label	word
	dw	?			; Ez az EMS handle helye
fizpnu	dw	?			; Ez az oldalsz†m


ikilek:
	mov	dx,[hndems]		; Ez a file-sz†m
	or	dh,dh			; LekÇpzÇs jelzÇs van ?
	je	vimebe			; Nincs, mehet
	mov	ah,48h			; Restore k¢dja
	dec	byte ptr [hndems + 1]	; LekÇpzÇs megszÅnÇsÇnek jelzÇse
	mov	dh,0			; DH <- 0
	int	67h			; EMS h°v†s
vimebe:
	pop	ds			; Szegmensregiszter vissza
	pop	dx			; Regiszter vissza
	pop	ax			; Regiszter vissza
vimero:
	db	0eah			; DOS visszah°v†shoz JMP SEG:OFF
int21e	dw	?,?			; Ez az eredeti vektor helye

emssta:
	cmp	ah,4dh			; Hibak¢d kÇrÇs ?
	je	hivems			; Igen, mehetÅnk kÇrni
	cmp	ah,0ah			; String kÇrÇs ?
	je	hivems			; Igen, mehetÅnk kÇrni
	cmp	ah,4ch			; KilÇpÇs kÇrÇs ?
	jne	vimero			; Nem, m†st kÇrÅnk
	or	ah,ah			; A st†tusz nem nulla
hivems:
	push	ax			; Elrontjuk
	push	dx			; Ezt is elrontjuk
	push	ds			; DS romlik
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	jne	ikilek			; LekÇpzÇs vizsg†lat
	mov	dx,[hndems]		; Ez a file-sz†m
	or	dh,dh			; Volt lekÇpzÇs ? (hndems + 1)
	jne	lekeer			; Jelenleg lekÇpzett
	mov	ah,47h			; LekÇpzÇs mentÇs k¢dja
	int	67h			; EMS h°v†s
	inc	byte ptr [hndems + 1]	; LekÇpzÇs jelzÇs
	push	bx			; Most ezt is rontom
	push	cx			; Ebben lesz a ciklussz†m
	mov	cx,[fizpnu]		; Oldalsz†m betîltÇs
reslek:
	mov	ax,cx			; AL <- lapsz†m + 1
	dec	ax			; AL <- lapsz†m
	mov	bx,ax			; Ez a lekÇpzendî lapsz†m
	mov	ah,44h			; MAP k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres ?
	loope	reslek			; Ha tîbblapos a MAP
	pop	cx			; CX vissza
	pop	bx			; BX vissza
	jne	ikilek			; Nem sikeres, ez baj
lekeer:
	pop	ds			; Szegmensregiszter vissza
	pop	dx			; Regiszter vissza
	pop	ax			; Regiszter vissza
	pushf				; Hogy IT. jellegÅ legyen

	db	9ah			; Megh°vjuk (call seg:off)
paredc	dw	int21r			; Itt a c°me
emsseg	dw	?			; Ez a paragrafus az

	push	ax			; Elrontjuk
	push	dx			; Ezt is elrontjuk
	push	ds			; El fogjuk rontani
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	dec	byte ptr [hndems + 1]	; LekÇpzÇs megszÅnÇsÇnek jelzÇse
	mov	dx,[hndems]		; Ez a file-sz†m
	mov	ah,48h			; Restore k¢dja
	mov	ds,[emsseg]		; Itt van a st†tusz
	test	[statuh],ressto shr 8	; Le†ll°tsuk ?
	je	nemrek			; Nem kell visszavenni
	int	67h			; EMS h°v†s
	xor	ax,ax			; Null†z†s
	mov	ds,ax			; Ez az IT. t†bla
	cmp	ds:[21h * 4],offset emssta; Ide mutat mÇg ?
	jne	nemunr			; Nem, ez m†s
	mov	ax,cs			; Ez a paragrafus az aktu†lis
	xor	ax,ds:[(21h * 4) + 2]	; Ide mutat mÇg ?
	jne	nemunr			; Nem, ez m†s
	mov	cs:[hndems - 15],ax	; Tulajdonos tîrlÇs (AX = 0)
	mov	ax,cs:[int21e]		; Ez az eredeti offszet
	mov	ds:[21h * 4],ax 	; Ide mutasson vissza
	mov	ax,cs:[int21e + 2]	; Ez az eredeti paragrafus
	mov	ds:[(21h * 4) + 2],ax	; Ide mutasson vissza
	mov	ah,45h			; Blokk visszaad†s k¢dja
nemrek:
	int	67h			; EMS h°v†s
nemunr:
	pop	ds			; Szegmens vissza
	pop	dx			; Regiszter vissza
	pop	ax			; Regiszter vissza
	iret				; Befejezve

emsend:

masfel:
	cld				; A stringmÅveletek ir†nya
	xor	ax,ax			; AX <- 0
	mov	[sabpoi],ax		; öres a l†nc
	mov	[status],ax		; St†tusz null†zva
	push	cs			; Ez a saj†t paragrafusc°mem
	push	cs			; Ez a saj†t paragrafusc°mem
	mov	ax,0f000h		; Ez a ROM-BIOS szegmense
	mov	ds,ax			; Szegmensregiszterbe 0f000h
	mov	al,ds:[0fffeh]		; Azonosit¢ beolvas†s
	push	es			; Elromlik mindj†rt
	pop	ds			; Itt a rezidens
	cmp	al,0fch 		; AT-gÇp ?
	jne	netaat			; Nem, nem AT
	or	[status],atjelz 	; Ez a gÇp AT
netaat:
	mov	ax,3521h		; IT. vektor tartalom lekÇrdezÇs
	int	21h			; DOS h°v†s
	mov	[int21c],bx		; IT. offszet
	mov	[int21c + 2],es 	; IT. paragrafus
	mov	[int21e],bx		; IT. offszet
	mov	[int21e + 2],es 	; IT. paragrafus
	pop	ds			; DS <- CS
	pop	es			; ES <- CS
	mov	ah,30h			; Verzi¢sz†m kÇrdezÇs k¢dja
	int	21h			; DOS h°v†s
	cmp	al,2			; ElÇg nagy a DOS verzi¢sz†m ?
	ja	mehdot			; Igen, menjÅnk tov†bb
	mov	dx,offset versba	; Szîvegc°m
kilsok:
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	mov	ax,4c01h		; KilkÇpÇs k¢dja, hibak¢d:1
	int	21h			; DOS h°v†s (kilÇpÇs)
mehdot:
	call	kapert			; Kapcsol¢k ÇrtelmezÇse
	jne	kilsok			; Ha nem sikeres
	mov	ah,52h			; Elsî blokk keresÇs k¢dja
	int	21h			; DOS h°v†s
	mov	ax,es:[bx - 2]		; Itt az elsî blokk paragrafusa
	mov	dx,offset merror	; Szîvegc°m
	mov	es,ax			; ES <- elsî blokk
	xor	si,si			; A pointer
	mov	bx,4d5ah		; Eleje Çs vÇge
ujelke:
	cmp	es:[si],bh		; Mem¢ria blokk ?
	je	meatal			; Igen, ez az
	cmp	es:[si],bl		; Utols¢ blokk ?
	jne	kilsok			; Nem, hiba
meatal:
	cmp	es:[si + 1],si		; Szabad blokk ?
	je	igmata			; Igen, nem is vizsg†ljuk
	mov	si,offset int21r	; Itt kezdje az ellenîrzÇst
	mov	di,offset int21r - offset start + 16; Ez a rezidens MCB
	mov	cx,ohdara		; Ennyi sz¢
	rep	cmpsw			; Vizsg†lunk
	je	metals			; Ha ez a szegmens az
	mov	si,offset emssta	; Itt kezdje az ellenîrzÇst
	mov	di,offset emssta - offset emsfej + 16; Ez a rezidens MCB
	mov	cx,emsdar		; Ennyi sz¢
	rep	cmpsw			; Vizsg†lunk
	je	siazem			; Ha ez a szegmens az
igmata:
	xor	si,si			; A pointer
	add	ax,es:[si + 3]		; MCB hossz
	inc	ax			; Igy a kîvetkezî MCB
	cmp	es:[si],bl		; Utols¢ blokk ?
	mov	cx,es			; Ez volt az elîzî
	mov	es,ax			; Ez a kîvetkezî
	jne	ujelke			; Nem, £j keresÇsre
	cmp	es:[si],bl		; Utols¢ blokk ? (LOADHI !!!)
	jne	mekovi			; Nem, nem nÇzem tov†bb
	cli				; Nem jîhet IT.
	mov	es:[si],bh		; Ha ez RAM, akkor be°rom
	cmp	es:[si],bh		; Ez RAM ?
	mov	es:[si],bl		; Vissza°rom ak†rmi volt
	sti				; Most m†r lehet IT.
	jne	mekovi			; Ez nem RAM, befejeztem
	mov	es,cx			; Ez az elîzî
	mov	es:[si],bh		; Vissza°rom hogy van kîvetkezî
	mov	es,ax			; Ez az aktu†lis
	jmp	short meatal		; Ez RAM, itt is vizsg†lom
mekovi:
	mov	bx,0a000h		; Ez a 640K-t kîvetî paragrafus
	cmp	ax,bx			; E fîlîtt van a c°m ?
	ja	netpam			; Ha fîlîtte van
komeci:
	mov	es,bx			; Ez az aktu†lis paragrafus
	mov	si,offset int21r	; Itt kezdje az ellenîrzÇst
	mov	di,offset int21r - offset start; Ez a rezidens rÇsz
	mov	cx,ohdara		; Ennyi sz¢
	rep	cmpsw			; Vizsg†lunk
	jne	nataek			; Ha ez a paragrafus nem az
	mov	di,offset int21r - offset start; Ez a rezidens rÇsz
	call	valodi			; MegnÇzzÅk, Çl-e ez a k¢d
	je	metals			; Ha ez a paragrafus Çl
nataek:
	mov	si,offset emssta	; Itt kezdje az ellenîrzÇst
	mov	di,offset emssta - offset emsfej; Ez a rezidens rÇsz
	mov	cx,emsdar		; Ennyi sz¢
	rep	cmpsw			; Vizsg†lunk
	jne	natemn			; Ha ez a paragrafus nem az
	mov	di,offset emssta - offset emsfej; Ez a rezidens rÇsz
	call	valodi			; MegnÇzzÅk, Çl-e ez a k¢d
	je	siazem			; Ha ez a paragrafus Çl
natemn:
	inc	bx			; Kîvetkezî pr¢ba c°me
	jne	komeci			; Van ellenîrizendî
netpam:
	jmp	szokil			; Nem aktiv a COMED
metals:
	sub	ax,10h - 1		; Igy k¢dszegmens
	mov	es,ax			; Ez a COMED rezidens paragrafusa
	push	ax			; Ez a COMED rezidens paragrafusa
	mov	dx,es:[0f3h]		; Ez a hossza lesz
	jmp	short neemsr		; Ez nem EMS
siazem:
	sub	ax,eddres - 1		; Ennyivel van l†tsz¢lag elîbb
	pop	es			; Stack ÅritÇs
	mov	es,ax			; Ez a COMED rezidens paragrafusa
	mov	[emsseg],ax		; Ez a paragrafus kell
	mov	di,es:[fizpnu]		; Ez az oldalsz†m
	mov	dx,es:[hndems]		; Ez az handle
	mov	es,es:[emsseg]		; Ez a paragrafus a rezidens
	push	es			; Kell kÇsîbb is
	mov	[rehndl],dx		; Elpakoljuk
	push	di			; Oldalsz†m mentÇs
	mov	ah,47h			; LekÇpzÇs mentÇs k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres ?
	jne	emsreb			; Nem sikeres, visszatÇrek
	pop	cx			; CX <- oldalsz†m
maxlek:
	mov	ax,cx			; AL <- lapsz†m + 1
	dec	ax			; AL <- lapsz†m
	mov	bx,ax			; Ez a lekÇpzendî lapsz†m
	mov	dx,[rehndl]		; Ez a file-sz†m
	mov	ah,44h			; MAP k¢dja
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres ?
	je	leksir			; Igen, sikeres lekÇpzÇs
emsreb:
	jmp	emserr			; Hibaki°rat†s
leksir:
	loop	maxlek			; Ennyiszer kÇpzÅnk le
	mov	dx,es:[resdar]		; Ez a darabsz†ma paragrafusoknak
neemsr:
	add	dx,10h			; Ennyivel a nîvekmÇny
	mov	cs:[blkmas],dx		; Ez a sz†mol†si alap
	and	es:[status],atjelz	; Bit tîrlÇsek
	or	es:[status],comext	; JelezzÅk, hogy rezidens
	push	cs			; Ez a k¢dszegmens
	pop	es			; ES <- CS
	test	es:[status],unijel	; Le†ll°tjuk ?
	jne	lalcoe			; Igen, °gy j¢ ahogy van
	mov	bx,1000h		; Ennyi legal†bb legyen
	mov	ah,4ah			; Blokk hossz m¢dos°t†s k¢dja
	int	21h			; DOS h°v†s
	jc	bajfog			; Ha nincs elÇg hely
	mov	di,offset sajsta	; Ez a szabad hely
	mov	cx,di			; Ennyi negativban a hely
	neg	cx			; Ennyi lesz a hely
	mov	[di + 2],cx		; Igy a hossza
	call	memvis			; Ennyi a saj†t helyÅnk
lalcoe:
	pop	es			; Ez a rezidens paragrafusc°m
	push	es			; VisszatesszÅk
	call	parert			; Parancssor ÇrtelmezÇs
	jne	bajire			; Ha nem sikeres
	test	es:[status],unijel	; Le†ll°tjuk ?
	jne	lalpro			; Igen, megpr¢b†ljuk
	call	gerbag			; TîmîritÇs
	and	es:[status],not comext	; Hogy rezidens, ezt tîrîljÅk
	call	memsta			; Mem¢ria statisztika
	test	es:[status],unijel	; Le†ll°tjuk ?
	je	beftev			; Nem †ll°tjuk le
lalpro:
	call	lealpr			; Megpr¢b†juk le†ll°tani
beftev:
	call	lekvis			; Vissza†ll°tjuk a lekÇpzÇst
	jmp	csakki			; BefejezzÅk
bajfog:
	mov	dx,offset membaj	; Szîvegc°m
bajire:
	call	lekvis			; Vissza†ll°tjuk a lekÇpzÇst
bajirj:
	push	cs			; Itt van szîveg
	pop	ds			; Ebbîl a szegmensbîl kell °rni
	mov	ah,9			; Stringki°rat†s k¢dja
	int	21h			; DOS h°v†s
	mov	ax,4c01h		; KilÇpÇs k¢dja
	int	21h			; DOS h°v†s kilÇpÇsre

szokil:
	push	cs			; Ebbîl lesz ES
	pop	es			; ES <- CS
	test	es:[status],hiloje or unijel; Kell dupla tîltÇs ?
	jne	noload			; Nem, nem kell dupla tîltÇs
	xor	byte ptr ds:[80h],80h	; BetîltÇs jelzÇs, volt tîltve ?
	jns	noload			; Igen, volt, ez m†sodpÇld†ny
	mov	es,ds:[2ch]		; Ez az environment
	mov	[envseg],es		; Ez a betîltendîÇ is
	mov	[comseg],cs		; Itt a parancs paragrafusa
	mov	[fcb1seg],cs		; Az 1-es FCB paragrafusa
	mov	[fcb2seg],cs		; A 2-es FCB paragrafusa
	mov	cx,8000h		; Ezen belÅl kell tal†lnia
	xor	di,di			; Itt keressen az environmentbe
	mov	ax,di			; Ezt keressÅk (0)
startc:
	repne	scasb			; Elval†szt¢jel ?
	jne	tolhib			; Nincs -> hiba
	dec	cx			; Ciklussz†ml†l¢ korrekci¢
	scasb				; KÇt nulla ?
	jnz	startc			; Nem, de Çn ilyet keresek
	scasw				; DI <- DI + 2
	mov	dx,di			; DX <- programnÇv c°me
	push	es			; Ez az environment
	pop	ds			; DS <- environment paragrafusa
	push	cs			; Itt van a le°r¢
	pop	es			; ES vissza†ll°t†s (m¢dosit†shoz)
	mov	ah,4ah			; M¢dosit†s k¢dja
	mov	bx,2000h		; Ennyinek lenni kell
	int	21h			; DOS h°v†s
	jc	tolhib			; Ha nincs ennyi
	mov	ah,4ah			; M¢dosit†s k¢dja
	mov	bx,1000h		; Ennyi az indul¢ rezidens
	int	21h			; DOS h°v†s
	mov	bx,offset parblk	; Itt van a le°r¢
	mov	ax,4b00h		; EXEC k¢dja
	int	21h			; DOS h°v†s
tolhib:
	push	cs			; Csak hiba esetÇn jut ide !!!!
	pop	ds			; Itt a szîveg paragrafusa
	mov	dx,offset lerror	; Szîvegc°m
	jmp	kilsok			; KilÇpÇs szîvegki°rat†ssal
noload:
	cld				; Nîvekvî stringmÅveletek
	push	cs			; Ez a k¢dszegmens
	pop	es			; ES <- CS
	test	[status],unijel 	; Le†ll°tjuk ?
	jne	nirdam			; Igen, °gy j¢ ahogy van
	mov	di,offset sajsta	; Ez a szabad hely c°me
	mov	cx,di			; Ennyi negativban a hely
	neg	cx			; Ennyi lesz a hely
	mov	[di + 2],cx		; Igy a hossza
	call	memvis			; Ennyi a saj†t helyÅnk
	test	[status],hiloje 	; Kellett dupla tîltÇs ?
	jne	nirdam			; Nem, nincs m†solat
	mov	ax,ds:[0ch]		; H°v¢ PSP (ez a rÇgi)
	dec	ax			; Ez MCB
	mov	ds,ax			; DS <- MCB
	mov	ds:[1],cs		; Tulajdonos v†lt†s
	inc	ax			; H°v¢ PSP (ez a rÇgi)
	mov	ds,ax			; DS <- PSP
	mov	cx,16			; 32 byte †tpakol†s az 16 sz¢
	xor	di,di			; Ide (0)
	mov	si,di			; Innen (0 a PSP-hez kÇpest)
	rep	movsw			; 32 byte m†sol†s a rÇgi helyrîl
	mov	si,cs:[2ch]		; ES <- jelenlegi environment
	dec	si			; Ez MCB
	mov	es,si			; ES <- MCB
	mov	es:[1],cs		; Tulajdonos v†lt†s
	mov	es,ds:[2ch]		; ES <- rÇgi environment
	mov	ah,49h			; Felszabad°t†s k¢dja
	int	21h			; DOS h°v†s
	push	ds			; Ez a rÇgi PSP
	pop	es			; Ez a rÇgi PSP
	mov	di,offset rescim	; Ennyi a hossza a programnak
	mov	ax,di			; Ez a m†solat
	neg	ax			; Elîjelcsere
	mov	[di + 2],ax		; A maradÇk terÅlet mÇrete
	call	memvis			; Ennyi a saj†t helyÅnk
	push	cs			; Ez mostani k¢dszegmens
	pop	ds			; Ez mostani k¢dszegmens
	call	parert			; Parancssor ÇrtelmezÇs
	jne	nesipa			; Nem sikeres
	jmp	rebani			; Ha sikeres
nesipa:
	mov	ah,49h			; Felszabad°t†s k¢dja
	int	21h			; DOS h°v†s
mobahi:
	jmp	bajirj			; Itt ki°runk
nirdam:
	test	es:[status],unijel	; Le†ll°tjuk ?
	je	neleni			; Nem, nem kell le†ll°tani
	jmp	csakki			; Igen, °gy j¢ ahogy van
neleni:
	mov	bx,1000h		; Ennyi legyen
	mov	ah,4ah			; Blokk hossz m¢dos°t†s k¢dja
	int	21h			; DOS h°v†s
	jnc	vananh			; Van annyi
	jmp	bajfog			; Hiba, ha nincs
vananh:
	call	kavute			; Parancssor ÇrtelmezÇs
	jne	mobahi			; Sikertelen, ki°runk
	mov	si,offset syntab	; Szinonima elem c°me
	mov	cx,3			; Ennyi fej van
	xor	bx,bx			; Ennyi hossz£ eddig
kofene:
	mov	di,si			; Ez a fej a visszaadand¢
	call	hoviza			; Mennyit foglalt eddig
	lodsw				; NîvelÇs 2-vel
	loop	kofene			; Foglal¢ ciklus
	mov	di,offset stackc	; Itt kezdîdik a command stack
	call	hoviza			; Mennyit foglalt eddig
	mov	di,offset stackc + 4	; Itt kezdîdik a kîzîs stack
	call	hoviza			; Mennyit foglalt eddig
	push	bx			; A hosszt mentjÅk
	add	bx,[memhos]		; + ennyi kell
	jc	nahoke			; Ha nagyon hossz£
	mov	bp,bx			; Ennyi kell îsszesen
	add	bx,(offset rescim - offset start) + 15; Ennyivel tîbb
	jnc	nekena			; Ha nem nagyon hossz£
nahoke:
	xor	bp,bp			; BP <- 0 (maximum hossz)
	mov	bx,1000h - 10h		; Ennyi kell
	jmp	short kemese		; Kell 64 KB
nekena:
	add	bp,offset rescim + 15	; Ennyivel tîbb
	and	bp,0fffch		; Igy blokkdarab
	mov	cl,4			; Ennyit lÇptetek le
	shr	bx,cl			; LelÇptetÇs
kemese:
	test	es:[status],emsmje	; EMS-be kell tîlteni ?
	je	nerehi			; Nem, nem kell EMS-be tenni
	mov	dx,bx			; Ez a szÅksÇges darabsz†m
	call	emsope			; EMS nyit†s
	call	leptet			; EMS szegmens lÇptetÇs
	add	bp,ax			; Ennyivel nîtt
	call	leksam			; LekÇpzÇsi sz†m°t†s
	mov	es,[emsseg]		; Ez az EMS paragrafusa
	mov	si,offset start 	; Ez a m†solat eleje
	mov	di,si			; Ide kell lepakolni
	mov	cx,(offset rescim - offset start) / 2; Ennyi sz¢
	cli				; IT. nem jîhet
	rep	movsw			; M†sol†s
	sti				; IT. jîhet
	push	es			; Ebbîl lesz DS
	pop	ds			; DS <- ES
	xor	ax,ax			; AX <- 0
	mov	[sabpoi],ax		; Nincs c°m
	mov	di,offset rescim	; Ez szabadok c°me
	sub	bp,di			; Ez a hossz a program nÇlkÅl
	mov	[di + 2],bp		; Ennyi hossz£
	call	memvis			; KitîltjÅk
	call	gerbaf			; Bem†soljuk ford°tva
	pop	bp			; Hossz vissza
	call	memsta			; Mem¢ria statisztika
	test	es:[status],unijel	; Le†ll°tjuk ?
	je	befnem			; Nem †ll°tjuk le
	call	lealpr			; Megpr¢b†juk le†ll°tani
befnem:
	jmp	emshil			; Mem¢ria statisztika
nerehi:
	call	mesegk			; Paragrafus kÇrÇs
	jnc	mebaeg			; Ha sikeres a kÇrÇs
	jmp	bajfog			; Hiba, ha nincs
mebaeg:
	sub	ax,10h			; Ennyivel elîbb tart
	mov	es,ax			; Ez a rezidens rÇsz most
	push	cs			; Ebbîl lesz DS
	pop	ds			; DS <- CS
	mov	si,offset start 	; Ez a m†solat eleje
	mov	di,si			; Ide kell lepakolni
	mov	cx,(offset rescim - offset start) / 2; Ennyi sz¢
	cli				; IT. nem jîhet
	rep	movsw			; M†sol†s
	sti				; IT. jîhet
	push	es			; Ebbîl lesz DS
	pop	ds			; DS <- ES
	xor	ax,ax			; AX <- 0
	mov	[sabpoi],ax		; Nincs c°m
	mov	di,offset rescim	; Ez szabadok c°me
	sub	bp,di			; Ez a hossz a program nÇlkÅl
	mov	[di + 2],bp		; Ennyi hossz£
	call	memvis			; KitîltjÅk
	call	gerbaf			; Bem†soljuk ford°tva
	test	es:[status],unijel or helpje; Le†ll°tjuk ?
	jne	csstki			; Igen, le†ll°tjuk
	pop	bp			; Hossz vissza
	call	memsta			; Mem¢ria statisztika
	jmp	rehive			; Nem, nem jelzett EMS-t
rebani:
	push	es			; ElmentjÅk a szegmenst
	call	gerbag			; Tîmîritek
	pop	es			; Szegmens vissza
	mov	ah,49h			; Felszabad°t†s k¢dja
	int	21h			; DOS h°v†s
	test	es:[status],unijel or helpje; Le†ll°tjuk ?
	je	neleke			; Nem, vizsg†lunk
csstki:
	jmp	csakki			; Igen, le†ll°tjuk
neleke:
	mov	bx,offset sabpoi	; Ez a szabad terÅlet feje
nemutc:
	cmp	word ptr es:[bx],0	; Utols¢ c°m ?
	je	ezutci			; Igen, ennek a hossza Çrdekel
	mov	si,bx			; Ez mutat a mostani blokkra
	mov	bx,es:[bx]		; Kîvetkezî blokk
	jmp	short nemutc		; Vissza kîvetkezî ellenîrzÇsre
ezutci:
	mov	ax,es:[bx + 2]		; Ennyi hossz£ a maradÇk
	mov	dx,cs:[memhos]		; Ez lesz a hosz
	and	dx,not 3		; Hogy 4-el oszthat¢ legyen
	cmp	ax,dx			; Maradt a kÇrÇsnek megfelelî ?
	jae	marbov			; Igen, maradt annyi
	mov	dx,ax			; FelÅlb°r†ljuk a hosszt
marbov:
	mov	es:[bx + 2],dx		; Ez a hossza lesz
	add	dx,bx			; Ez a rezidens hossz
	mov	ax,dx			; M†solat
	neg	ax			; Elîjelcsere
	and	ax,0ch			; Ennyivel mÇgis hosszabb
	add	es:[bx + 2],ax		; Ez a hossza lesz
	jne	valmar			; Ha maradt valemennyi
	mov	es:[si],ax		; Nincs mem¢ri†m
valmar:
	add	dx,0fh			; Ennyivel lesz od†bb
	mov	cl,4			; Ennyit lÇptetÅnk le
	shr	dx,cl			; Ez a paragrafussz†m
	jne	emardx			; Ha nem 64Kbyte
	mov	dx,1000h		; 64Kbyte szegmese
emardx:
	sub	dx,10h			; Csak ennyi paragrafus kell
nelehi:
	test	es:[status],emsmje	; EMS-be kell tîlteni ?
	jne	vajeem			; Igen, EMS-be kell tenni
	jmp	nejeem			; Nem, nem jelzett EMS-t
vajeem:
	push	cs			; Ez a szegmens kell DS-be
	pop	ds			; DS <- CS
	call	emsope			; EMS nyit†s
	call	leptet			; EMS szegmens lÇptetÇs
	je	nehoza			; Ha ez nulla lenne
	add	es:[bx + 2],ax		; Ez a m¢dositott hossz
	cmp	word ptr es:[si],0	; Nulla c°m ?
	jne	nehoza			; Nem, marad a rÇgi
	mov	es:[si],bx		; Igy biztos erre mutat
nehoza:
	call	leksam			; LekÇpzÇsi sz†m°t†s
	call	memsta			; Mem¢ria statisztika
	test	es:[status],unijel	; Le†ll°tjuk ?
	je	beftee			; Nem †ll°tjuk le
	call	lealpr			; Megpr¢b†juk le†ll°tani
beftee:
	push	es			; Itt van most
	pop	ds			; Ez a forr†s lesz
	mov	es,cs:[emsseg]		; Ide kell pakolni
	mov	si,offset start 	; Innen pakoljuk
	mov	di,si			; Ide lesz lerakva
	mov	cx,[resdar]		; Ennyi paragrafus m†soland¢
	shl	cx,1			; Ennyi darab 8 byte
	shl	cx,1			; Ennyi darab 4 byte
	shl	cx,1			; Ennyi darab 2 byte
	cli				; IT. nem jîhet
	rep	movsw			; M†sol†s
	sti				; Most m†r igen
emshil:
	mov	ah,48h			; LekÇpzÇs restore k¢dja
	mov	dx,cs:[hndems]		; Ez a file-sz†m
	int	67h			; EMS h°v†s
	or	ah,ah			; Sikeres volt a h°v†s ?
	jne	emserr			; Ha nem sikeres a h°v†s
	push	ds			; Ebbîl lesz ES
	pop	es			; ES <- DS
	mov	bx,emmseg		; Ennyi lesz rezidens
	call	mesegk			; Paragrafus kÇrÇs
	jnc	vanemr			; Ha van mem¢ria
	jmp	tolhib			; Ilyen nem is lehet
vanemr:
	push	ax			; Tulajdonos miatt
	sub	ax,eddres		; Ennyivel van l†tsz¢lag elîbb
	mov	es,ax			; Ide lesz pakolva
	pop	word ptr es:[emsfej - 15]; Tulajdonos be†ll°t†s
	mov	si,offset emsfej	; Itt kezdîdik
	mov	di,si			; Ide pakolja
	push	cs			; Itt van most
	pop	ds			; Ez a forr†s lesz
	mov	cx,emmseg * 8		; Ennyi sz¢
	rep	movsw			; Bem†soltuk
	mov	ds,ax			; Ide lesz pakolva
	mov	dx,offset emssta	; Ide mutasson
	cli				; IT. tilt†s
	mov	ax,2521h		; IT. vektor tartalom m¢dosit†s
	int	21h			; DOS h°v†s
	sti				; IT. engedÇly
	jmp	short csakki		; BefejeztÅk
emserr:
	push	ax			; Hibak¢d mentÇs
	mov	dx,offset emshnd	; Ha nem sikeres az EMS h°v†s
	mov	ah,9			; Strinki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ax			; Ez a hibak¢d
	push	ax			; Hibak¢d mentÇs
	shr	ah,1			; LelÇptetÇs 1. f†zis
	shr	ah,1			; LelÇptetÇs 2. f†zis
	shr	ah,1			; LelÇptetÇs 3. f†zis
	shr	ah,1			; LelÇptetÇs 4. f†zis
	or	ah,'0'                  ; KarakteresitÇs
	cmp	ah,'9'                  ; Nem betÅ lesz ?
	jbe	nebet1			; Nem, mehet a ki°r†s
	add	ah,7			; Igy nagybetÅ
nebet1:
	mov	dl,ah			; Ez a ki°rand¢
	mov	ah,2			; Karakterki°rat†s k¢dja
	int	21h			; DOS h°v†s
	pop	ax			; Ez a hibak¢d
	and	ah,0fh			; Csak az als¢ 4 bit kell
	or	ah,'0'                  ; KarakteresitÇs
	cmp	ah,'9'                  ; Nem betÅ lesz ?
	jbe	nebet2			; Nem, mehet a ki°r†s
	add	ah,7			; Igy nagybetÅ
nebet2:
	mov	dl,ah			; Ez a ki°rand¢
	mov	ah,2			; Karakterki°rat†s k¢dja
	int	21h			; DOS h°v†s
	mov	dx,offset kilkel	; Ez a szîveg a vÇge
	jmp	short eziski		; Ki°rat†s kilÇpÇssel
ninemm:
	mov	dx,offset emsnin	; Nincs EMS szîveg c°me
eziski:
	jmp	kilsok			; KilÇpÇs szîvegki°rat†ssal
nejeem:
	push	dx			; A paragrafus mennyisÇge
	call	memsta			; Mem¢ria statisztika
	pop	bx			; Paragrafussz†m vissza
	push	bx			; Ennyi paragrafust m†solok
	call	mesegk			; Paragrafus kÇrÇs
	jnc	vanbel			; Ha van mem¢ria
	jmp	tolhib			; Ilyen nem is lehet
vanbel:
	mov	bx,ax			; M†solat a paragrafusc°mrîl
	push	ax			; ElmentjÅk
	sub	ax,10h			; Itt az eleje (l†tsz¢lag !!)
	dec	bx			; MCB lesz belîle
	mov	es,bx			; Ez az MCB
	pop	es:[1]			; Ez a tulajdonos
	mov	es,ax			; Ez a szegmens lesz a cÇl
	mov	si,100h 		; Itt a forr†s
	mov	di,si			; Itt fog kezdîdni
	pop	cx			; Ennyi paragrafus (16 byte)
	shl	cx,1			; 8 byte (4 sz¢)
	shl	cx,1			; 4 byte (2 sz¢)
	shl	cx,1			; 2 byte (1 sz¢)
	rep	movsw			; ètm†soljuk a programot
rehive:
	push	es			; Ez lesz a cÇl
	pop	ds			; Ez a rezidens paragrafusc°m
	mov	dx,offset int21r	; Ide mutasson
	cli				; IT. tilt†s
	mov	ax,2521h		; IT. vektor tartalom m¢dosit†s
	int	21h			; DOS h°v†s
	sti				; IT. engedÇly
csakki:
	mov	ax,4c00h		; KilÇpÇs k¢dja
	int	21h			; DOS h°v†s kilÇpÇsre

parblk	label	byte			; ParamÇter blokk az ind°t†shoz
envseg	dw	?
comoff	dw	80h
comseg	dw	?
fcb1off dw	5ch
fcb1seg dw	?
fcb2off dw	6ch
fcb2seg dw	?

;
rehndl	dw	0ffffh



	ifdef	nyelv

		ifidn	nyelv,<english>
			defang
		else
			ifidn	nyelv,<deutsch>
				defnem
			else
				ifdif	nyelv,<magyar>
					%out	Hib†s nyelvdefini†l†s !
					%out	Igy magyar nyelvÅ lett.
					.err
				endif
				defmag
			endif
		endif

	else
		defmag
	endif
;
	even

	dw	100h	dup (?)

	if	($ - start) and 3

	dw	0			; Ha nem nÇgyes c°men van

	endif
;
sajsta	label	word			; Saj†t STACK-pointer

code	ends
	end	start
