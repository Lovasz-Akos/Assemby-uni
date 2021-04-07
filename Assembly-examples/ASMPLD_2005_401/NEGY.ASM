code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h
darab   db      ?                       ; Itt tal lhat¢ a parancs hossza
	org	100h
start:
        mov     ax,3                    ; 80 x 25-”s sz¡nes m¢d k¢dja
        int     10h                     ; VIDEO BIOS h¡v s be ll¡t sra
        mov     cl,[darab]              ; CL <- a parancssor mennyis‚ge
        mov     ch,0                    ; CX <- a parancssor mennyis‚ge
        jcxz    kevpas                  ; Ha CX nulla, akkor nincs param‚ter
        dec     cx                      ; Az els‹ sz¢k”z nem sz m¡t
        jcxz    kevpas                  ; Ha nulla lett, akkor sem j¢
        mov     si, offset darab + 2    ; Az els‹ karakter c¡me
        add     si,cx                   ; Az utols¢ra l‚pek
        mov     byte ptr [si],'$'       ; Lez r s kit‚tel
ciklus:
        dec     si                      ; Visszafele l‚pkedem
        push    cx                      ; Elromlana
        dec     cx                      ; Egyel kevesebbet kell
        jcxz    nospac                  ; Nem ¡rok ki SPACE-t
        mov     dl,' '                  ; SPACE k¢dja (ezt ¡rom ki)
        mov     ah,2                    ; A ki¡rat s k¢dja
spacik:
        int     21h                     ; A DOS megh¡v sa karakterki¡r sra
        loop    spacik                  ; Sz¢k”zki¡rat¢ ciklus
nospac:
        mov     dx,si                   ; DX-be m solom a ki¡rat s c¡m‚t
        mov     ah,9                    ; Sz”vegkit‚tel
        int     21h                     ; A DOS megh¡v sa sz”vegki¡r sra
        mov     ah,2                    ; A ki¡rat s k¢dja
        mov     dl,10                   ; Az LF k¢dja
        int     21h                     ; A DOS megh¡v sa karakterki¡r sra
        mov     dl,13                   ; A CR k¢dja
        int     21h                     ; A DOS megh¡v sa karakterki¡r sra
        mov     ah,8                    ; Let‚skiv r s, majd beolvas s k¢dja
        int     21h                     ; A DOS megh¡v sa beolvas sra
        pop     cx                      ; Vissza a darabsz m
        loop    ciklus                  ; A darabsz mmal ciklus
kilep:
	mov	ah,4ch
	int	21h
kevpas:
        mov     dx,offset tilta         ; Sz”vegc¡m
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        int     21h                     ; DOS h¡v s ki¡rat sra
        jmp     kilep                   ; Kil‚pek

tilta   db      'Nem lett megadva parancssor!', 10, 13, '$'

code	ends
	end	start

