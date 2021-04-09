code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov	ax,3					            ;80x25
	int	10h						            ;vid bios
	
    mov ah,9					            ;string ki°r†s
	mov dx,offset tajeko		            ;a szîveg maga
    int 21h                                 ;DOS ki°rat†s
    
    xor bx,bx                               ;BX = 0
	
ujleut:
    mov ah,8                                ;nÇma leÅtÇs
    int 21h                                 

    cmp al,27                               ;esc k¢dja 27 decim†l
    jz  kilep                               ;ha igen akkor kilÇp

    inc bx                                  ;leÅtîtt gombokat sz†moljuk

    mov ah,2                                ;1 karakter °r†s, DL-bãl
    mov dl,al                               ;a leÅtîtt gomb dl-be

    mov cx,bx                               ;ennyiszer kell kirni ciklusban

karcik:
    int 21h
    loop karcik
    jmp ujleut
    
kilep:
    mov ah,4ch					            ;kilÇpÇs
	int 21h						            ;dos kilÇpÇs

tajeko  db  'hello world',13,10, '$'        ;text stored

code	ends
	end	start