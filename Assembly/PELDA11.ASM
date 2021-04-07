; 11. pelda

.model tiny
.data
  szoveg1 db 'Nyomja le a jobb Shiftet!',10,13,'$'
  szoveg2 db 'Engedje fel!',10,13,'$'
.code
org 100h
start:
  mov ax,3
  int 10h

  mov ah,9
  mov dx,offset szoveg1
  int 21h

  vissza1:
    mov ah,2
    int 16h
    ror al,1
  jnc vissza1

  mov ah,9
  mov dx,offset szoveg2
  int 21h

  vissza2:
    mov ah,2
    int 16h
    ror al,1
  jc vissza2

  int 20h
end start
