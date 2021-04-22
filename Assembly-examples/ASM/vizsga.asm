code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup
    
    mov ah,9					;string write
    mov dx,offset tajeko        
    int 21h                     ;kiirja a tajekoztatot

    mov bl, 00000000b

ciklus:
    mov ah, 1
    int 21h
    
    cmp al, 'a'
    jz leuta
    cmp al, 'b'
    jz leutb
    cmp al, 'c'
    jz leutc
    jmp ciklus

leuta:
    or bl, 00000011b
    jmp done

leutb:
    or bl, 00001100b
    jmp done

leutc:
    or bl, 00110000b
    jmp done

done:
    cmp bl, 00111111b
    jz kilep
    jnz ciklus

kilep:
	mov ah,4ch					;kil‚p‚s
	int 21h						;dos kil‚p‚s

tajeko db 'A program akkor ‚r v‚get, ha az ABC betûket b rmilyen sorrendben leti', 13,10, '$'

code	ends
	end	start
