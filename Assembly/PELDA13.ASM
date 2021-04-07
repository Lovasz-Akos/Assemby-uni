; 13. pelda

.model tiny
.data
  szin1 db 0,0,0,63
  szin2 db 1,63,0,0
  szin3 db 1,63,63,0
.code
org 100h
start:
  mov ax,13h
  int 10h

  mov si,offset szin1
  call szin
  mov si,offset szin2
  call szin

  mov ax,0a000h
  mov es,ax
  mov al,1
  xor di,di
  mov cx,200
  ciklus:
    mov es:[di],al
    mov es:[di+1],al
    mov es:[di+2],al
    add di,321
  loop ciklus

  mov ah,8
  int 21h

  mov si,offset szin3
  call szin

  mov ah,8
  int 21h

  mov ax,3
  int 10h
  int 20h

  szin proc
    mov dx,3c8h
    mov al,[si]
    out dx,al
    inc dx
    mov al,[si+1]
    out dx,al
    mov al,[si+2]
    out dx,al
    mov al,[si+3]
    out dx,al
    ret
  szin endp
end start
