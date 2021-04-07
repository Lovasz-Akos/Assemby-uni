; 7. pelda

.model tiny
.data
  szoveg db 'Kilepes az "a" 3. le'
  db 'nyomasara, vagy Esc!',10,13,'$'
  szamlalo db 0
  escape equ 27
.code

org 100h
start:
  mov ax,3
  int 10h

  mov ah,9
  mov dx,offset szoveg
  int 21h

  vissza:
    mov ah,8
    int 21h

    cmp al,escape
    je kilepes

    cmp al,'a'
    jne tovabb
      inc szamlalo
      cmp szamlalo,3
      je kilepes
    tovabb:
    mov ah,2
    mov dl,al
    int 21h
  jmp vissza

  kilepes:
  int 20h
end start
