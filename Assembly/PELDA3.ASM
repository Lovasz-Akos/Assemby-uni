; 3. pelda

.model tiny
.data
  szoveg db 'KÇrek egy kisbetÅt: $'
  betu db ?
.code
org 100h
start:
  mov ax,3
  int 10h

  mov ah,9
  mov dx,offset szoveg
  int 21h

  mov ah,1
  int 21h
  mov betu,al

  mov ah,2
  mov dl,10
  int 21h
  mov dl,13
  int 21h

  hurok:
    mov ah,2
    mov dl,betu
    int 21h
    inc betu

    mov ah,8
    int 21h

    cmp al,27
    je kilepes

    cmp betu,'z'+1
  jne hurok

  kilepes:
  int 20h
end start
