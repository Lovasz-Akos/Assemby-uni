; 6. pelda

.model tiny
.data
  koord db 0
  betu db 'A'
.code

org 100h
start:
  mov ax,3
  int 10h

  mov ah,2
  mov cx,25
  ciklus:
    xor bx,bx
    mov dh,koord
    mov dl,koord
    int 10h

    mov dl,betu
    int 21h

    inc koord
    inc betu
  loop ciklus

  kilepes:
  int 20h
end start
