; 10. pelda

.model tiny
.data
  szoveg1 db 'Mozgassa az egeret a bal felso sarokba!',10,13,'$'
  szoveg2 db 'Nyomja le a jobb egergombot!',10,13,'$'
  szoveg3 db 'Engedje fel!',10,13,'$'
.code
org 100h
start:
  mov ax,3
  int 10h

  mov ah,9
  mov dx,offset szoveg1
  int 21h

  vissza1:
    mov ax,3
    int 33h
    cmp cx,0
    jne vissza1
    cmp dx,0
  jne vissza1

  mov ah,9
  mov dx,offset szoveg2
  int 21h

  vissza2:
    mov ax,3
    int 33h
    cmp bx,2
  jne vissza2

  mov ah,9
  mov dx,offset szoveg3
  int 21h

  vissza3:
    mov ax,3
    int 33h
    cmp bx,0
  jne vissza3

  int 20h
end start
