; 12. pelda

.model tiny
.data
  szoveg db 'Kilepes Esc-re!$'
.code
org 100h
start:
  mov ax,3
  int 10h

  mov ah,9
  mov dx,offset szoveg
  int 21h

  vissza:
    mov bl,010b
    call led
    call bill
    cmp bl,1
    je kilepes
    call idohuzas
    xor bl,bl
    call led
    call bill
    cmp bl,1
    je kilepes
    call idohuzas
  jmp vissza

  kilepes:
  int 20h

  led proc
    mov al,0edh
    out 60h,al
    xor cx,cx
    ciklus:
      nop
    loop ciklus
    mov al,bl
    out 60h,al
    ret
  led endp

  bill proc
    xor bl,bl
    mov ax,100h
    int 16h
    jz ki
      mov ah,8
      int 21h
      cmp al,27
      jne ki
      mov bl,1
    ki:
    ret
  bill endp

  idohuzas proc
    mov cx,200
    c1:
      push cx
      xor cx,cx
      c2:
        nop
      loop c2
      pop cx
    loop c1
    ret
  idohuzas endp
end start
