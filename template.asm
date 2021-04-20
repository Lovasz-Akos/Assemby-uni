code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup
    
    mov ah,9					;9-string writer, 8-silent read, 1-visible read,  2-single write
    mov dx,offset tajeko        
    int 21h                     ;kiirja a tajekoztatot
    
    jmp kilep

kilep:
	mov ah,4ch					;kil‚p‚s
	int 21h						;dos kil‚p‚s

tajeko db '$'

code	ends
	end	start
