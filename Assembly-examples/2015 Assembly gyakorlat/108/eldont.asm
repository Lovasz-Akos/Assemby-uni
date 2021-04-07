code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3							; K�perny�t�rl�shez m�dv�lt�s k�d
	int	10h								; T�rl�s VIDEO BIOS-sal
	mov	dx,offset mittes				; Sz�vegc�m
	mov	ah,9							; String ki�rat�s k�dja
	int	21h								; Ki�ratom DOS-sal
	mov	cx,10							; Ennyit v�rok
kabeoc:
	mov	ah,8							; N�ma le�t�sv�r�s k�dja
	int	21h								; Le�t�sv�r�s DOS-sal
	cmp	al,27							; �ppen ESC volt?
	jz	kilep							; Igen, akkor kil�pek
	cmp	al,'Q'							; �ppen 'Q' volt?
	jz	kilep							; Igen, akkor kil�pek
	cmp	al,'q'							; �ppen 'q' volt?
	jz	kilep							; Igen, akkor kil�pek
	mov	dl,al							; Innen �r ki
	mov	ah,2							; Egy karakter ki�rat�sa
	int	21h								; Ki�ratom DOS-sal
	mov	dx,offset emobet				; Sz�vegc�m
	cmp	al,'9'							; Enne�l nagyobb?
	ja	emobek							; Igen, akkor marad a sz�veg
	mov	dx,offset emosza				; Sz�vegc�m
emobek:
	mov	ah,9							; String ki�rat�s k�dja
	int	21h								; Ki�ratom DOS-sal
	loop	kabeoc						; Ciklusban
kilep:
	mov	ah,4ch
	int	21h

mittes	db	'Usson le maximum 10 betut vagy szamot, ESC, q, Q - vege', 13, 10, '$'
emobet	db	'-betu', 13, 10, '$'
emosza	db	'-szam', 13, 10, '$'
	
code	ends
	end	start

