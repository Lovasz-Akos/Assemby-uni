; 9. pelda

.model tiny
.data
  szoveg1 db 'A parametersor hossza: $'
  szoveg2 db ' bajt',10,13,'Tartalma: $'
  hiba db 'Irjon a parametersorba!$'
.code

org 80h
hossz db ?

org 100h
start:
  mov ax,3
  int 10h

  cmp hossz,0
  jne tovabb
    mov ah,9
    mov dx,offset hiba
    int 21h
    int 20h
  tovabb:
    mov ah,9
    mov dx,offset szoveg1
    int 21h
    mov ah,2
    mov dl,hossz
    add dl,'0'
    int 21h
    mov ah,9
    mov dx,offset szoveg2
    int 21h

    ; --- 1. megoldas ---

    xor ch,ch
    mov cl,hossz
    mov ah,2
    mov si,81h
    ciklus:
      mov dl,[si]
      int 21h
      inc si
    loop ciklus

    ; --- 2. megoldas ---

    mov si,81h
    xor bh,bh
    mov bl,hossz
    add si,bx
    mov [si],byte ptr '$'
    mov ah,9
    mov dx,81h
    int 21h
  int 20h
end start
