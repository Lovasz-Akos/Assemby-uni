code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3					;80x25
	int	10h						;vid bios
	mov ah,9					;string ki¡r s
	mov dx,offset tajeko		;a sz”veg maga
	
	mov ah,4c					;kil‚p‚s
	int 21h						;dos kil‚p‚s

code	ends
	end	start
