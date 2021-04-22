code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
	;mov ax,3					;80x25 konzol setup
	;int 10h						;video bios interrup
    
    mov bl, 97                  ;'a' ASCII 

    mov ah,9                    ;string write
    mov dx,offset tajeko        
    int 21h                     ;kiirja a tajekoztatot

betuki:
    mov cx, 4                   ;loop 5 times :)

    mov ah,8                    ;silent read            
    int 21h

    cmp al, 32                  ;if space
    jz stepovr

    cmp al, 08                  ;if backspace
    jz stepundr

    cmp al, 'q'                  ;if q
    jz kilep
    cmp al, 'Q'                  ;if Q
    jz kilep
    cmp al, 27                   ;if esc
    jz kilep

    mov ah,2                    ;single char write from dl
    mov dl, bl       
    int 21h    
    inc bl     
    jmp betuki                  ;keep loopin

stepovr:                        ;ha space akkor 5szor incrementeli a bl-t es kiirja
    inc bl
    loop stepovr 
    mov ah,2
    mov dl, bl       
    int 21h                  
    jmp betuki

stepundr:                        ;ha backspace akkor 5szor decrementeli a bl-t es kiirja
    dec bl
    loop stepundr
    mov ah,2
    mov dl, bl       
    int 21h
    jmp betuki
    
kilep:
	mov ah,4ch					;kil�p�s
	int 21h						;dos kil�p�s

tajeko db 'Esc,q,Q,space,Bksp',13,10,'$'

code	ends
	end	start
