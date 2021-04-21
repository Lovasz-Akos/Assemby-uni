code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup
    
    mov ah,9					;string write
    mov dx,offset tajeko        
    int 21h                     ;kiirja a tajekoztatot
    
    jmp kilep

kilep:
	mov ah,4ch					;kilépés
	int 21h						;dos kilépés

tajeko db '$'

code	ends
	end	start
