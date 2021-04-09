code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup
	
	mov ah,4ch					;kil‚p‚s
	int 21h						;dos kil‚p‚s

code	ends
	end	start
