code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
    mov ax,3
    int 10h

    mov ah,9
    mov dx, offset szia
    int 21h
    mov cx,11                   ;ennyi karaktert v†runk, (11), ez fontos hogy ittlegyen, dosboxban neml†tod mire j¢ de technikailag kell
    mov si,offset nevtar        ;ide tarolja a nevet

karvar:
    mov ah,8
    int 21h
    mov [si],al                 ;kiteszem az olvasott karaktert az si altal cimzett tarba, azaz a nevtar offsetbe
    cmp al,13                   ;enter volt az utolso gomb?
    jz  karveg                  ;ha igen akkor vege a ciklusnak
    mov ah,2
    mov dl,al
    int 21h
    inc si                      ;kovetkezo karaktert ne ugyanoda irja
    loop karvar                 ;karakter v†r†s ciklusba

karveg:
    mov ah,9
    mov dx,offset hello
    int 21h

    mov si,offset nevtar
    mov ah,2

kitene:
    mov dl,[si]                ;t†rb¢l ki°rja a karaktereket
    int 21h
    inc si
    cmp byte ptr [si],13        ;enterhez ÇrtÅnk m†r?
    jnz kitene                  ;ha nem akkor mehet tov†bb

    mov dl,'!'
    int 21h

	mov ah,4ch					;kilÇpÇs
	int 21h						;dos kilÇpÇs

szia db 'Hogy hivnak? $'
hello db 13,10,'Szia, $'
nevtar db 11 dup(?)

code	ends
	end	start