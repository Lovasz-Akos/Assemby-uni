; 4. pelda

.model tiny
.data
  hiba db 'Param‚terk‚nt k‚rek egy kisbett!',7,'$'
.code

org 80h
  hossz db ?
  db ?
  betu db ?

org 100h
start:
  mov ax,3
  int 10h

  cmp hossz,2
  je tovabb
    mov ah,9
    mov dx,offset hiba
    int 21h
    int 20h
  tovabb:

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
