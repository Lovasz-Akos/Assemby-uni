code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
                                                               

start:
        mov     ax,3                            ; K‚perny‹t t”rl‚shez m¢d
        int     10h                             ; VIDEO BIOS-sal t”rl‚s
        mov     ax,1                            ; Eg‚rkurzor megjelen¡t‚s
        int     33h                             ; Az eg‚r driver h¡v sa
lekeci:
        mov     ax,3                            ; µllapotlek‚rdez‚s k¢dja
        int     33h                             ; Az eg‚r driver h¡v sa
        or      cx,dx                           ; Nulla lett?
        jz      kilprg                          ; Igen, kil‚pek
        cmp     bx,[gombaa]                     ; Azonosak a r‚givel?
        jz      lekeci                          ; Azonosak, £jra k‚rdezek
        mov     [gombaa],bx                     ; Nem, ez az £j ‚rt‚k
        mov     dx,offset egysem                ; Az egyik sem sz”veg c¡me
        or      bx,bx                           ; Egyik sem?
        jz      ezbizi                          ; Igen, j¢ a DX-ben a c¡m
        mov     dx,offset egyiks                ; A bal gomb sz”veg c¡me
        dec     bx                              ; A bal gomb? (1 volt?)
        jz      ezbizi                          ; Igen, j¢ a DX-ben a c¡m
        mov     dx,offset masiks                ; A jobb gomb sz”veg c¡me
        dec     bx                              ; A bal gomb? (2 volt?)
        jz      ezbizi                          ; Igen, j¢ a DX-ben a c¡m
        mov     dx,offset mindke                ; Mindk‚t gomb sz”veg c¡me
ezbizi:
        mov     ax,2                            ; Eg‚rkurzor eltûntet‚s
        int     33h                             ; Az eg‚r driver h¡v sa
        mov     ah,9                            ; String ki¡rat s k¢dja
        int     21h                             ; Kiteszem DOS-sal
        mov     ax,1                            ; Eg‚rkurzor megjelen¡t‚s
        int     33h                             ; Az eg‚r driver h¡v sa
        jmp     lekeci                          ; Megyek £jra lek‚rdezni
kilprg:
        mov     ax,2                            ; Eg‚rkurzor eltûntet‚s
        int     33h                             ; Az eg‚r driver h¡v sa
	mov	ah,4ch
        int     21h
                                        
egyiks  db      'Bal      ', 9 dup (8),'$'
masiks  db      'Jobb     ', 9 dup (8),'$'
mindke  db      'Mindkett‹', 9 dup (8),'$'
egysem  db      'Egyik sem', 9 dup (8),'$'

gombaa  dw      1111111111111111b


code	ends
	end	start

                                             
