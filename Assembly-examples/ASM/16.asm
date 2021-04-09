code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

    org 80h
darabs db ?                     ;darabs-ba teszi hogy mennyi parameter van
hataro db ?                     ;a program es a parameterek hatarolo karaktere
parsor db 126 dup(?)            ;a parameterek karakterei

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup
    
    cmp byte ptr [80h],0        ;van egyaltalan parameter?
    


    
    mov ah,9
    mov dx,offset bekero
    int 21h

    mov di,offset szovta
    mov bx, di
kereks:
    mov ah, 8
    int 21h

    mov [di],al         ;move read char to offset szovta
    cmp al,13           ;if enter
    jz  akbeve
    inc di

    mov ah,2
    mov dl,al
    int 21h
    jmp kereks          ;keep reading
	
akbeve:
    cmp di,bx               ;ha igaz, akkor ures a string
    jz hibaki
   
    mov ah,9
    lea dx,[karbek]
    int 21h

    mov ah,1
    int 21h
    xor cx,cx

karker:
    cmp byte ptr [bx],13    ;ha enter
    jz  kerveg

    cmp [bx],al             ;is curr di equal curr read
    jnz eznemaz
    inc cx

eznemaz:
    inc bx
    jmp karker

kerveg:
    lea dx,[nemfor]
    or  cx,cx           ;cx 0?
    jz  nemfok          ;nincs benne a keresett kar
    lea dx,[talszo]
    mov ah,9
    int 21h
    add cl,'0'
    mov dl,cl
    mov ah,2
    int 21h
    jmp kilep


hibaki:
    mov ah,9
    mov dx,offset hibakod
    int 21h
    jmp kilep

nemfok:
    mov ah,9
    int 21h
    jmp kilep

kilep:
	mov ah,4ch					;kil‚p‚s
	int 21h						

bekero db 'Kerlek adj meg egy szoveget. Befejezes "Enter"-el.',13,10,'$'
karbek db 13,10,'Kerlek add meg a keresett karaktert: $'
szovta db 80 dup(?)
hibakod db 13,10,'Hiba $'
nemfor db 13,10,'Nem fordul elo$'
talszo db 13,10,'Talalatok szama: $'

code	ends
	end	start