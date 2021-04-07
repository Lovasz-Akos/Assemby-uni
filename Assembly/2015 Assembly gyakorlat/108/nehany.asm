code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3			; Módbeállítás kódja
	int	10h			; Képernyõtörlés VIDEO-BIOS-sal
uszake:
	mov	dx,offset hanyat	; Szövegcím
	mov	ah,9			; String kiíratás kódja
        int     21h                     ; DOS-sal kiírom
	mov	ah,1			; Visszhangos leütésvárás kódja
	int	21h			; DOS-sal beolvasok
	cmp	al,13			; Csak Return?
	jnz	hanere			; Nem, akkor tovább
	mov	dx,offset kapjal	; Szövegcím
	mov	ah,9			; String kiíratás kódja
        int     21h                     ; DOS-sal kiírom
	jmp	uszake			; Újra megkérdezem
hanere:
	mov	cl,al			; Átmásolom
	and	cx,0fh			; Maszk a számon
ubetuk:
	mov	dx,offset mitkii	; Szövegcím
	mov	ah,9			; String kiíratás kódja
        int     21h                     ; DOS-sal kiírom
	mov	ah,1			; Visszhangos leütésvárás kódja
	int	21h			; DOS-sal beolvasok
	cmp	al,13			; Csak Return?
	jnz	hanerb			; Nem, akkor tovább
	mov	dx,offset kapjal	; Szövegcím
	mov	ah,9			; String kiíratás kódja
        int     21h                     ; DOS-sal kiírom
	jmp	ubetuk			; Újra megkérdezem
hanerb:
	mov	bl,al			; Késõbbre
	mov	ah,2			; Egy karakter kiírás kódja
	mov	dl,13			; CR karakter
        int     21h                     ; DOS-sal kiírom
	mov	dl,10			; LF karakter
        int     21h                     ; DOS-sal kiírom
	mov	dl,bl			; Amit ki kell tenni
karkic:
        int     21h                     ; DOS-sal kiírom
	loop	karkic			; Ciklusban többször
	mov	ah,4ch
	int	21h

	
hanyat	db	13, 10, 'Kerek egy szamot: $'
mitkii	db	13, 10, 'Es egy karaktert: $'
kapjal	db	13, 10, 'Hiba vaaaaaaaaan!$'	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	db	650 dup(33)
	
	
	
	
code	ends
	end	start

