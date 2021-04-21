code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; Képernyőtörléshez módbeállítás kódja
	int 10h					; Video BIOS hívás a törléshez

	mov dx,offset hibast			; Szövegcím (a hibát feltételezem)
	mov ah,9				; String kiírás kódja
	mov si,80h				; A számláló címe
	lodsb					; AL <- [80h], majd INC SI is
	mov cl,al				; Átmásolom (CX lesz a számláló)
	mov ch,0				; CX <- darabszám
	jcxz ninika				; Nincs parancssor, hibakiíratásra ugrok
	inc si					; SI <- 82h azaz a parancssor címe

	mov dx,offset bekerk			; Szövegcím
	mov ah,9				; String kiírás kódja
	int 21h					; DOS hívása kiíratásra

	mov ah,1				; Visszahangos beolvasás kódja
	int 21h					; DOS hívása beolvasásra
	mov ah,al				; Átmásolom, mert a LODSB AL-be olvas majd be

	mov bl,'0'				; Kezdő számláló
vizsac:
	lodsb					; Beolvasom a kitett karaktert
	cmp al,0dh				; Az 'Enter' volt?
	jz ittave				; Igen, befejeztem
	cmp al,ah				; Azonosak?
	jnz vizsac				; Nem, akkor nem számolom
	inc bl					; Növelem a számlálót
	jmp vizsac				; Vissza a növelés után (nem LOOP !!!!!!)
ittave:
	mov dx,offset nemfor			; Szövegcím (ezt feltételezem)
	mov ah,9				; String kiírás kódja
	cmp bl,'0'				; Maradt a CL 0-ban?
	jz ninika				; Igen, azaz nem fordult elő
	mov dx,offset elofor			; Szövegcím (Most már ez lesz)
	int 21h					; DOS hívása kiíratásra
	mov ah,2				; Karakter kiírás kódja
	mov dl,bl				; Az előfordulások száma (karakterben!)
ninika:
	int 21h					; DOS hívása kiíratásra
	mov ah,4ch				; A kilépés kódja
	int 21h					; A DOS hívása kilépésre

bekerk	db	'Melyik karaktert vizsgáljam? $'
elofor	db	13, 10, 'Az előfordulások száma: $'
nemfor	db	13, 10, 'Nem fordult elő!$'
hibast	db	'Nincs elemezendő parancsor! Kilépek!$'

code	ends
	end	start

