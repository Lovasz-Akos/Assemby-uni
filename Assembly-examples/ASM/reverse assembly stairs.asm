code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing


;
	org	100h
;
start:
	mov ax,3				; Képernyőtörléshez módbeállítás kódja
	int 10h					; Video BIOS hívás a törléshez
	mov cx,txtlen				; Ennyiszer kell kiírni
	mov dx,offset amitki			; A kiíratandó szöveg címe
	mov ah,9				; A string kiíratás kódja
	mov di,dx				; A string címe
ciklus:
	int 21h					; A DOS hívása kiírásra

	mov byte ptr [di],' '	; Szóközzel helyettesítem
	inc di					; Lépek a kövekező karakter helyére
	loop ciklus				; Csinálom ciklusban
kilep:
	mov ah,4ch				; A kilépés kódja
	int 21h					; A DOS hívása kilépésre

amitki	db	'Assembly'
txtlen	EQU	$ - amitki			; Meghatározom a szöveg hosszát
	db	13, 10, '$'			; A végére CR és LF jön
code	ends
	end	start

