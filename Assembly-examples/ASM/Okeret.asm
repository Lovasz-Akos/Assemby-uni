code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

kezosz	EQU	20				; A kezdő oszlop értéke
oszele	EQU	40				; Ennyi széles legyen a keret
kezsor	EQU	5				; Ebben a sorban kezdjen
kermag	EQU	8				; Ennyi magas legyen a keret


start:
	mov ax,3				; Képernyőtörléshez módbeállítás kódja
	int 10h					; Video BIOS hívás a törléshez
	mov ax,0b800h				; A képernyő-memória szegmenscíme
	mov es,ax				; Ez lesz a képernyő memőria szegmesregisztere
	mov al,'O'				; Ezt tegye ki (keret elem)
;
	mov di,(kezsor * (2 * 80)) + (kezosz * 2); DI a kezdő pozícióra
	call kipaci				; Kiteszem
;

	add di,((80 - kezosz - oszele + kezosz) * 2); A következő sor elejére
	mov cx,kermag - 2			; Az első és utolsó miatt a -2!
kozcik:
	stosb					; AL (azaz 'O' betű) kitétele

	add	di,((oszele - 2) * 2) + 1	; Ide jön a következő 'O' betű
	stosb					; AL (azaz 'O' betű) kitétele
	add di,((80 - kezosz - oszele + kezosz) * 2) + 1; A következő sor elejére
	loop kozcik				; Kiteszegetem ciklusban a köztes sorokat
	call kipaci				; A záró sor kitétele
	mov ah,4ch				; A kilépés kódja
	int 21h					; A DOS hívása kilépésre
;
kipaci:
	mov cx,oszele				; Ennyi 'O' betű széles legyen
cikbep:
	stosb					; Kiteszem AL értékét
	inc di					; Átlépem a színinformációkat
	loop cikbep				; Kiteszem ciklusban
	ret					; Kész vagyok

code	ends
	end	start

