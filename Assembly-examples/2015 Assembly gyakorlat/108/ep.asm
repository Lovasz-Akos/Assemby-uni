code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3							; Képernyötörléshez módváltás kód
	int	10h								; Törlés VIDEO BIOS-sal
	mov	ax,1							; Eger megjelenítés kódja
	int	33h								; Egérdriver hívása
	mov	di,0ffffh						; X másolat
	mov	bp,0ffffh						; Y másolat
varege:
	mov	ah,1							; Leütésvizsgálat kódja
	int	16h								; Klavi BIOS kezelése
	jz	nemvol							; Nincs leütés
	mov	ah,0							; Leütésvárás kódja
	int	16h								; Klavi BIOS kezelése
	cmp	al,27							; ESC volt?
	jz	kilep							; Igen, akkor ki is lépek
nemvol:
	mov	ax,3							; Pozíció kódja
	int	33h								; Egérdriver hívása
	cmp	cx,di							; Azonosak az X pozíciók
	jnz	eltapo							; Eltérés van
	cmp	dx,bp							; Azonosak az y pozíciók
	jz	joapos							; Eltérés nincs
eltapo:
	mov	di,cx							; Ez az új X érték
	mov	bp,dx							; Ez az új Y érték
	mov	ax,2							; Eger kikapcsolás kódja
	int	33h								; Egérdriver hívása
	mov	dx,offset xpossz				; Szövegcím
	mov	ah,9							; Stringkiíratás kódja
	int	21h								; Dos-sal kiíratom
	mov	ax,di							; Ezt kell kírnia
	mov	cl,3							; Ennyiszer léptetem lefele
	shr	ax,cl							; 8-al osztom
	call axdeko							; Kiteszem az X értékét
	mov	dx,offset ypossz				; Szövegcím
	mov	ah,9							; Stringkiíratás kódja
	int	21h								; Dos-sal kiíratom
	mov	ax,bp							; Ezt kell kírnia
	mov	cl,3							; Ennyiszer léptetem lefele
	shr	ax,cl							; 8-al osztom
	call axdeko							; Kiteszem az Y értékét
	mov	dx,offset marsps				; Szövegcím
	mov	ah,9							; Stringkiíratás kódja
	int	21h								; Dos-sal kiíratom
	mov	ax,1							; Eger megjelenítés kódja
	int	33h								; Egérdriver hívása
joapos:
	jmp	varege							; Egér várakozás
kilep:
	mov	ax,2							; Eger kikapcsolás kódja
	int	33h								; Egérdriver hívása
	mov	ah,4ch
	int	21h

axdeko:
	mov	bx,10							; Ezzel osztogatok
	mov	si,sp							; Itt tart a stack
cikben:
	xor	dx,dx							; A felsõ rész törlése
	div	bx								; Elosztom 10-el
	push dx								; A maradékot stackre helyezem
	or ax,ax							; Nulla lett már?
	jnz	cikben							; Még nem, újra
	mov	ah,2							; Egy karakter kiíratásának kódja
ujchr:
	pop	dx								; Vissza a maradékot
	or	dl,'0'							; Karakterré alakítom
	int	21h								; Kiteszem a karaktert
	cmp	si,sp							; Van még?
	jnz	ujchr							; Még van benne
	ret									; Kitettem
	
	
xpossz	db	'X=$'
ypossz	db	' Y=$'
marsps	db	'                  ',13,'$'
	
code	ends
	end	start

