code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	mov ax,3					;80x25 konzol setup
	int 10h						;video bios interrup

    mov ah,9                    ;ah9 a string kiiras
    mov dx,offset tajeko
    int 21h
    
    mov cx,10

karcik:
    mov ah,8
    int 21h                     ;nema leutesre var, azaz nem irja ki konzolra amit nyomok
    
    cmp al,1bh                  ;if esc
    jz kilep

    cmp al,'Q'                  ;if Q
    jz kilep

    cmp al,'q'                  ;if q
    jz kilep

    mov ah,2                    ;echo leutesre var
    mov dl,al                   ;utoljara olvasottat kiirom
    int 21h

    mov dx,offset betusz        ;alapbol ugy veszem h betu

    cmp al,'9'                  ;ha nagyobb mint 9, azaz betu
    ja nagyobb                  ;ja = jump above, akkor ugrik. (if al < 9)

    mov dx,offset szamsz        ;ha nem betu akkor szam

nagyobb:
    mov ah,9
    int 21h
    loop karcik

kilep:
	mov ah,4ch					;kilépés
	int 21h						;dos kilépés

tajeko db 'usson le max 10 gombot, esc, q, Q = kilepes!',13,10,'$'
szamsz db '-szam', 13,10, '$'
betusz db '-betu', 13,10, '$'

code	ends
	end	start
