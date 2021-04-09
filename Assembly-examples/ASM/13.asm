code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
    mov ax,3
    int 10h

    mov ah,9
    mov dx, offset szia
    int 21h
    mov cx,5                    ;ennyi karaktert v runk, (5)
    mov si,offset nevtar        ;ide tarolja a nevet

karvar:
    mov ah,1                    ;echo-s beolvas
    int 21h
    mov [si],al                 ;kiteszem az olvasott karaktert az si altal cimzett tarba, azaz a nevtar offsetbe
    inc si                      ;kovetkezo karaktert ne ugyanoda irja
    loop karvar                 ;karakter v r s ciklusba

    mov ah,9
    mov dx, offset hello
    int 21h

    mov cx,5
    mov si, offset nevtar

karkit:
    mov dl,[si]
    inc si
    mov ah,2
    int 21h
    loop karkit

    mov ah,9
    mov dx, offset hellov
    int 21h
    jmp exit

exit:
	mov ah,4ch					;kil‚p‚s
	int 21h						;dos kil‚p‚s

szia db 'Hogy h¡vnak? $'
hello db 13,10,'Szia, $'
hellov db '!$'
nevtar db ?,?,?,?,?

code	ends
	end	start
