code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h


start:
        mov     ax,3                    ; M¢dv†lt†s k¢dja kÇpernyãtîrlÇshez
        int     10h                     ; 80x25-îs sz°nes Åzemm¢dra VGA BIOS
        mov     dx,offset tajeko        ; Szîvegc°m
        mov     ah,9                    ; Stringki°r†s k¢dja
        int     21h                     ; DOS h°v†s ki°rat†sra
        mov     bx,1                    ; Ennyivel kezdjen
ciklus:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        cmp     al,1bh                  ; êppen az ESC az?
        jz      kilep                   ; Igen, ki is lÇpek
        mov     cx,bx                   ; µtm†solom a darabsz†mot
        mov     dl,al                   ; A beolvasott karakter †tad†sa
        mov     ah,2                    ; Karekterki°r†s k¢dja
kiirat:
        int     21h                     ; DOS h°v†s ki°rat†sra
        loop    kiirat
        inc     bx                      ; Egyel tîbbszîr
        jmp     ciklus                  ; Vissza a kîvetkezã leÅtÇsv†r†sra
kilep:
        mov     ah,4ch             
        int     21h

tajeko  db      'össÇl le billenty˚ket!',13,10,'$'

code	ends
	end	start

