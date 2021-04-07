; 5. pelda

.model tiny
.data
  hiba db 'Param‚terk‚nt k‚rek k‚t kisbett!',7,'$'
.code

org 80h
  hossz db ?
  db ?
  betu1 db ?
  betu2 db ?

org 100h
start:
  mov ax,3
  int 10h

  cmp hossz,3
  je tovabb
    mov ah,9
    mov dx,offset hiba
    int 21h
    int 20h
  tovabb:

  hurok:
    mov ah,2
    mov dl,betu1
    int 21h
    inc betu1

    mov ah,8
    int 21h

    cmp al,27
    je kilepes

    mov al,betu1
    dec al
    cmp al,betu2
  jne hurok

  kilepes:
  int 20h
end start
