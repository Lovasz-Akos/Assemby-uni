code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3			; M�dbe�ll�t�s k�dja
	int	10h			; K�perny�t�rl�s VIDEO-BIOS-sal

	mov	ah,2			; Egy karakter ki�r�s k�dja
	mov	cx,5			; Ennyivel beljebb
	mov	dl,10			; LF
lejjeb:
        int     21h                     ; DOS-sal ki�rom
	loop	lejjeb			; Ciklusban t�bbsz�r
	call	osoror			; Egy O sor
	call	kereso			; Keret sor
	call	kereso			; Keret sor
	call	kereso			; Keret sor
	call	kereso			; Keret sor
	call	kereso			; Keret sor
	call	osoror			; Egy O sor
	mov	ah,4ch
	int	21h

	
	
	
osoror:
	call	becsu			; Beljebb
	mov	cx,40			; Ennyivel beljebb
	mov	dl,'O'			; Ezt
beljeb:
        int     21h                     ; DOS-sal ki�rom
	loop	beljeb			; Ciklusban t�bbsz�r
	mov	dl,13			; CR
        int     21h                     ; DOS-sal ki�rom
	mov	dl,10			; LF
        int     21h                     ; DOS-sal ki�rom
	ret				; K�sz

	
	
kereso:
	call	becsu			; Beljebb
	mov	dl,'O'			; Ezt
	int     21h                     ; DOS-sal ki�rom
	mov	cx,38			; Ennyivel beljebb
	mov	dl,' '			; Ezt
kokici:
	int     21h                     ; DOS-sal ki�rom
	loop	kokici
sorkoz:
	mov	dl,'O'			; Ezt
	int     21h                     ; DOS-sal ki�rom
	mov	dl,13			; CR
        int     21h                     ; DOS-sal ki�rom
	mov	dl,10			; LF
        int     21h                     ; DOS-sal ki�rom
	ret				; K�sz

becsu:
	mov	cx,20			; Ennyivel beljebb
	mov	dl,' '			; Ezt
beljek:
        int     21h                     ; DOS-sal ki�rom
	loop	beljek			; Ciklusban t�bbsz�r
	ret				; Vissza
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	db	650 dup(33)
	
	
	
	
code	ends
	end	start

