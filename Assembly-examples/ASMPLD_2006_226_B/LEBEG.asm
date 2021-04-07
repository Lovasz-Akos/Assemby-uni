code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ah,4ch


	int	21h

adat    dd      1.0
        dd      1998.0



code	ends
	end	start

