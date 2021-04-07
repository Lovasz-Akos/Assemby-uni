code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3							; K�perny�t�rl�shez m�dv�lt�s k�d
	int	10h								; T�rl�s VIDEO BIOS-sal
	mov	ax,1							; Eger megjelen�t�s k�dja
	int	33h								; Eg�rdriver h�v�sa
	mov	di,0ffffh						; X m�solat
	mov	bp,0ffffh						; Y m�solat
varege:
	mov	ah,1							; Le�t�svizsg�lat k�dja
	int	16h								; Klavi BIOS kezel�se
	jz	nemvol							; Nincs le�t�s
	mov	ah,0							; Le�t�sv�r�s k�dja
	int	16h								; Klavi BIOS kezel�se
	cmp	al,27							; ESC volt?
	jz	kilep							; Igen, akkor ki is l�pek
nemvol:
	mov	ax,3							; Poz�ci� k�dja
	int	33h								; Eg�rdriver h�v�sa
	cmp	cx,di							; Azonosak az X poz�ci�k
	jnz	eltapo							; Elt�r�s van
	cmp	dx,bp							; Azonosak az y poz�ci�k
	jz	joapos							; Elt�r�s nincs
eltapo:
	mov	di,cx							; Ez az �j X �rt�k
	mov	bp,dx							; Ez az �j Y �rt�k
	mov	ax,2							; Eger kikapcsol�s k�dja
	int	33h								; Eg�rdriver h�v�sa
	mov	dx,offset xpossz				; Sz�vegc�m
	mov	ah,9							; Stringki�rat�s k�dja
	int	21h								; Dos-sal ki�ratom
	mov	ax,di							; Ezt kell k�rnia
	mov	cl,3							; Ennyiszer l�ptetem lefele
	shr	ax,cl							; 8-al osztom
	call axdeko							; Kiteszem az X �rt�k�t
	mov	dx,offset ypossz				; Sz�vegc�m
	mov	ah,9							; Stringki�rat�s k�dja
	int	21h								; Dos-sal ki�ratom
	mov	ax,bp							; Ezt kell k�rnia
	mov	cl,3							; Ennyiszer l�ptetem lefele
	shr	ax,cl							; 8-al osztom
	call axdeko							; Kiteszem az Y �rt�k�t
	mov	dx,offset marsps				; Sz�vegc�m
	mov	ah,9							; Stringki�rat�s k�dja
	int	21h								; Dos-sal ki�ratom
	mov	ax,1							; Eger megjelen�t�s k�dja
	int	33h								; Eg�rdriver h�v�sa
joapos:
	jmp	varege							; Eg�r v�rakoz�s
kilep:
	mov	ax,2							; Eger kikapcsol�s k�dja
	int	33h								; Eg�rdriver h�v�sa
	mov	ah,4ch
	int	21h

axdeko:
	mov	bx,10							; Ezzel osztogatok
	mov	si,sp							; Itt tart a stack
cikben:
	xor	dx,dx							; A fels� r�sz t�rl�se
	div	bx								; Elosztom 10-el
	push dx								; A marad�kot stackre helyezem
	or ax,ax							; Nulla lett m�r?
	jnz	cikben							; M�g nem, �jra
	mov	ah,2							; Egy karakter ki�rat�s�nak k�dja
ujchr:
	pop	dx								; Vissza a marad�kot
	or	dl,'0'							; Karakterr� alak�tom
	int	21h								; Kiteszem a karaktert
	cmp	si,sp							; Van m�g?
	jnz	ujchr							; M�g van benne
	ret									; Kitettem
	
	
xpossz	db	'X=$'
ypossz	db	' Y=$'
marsps	db	'                  ',13,'$'
	
code	ends
	end	start

