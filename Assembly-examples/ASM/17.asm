code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup

	mov bx,'99'
ciklus:
	mov ah,2
	mov dl,bh
	int 21h
	mov dl,bl
	int 21h
	mov dl,13
	int 21h
	mov dl,10
	int 21h

	cmp bx,'01'				;if 1
	jz kilep				;end

	dec bl					;}
	cmp bl,'0'				;|
	jae blrend				; >	ha 0-t elerte az also szamjegy, felteszi 9re es a felso szamjegyet csokkenti
	mov bl,'9'				;|
	dec bh					;}

blrend:
	mov ah,8				;silent read
	int 21h
	cmp al,27				;if esc
	jnz ciklus				;mehet tovabb

kilep:
	mov ah,4ch					;kil‚p‚s
	int 21h						;dos kil‚p‚s

code	ends
	end	start
