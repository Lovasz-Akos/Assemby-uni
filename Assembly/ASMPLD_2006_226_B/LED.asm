code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     al,edh
        out     60h,al
	mov	ah,4ch
	int	21h

code	ends
	end	start

