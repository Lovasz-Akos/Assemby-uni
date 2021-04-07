; 8. pelda

.model tiny
.data
  szoveg db 'Kilepes az "a" ennyie'
  db 'dik lenyomasara, vagy Esc!$'
  szoveg1 db 'Kerek egy szamot: $'
  ujsor db 10,13,'$'
  szamlalo db ?
  escape equ 27
.code

org 100h
start:
  mov ax,3
  int 10h

  mov ah,9
  mov dx,offset szoveg1
  int 21h

  mov ah,1
  int 21h

  sub al,'0'
  mov szamlalo,al

  mov ah,9
  mov dx,offset ujsor
  int 21h
  mov dx,offset szoveg
  int 21h
  mov dx,offset ujsor
  int 21h

  vissza:
    mov ah,8
    int 21h

    cmp al,escape
    je kilepes

    cmp al,'a'
    jne tovabb
      dec szamlalo
      cmp szamlalo,0
      je kilepes
    tovabb:
    mov ah,2
    mov dl,al
    int 21h
  jmp vissza

  kilepes:
  int 20h
end start
