code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ah,4ch					;kil�p�s
	int 21h						;dos kil�p�s

code	ends
	end	start
