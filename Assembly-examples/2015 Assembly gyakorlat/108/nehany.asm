code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3			; M�dbe�ll�t�s k�dja
	int	10h			; K�perny�t�rl�s VIDEO-BIOS-sal
uszake:
	mov	dx,offset hanyat	; Sz�vegc�m
	mov	ah,9			; String ki�rat�s k�dja
        int     21h                     ; DOS-sal ki�rom
	mov	ah,1			; Visszhangos le�t�sv�r�s k�dja
	int	21h			; DOS-sal beolvasok
	cmp	al,13			; Csak Return?
	jnz	hanere			; Nem, akkor tov�bb
	mov	dx,offset kapjal	; Sz�vegc�m
	mov	ah,9			; String ki�rat�s k�dja
        int     21h                     ; DOS-sal ki�rom
	jmp	uszake			; �jra megk�rdezem
hanere:
	mov	cl,al			; �tm�solom
	and	cx,0fh			; Maszk a sz�mon
ubetuk:
	mov	dx,offset mitkii	; Sz�vegc�m
	mov	ah,9			; String ki�rat�s k�dja
        int     21h                     ; DOS-sal ki�rom
	mov	ah,1			; Visszhangos le�t�sv�r�s k�dja
	int	21h			; DOS-sal beolvasok
	cmp	al,13			; Csak Return?
	jnz	hanerb			; Nem, akkor tov�bb
	mov	dx,offset kapjal	; Sz�vegc�m
	mov	ah,9			; String ki�rat�s k�dja
        int     21h                     ; DOS-sal ki�rom
	jmp	ubetuk			; �jra megk�rdezem
hanerb:
	mov	bl,al			; K�s�bbre
	mov	ah,2			; Egy karakter ki�r�s k�dja
	mov	dl,13			; CR karakter
        int     21h                     ; DOS-sal ki�rom
	mov	dl,10			; LF karakter
        int     21h                     ; DOS-sal ki�rom
	mov	dl,bl			; Amit ki kell tenni
karkic:
        int     21h                     ; DOS-sal ki�rom
	loop	karkic			; Ciklusban t�bbsz�r
	mov	ah,4ch
	int	21h

	
hanyat	db	13, 10, 'Kerek egy szamot: $'
mitkii	db	13, 10, 'Es egy karaktert: $'
kapjal	db	13, 10, 'Hiba vaaaaaaaaan!$'	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	db	650 dup(33)
	
	
	
	
code	ends
	end	start

