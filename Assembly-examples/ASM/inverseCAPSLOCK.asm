code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					                ;80x25 konzol setup
	int 10h						                ;video bios interrup
    
    mov ah,9					                ;9-string writer, 8-silent read, 1-visible read,  2-single write
    mov dx,offset tajeko        
    int 21h                                     ;kiirja a tajekoztatot
    
ciklus:
    mov ah,8
    int 21h

    cmp al, 27
    jz kilep

    cmp al, 90
    jbe upperc
    cmp al, 97
    jae lowerc

upperc:
    mov bl, al
    add bl, 32
    mov ah, 2
    mov dl, bl
    int 21h
    jmp ciklus

lowerc:
    mov bl, al
    sub bl, 32
    mov ah, 2
    mov dl, bl
    int 21h
    jmp ciklus

kilep:
	mov ah,4ch					;kilépés
	int 21h						;dos kilépés

tajeko db 'Megfordítja a betüket', 13, 10, '$'

code	ends
	end	start
