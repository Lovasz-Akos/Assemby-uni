code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K‚r‚s ‚s m¢d be ll¡t s
        int     10h                     ; A Video BIOS h¡v sa
        mov     dx,offset suokis        ; A sz”veg c¡me
        mov     ah,9                    ; A ki¡rat s k‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa sz”vegki¡rat sra
        mov     cx,10                   ; Ennyi let‚st v rok
varako:
        mov     ah,8                    ; Let‚s beolvas s n‚m n k¢dja
        int     21h                     ; DOS h¡v sa let‚sv r sra 
        cmp     al,27                   ; ppen az ESC volt?
        jz      befeje                  ; Igen, akkor ki is l‚pek
        cmp     al,'q'                  ; ppen a 'q' volt?
        jz      befeje                  ; Igen, akkor ki is l‚pek
        cmp     al,'Q'                  ; ppen a 'Q' volt?
        jz      befeje                  ; Igen, akkor ki is l‚pek
        mov     dl,al                   ; DL <- ki¡ratand¢ karakterd
        mov     ah,2                    ; A ki¡rat s k‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa sz”vegki¡rat sra
        loop    varako                  ; Ha maradt m‚g, visszamegy
befeje:
	mov	ah,4ch
        int     21h
                                                
suokis  db      'šss le 10 db billentyût!',13,10,'$'

code	ends
	end	start

                      
