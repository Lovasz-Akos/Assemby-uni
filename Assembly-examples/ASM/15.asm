code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup
	
    mov ah,9
    mov dx,offset szambe
    int 21h

    mov ah,1                    ;visible read
    int 21h
    ;cmp al,13                   ;if enter
    ;jz  hibair
    cmp al,'1'
    jb hibair
    cmp al,'9'
    ja hibair

    mov cl,al                   ;letarolom az olvasott szamot a cx aljaba

    mov ah,9
    mov dx,offset betube
    int 21h
    mov ah,1
    int 21h
    cmp al,13
    jz hibair

    mov bl,al                   ;store letter
    mov ah,9
    mov dx,offset crlfst        ;line break

    int 21h
    mov dl,bl                   ;move letter to write part

    and cx,0000000000001111b    ;CX-bol csak az also 4 bitet tartom meg

    mov ah,2
ciklus:
    int 21h
    loop ciklus
    jmp kilepes

hibair:
    mov ah,9
    mov dx,offset hibauz
    int 21h
    jmp kilepes

kilepes:
	mov ah,4ch					;kil�p�s
	int 21h						;dos kil�p�s

szambe db 'Kerek egy szamot: $'
hibauz db 13, 10, 'Hibas szam!$'
betube db 13, 10, 'Kerek egy betut: $'
crlfst db 13, 10, '$'

code	ends
	end	start
