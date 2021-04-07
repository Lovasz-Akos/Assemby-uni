code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h


start:
        mov     ax,3                    ; M¢dv lt s k¢dja k‚perny‹t”rl‚shez
        int     10h                     ; 80x25-”s sz¡nes zemm¢dra VGA BIOS
        mov     dx,offset tajeko        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡r s k¢dja
        int     21h                     ; DOS h¡v s ki¡rat sra
ciklus:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; DOS h¡v sa let‚sv r sra
        cmp     al,1bh                  ; ppen az ESC az?
        jz      kilep                   ; Igen, ki is l‚pek
        cmp     al,' '                  ; ppen a sz¢k”z?
        jz      felfug                  ; Igen, akkor a felfggeszt‚sre megy
        mov     dl,al                   ; A beolvasott karakter  tad sa
        mov     ah,2                    ; Karekterki¡r s k¢dja
        int     21h                     ; DOS h¡v s ki¡rat sra
        jmp     ciklus                  ; Vissza a k”vetkez‹ let‚sv r sra
felfug:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; DOS h¡v sa let‚sv r sra
        cmp     al,1bh                  ; ppen az ESC az?
        jz      kilep                   ; Igen, ki is l‚pek
        cmp     al,' '                  ; ppen a sz¢k”z?
        jz      ciklus                  ; Igen, akkor visszamegyek
        jmp     felfug                  ; V rok tov bbi let‚seket
kilep:
        mov     ah,4ch             
        int     21h

tajeko  db      'šss‚l le billentyûket!',13,10,'$'

code	ends
	end	start

