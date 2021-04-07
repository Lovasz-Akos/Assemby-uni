code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3			; Módbeállítás kódja
	int	10h			; Képernyõtörlés VIDEO-BIOS-sal

	mov	ah,2			; Egy karakter kiírás kódja
	mov	cx,5			; Ennyivel beljebb
	mov	dl,10			; LF
lejjeb:
        int     21h                     ; DOS-sal kiírom
	loop	lejjeb			; Ciklusban többször
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
        int     21h                     ; DOS-sal kiírom
	loop	beljeb			; Ciklusban többször
	mov	dl,13			; CR
        int     21h                     ; DOS-sal kiírom
	mov	dl,10			; LF
        int     21h                     ; DOS-sal kiírom
	ret				; Kész

	
	
kereso:
	call	becsu			; Beljebb
	mov	dl,'O'			; Ezt
	int     21h                     ; DOS-sal kiírom
	mov	cx,38			; Ennyivel beljebb
	mov	dl,' '			; Ezt
kokici:
	int     21h                     ; DOS-sal kiírom
	loop	kokici
sorkoz:
	mov	dl,'O'			; Ezt
	int     21h                     ; DOS-sal kiírom
	mov	dl,13			; CR
        int     21h                     ; DOS-sal kiírom
	mov	dl,10			; LF
        int     21h                     ; DOS-sal kiírom
	ret				; Kész

becsu:
	mov	cx,20			; Ennyivel beljebb
	mov	dl,' '			; Ezt
beljek:
        int     21h                     ; DOS-sal kiírom
	loop	beljek			; Ciklusban többször
	ret				; Vissza
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	db	650 dup(33)
	
	
	
	
code	ends
	end	start

