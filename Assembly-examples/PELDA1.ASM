; 1. pelda

.model tiny
.code
org 100h
start:
  mov ax,3
  int 10h

  mov ah,2
  mov dl,'A'
  mov cx,26
  ciklus:
    int 21h
    inc dl
  loop ciklus

  int 20h
end start
