code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

sorsza  EQU     40
zaszso  EQU     200
kezdop  EQU     (((200 - (3 * sorsza)) * 320) / 2) + ((320 - zaszso) / 2)

	    org	    100h


start:
    mov ax,0a000h               ;grafikus terulet szegmens erteke
    mov es,ax                   ;beletesszuk az es be
	mov ax,13h					;320x200 (MCGA) mode
    int 10h                     ;video bios interrupt


    mov dx,3c8h                 ;szinszam cime i/o teruleten
    mov al,0                    ;hatterszin cime
    out dx,al                   ;kitoltom a szinszamot
    inc dx

    mov al,0

    out dx,al                   ;red
    out dx,al                   ;green

    mov al,63
    out dx,al                   ;blue

    mov di,kezdop               ;zaszlo kezdo pont
    mov al,1                    ;elso szin

szinki:
    mov cx,zaszso
szicik:
    mov es:[di],al
    inc di
    loop szicik
    add di,320 - zaszso

    pop cx
    loop sziciki

    inc al
    cmp al,4
    jnz szinki

    mov ah,8
    int 21h

    mov ax,3
    int 10h
    
	mov ah,4ch					;kil‚p‚s
	int 21h						;dos kil‚p‚s

code	ends
	end	start
