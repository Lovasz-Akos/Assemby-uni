code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3					            ;80x25
	int	10h						            ;vid bios
	
    mov ah,9					            ;string ki?r?s
	mov dx,offset tajeko		            ;a sz?veg maga
    int 21h                                 ;DOS ki?rat?s
    mov bl,0
	
kiirci:
    mov ah,8                                ;n?ma le?t?s
    int 21h                                 

    cmp al,27                               ;esc k?dja 27 decim?l
    jz  kilep                               ;ha igen akkor kil?p

    cmp al,' '
    jz nemasz
    xor bl,00000001b
    jmp kiirci    

nemasz:                       
    test bl,00000001b
    jnz kiirci
    mov ah,2                                ;1 karakter ?r?s, DL-b?l
    mov dl,al                               ;a le?t?tt gomb dl-be
    int 21h
    jmp kiirci                              

kilep:
    mov ah,4ch					            ;kil?p?s
	int 21h						            ;dos kil?p?s

tajeko  db  'hello world',13,10, '$'        ;text stored

code	ends
	end	start