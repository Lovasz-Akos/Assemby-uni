code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h

buflen  EQU     78                      ; A puffer hosza

start:
        mov     ax,3                    ; M¢dv†lt†s k¢dja kÇpernyãtîrlÇshez
        int     10h                     ; 80x25-îs sz°nes Åzemm¢dra VGA BIOS
        xor     di,di                   ; Ez az alaphelyzet (nincs leÅtÇs)
strkii:
        mov     dx,offset taldrb        ; Szîvegc°m
        mov     ah,9                    ; Stringki°rat†s k¢dja
        int     21h                     ; A DOS h°v†sa ki°rat†sra
vartov:
        mov     ah,1                    ; BIOS leÅtÇsfigyelÇs k¢dja
        int     16h                     ; BIOS leÅtÇsfigyelÇs h°v†sa
        jnz     valami                  ; Volt leÅtÇs
        mov     ax,3                    ; EgÇrparamÇterek beolvas†sa
        int     33h                     ; EgÇrkezelÇs
        mov     si,offset taldrb        ; Szîvegc°m a karakterhez
        mov     al,[si]                 ; Ezt v†ltoztatom
        mov     cx,bx                   ; M†solat az eredeti †llapotr¢l
        xor     bx,di                   ; ôsszehasonl°t†s
        and     bx,0000000000000011b    ; Csak a kÇt als¢ bit sz†m°t
        mov     di,cx                   ; Most m†r ez az alap†llapot
        jz      vartov                  ; Nincs v†ltoz†s
        test    bx,0000000000000001b    ; Melyik gomb az?
        jz      jobbgo                  ; A jobb volt az (Nem a bal. :-)
        test    cx,0000000000000001b    ; A bal le van nyomva?
        jz      vartov                  ; Nincs, akkor v†rok tov†bb
        cmp     al,'9'                  ; M†r itt tart?
        jz      vartov                  ; Igen, nem birizg†lom
        inc     al                      ; A kîvetkezãre
        mov     [si],al                 ; Ezt ki is teszem
        jmp     strkii                  ; Èjra kiteszem
jobbgo:
        test    cx,0000000000000010b    ; A jobb le van nyomva?
        jz      vartov                  ; Nincs, akkor v†rok tov†bb
        cmp     al,'1'                  ; M†r itt tart?
        jz      vartov                  ; Igen, nem birizg†lom
        dec     al                      ; Az elãzãre
        mov     [si],al                 ; Ezt ki is teszem
        jmp     strkii                  ; Èjra kiteszem
valami:
        mov     ah,0                    ; BIOS leÅtÇsv†r†s k¢dja
        int     16h                     ; BIOS leÅtÇsv†r†s h°v†sa
        cmp     al,27                   ; Az ESC volt az?
        jnz     vartov                  ; V†rok tov†bb


        mov     ah,4ch
        int     21h         

taldrb  db      '1', 8, '$'

code	ends
	end	start

