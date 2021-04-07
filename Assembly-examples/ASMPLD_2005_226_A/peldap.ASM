code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
       mov ax,3
      int 10h
      mov dx,offset szoveg
      mov ah,9
      int 21h
      mov     ah,4ch
     int     21h
        

szoveg: db'Mi a fene van itt?',10,13,'$'
code	ends
	end	start

