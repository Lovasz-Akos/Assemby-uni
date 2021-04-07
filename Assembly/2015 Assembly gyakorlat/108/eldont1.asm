code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3							; Képernyötörléshez módváltás kód
	int	10h								; Törlés VIDEO BIOS-sal
	mov	dx,offset mittes				; Szövegcím
	mov	ah,9							; String kiíratás kódja
	int	21h								; Kiíratom DOS-sal
	mov	cx,10							; Ennyit várok
kabeoc:
	mov	ah,8							; Néma leütésvárás kódja
	int	21h								; Leütésvárás DOS-sal
	cmp	al,27							; Éppen ESC volt?
	jz	kilep							; Igen, akkor kilépek
	cmp	al,'Q'							; Éppen 'Q' volt?
	jz	kilep							; Igen, akkor kilépek
	cmp	al,'q'							; Éppen 'q' volt?
	jz	kilep							; Igen, akkor kilépek
	mov	dl,al							; Innen ír ki
	mov	ah,2							; Egy karakter kiíratása
	int	21h								; Kiíratom DOS-sal
	mov	dx,offset emobet				; Szövegcím
	cmp	al,'9'							; Enneél nagyobb?
	ja	emobek							; Igen, akkor marad a szöveg
	mov	dx,offset emosza				; Szövegcím
emobek:
	mov	ah,9							; String kiíratás kódja
	int	21h								; Kiíratom DOS-sal
	loop	kabeoc						; Ciklusban
kilep:
	mov	ah,4ch
	int	21h

mittes	db	'Usson le maximum 10 betut vagy szamot, ESC, q, Q - vege', 13, 10, '$'
emobet	db	'-betu', 13, 10, '$'
emosza	db	'-szam', 13, 10, '$'
	
code	ends
	end	start

