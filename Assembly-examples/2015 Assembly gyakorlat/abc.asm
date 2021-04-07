code    segment para   public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢d Çs k¢d
        int     10h                     ; Video BIOS h°v†sa
        mov     dx,offset escszo        ; A szîveg c°me
        mov     ah,9                    ; A ki°rat†skÇrÇs k¢dja
        int     21h                     ; A DOS h°v†sa ki°rat†sra
        mov     cx,26                   ; Ennyiszer fusson a ciklus
        mov     dl,'a'                  ; Kezdã karakter
cikkor:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; A DOS h°v†sa leÅtÇsv†r†sra 
        cmp     al,27                   ; êppen az ESC karakter?
        jz      befeje                  ; Igen, akkor vÇge van
;;;;        mov     dl,bl                   ; DL <- ki°ratand¢ karakter
        mov     ah,2                    ; A ki°rat†skÇrÇs k¢dja
        int     21h                     ; A DOS h°v†sa ki°rat†sra
        inc     dl                      ; A kîvetkezãre
        loop    cikkor                  ; Ha maradt mÇg belãle, akkor vissza
befeje:
	mov	ah,4ch
        int     21h

escszo  db      'ESC= vÇge!', 13, 10, '$'

code	ends
	end	start

                                        
