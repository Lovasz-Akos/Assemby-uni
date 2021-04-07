code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov	ah,4ch			; A kilépés kódja
	int	21h			; A DOS hívása kilépésre

code	ends
	end	start

