; 2. pelda

.model tiny
.data
  betu db 'A'
.code
org 100h
start:
  mov ax,3
  int 10h

  mov cx,26
  ciklus:
    mov ah,2
    mov dl,betu
    int 21h
    inc betu

    mov ah,8
    int 21h

    cmp al,27
    je kilepes
  loop ciklus

  kilepes:
  int 20h
end start
