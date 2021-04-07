code    segment para    public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; T°pus k¢dja
        int     10h                     ; M¢d be†ll°t†ssal kÇpernyã tîrlÇs
        mov     ah,9                    ; Szîvegki°rat†s k¢dja
        mov     dx,offset szoveg        ; Szîvegc°m DX-be
        int     21h                     ; DOS h°v†sa ki°rat†sra
        mov     cx,10                   ; Maximum ennyit
ciklus:
        mov     ah,8                    ; NÇma bekÇrÇs k¢dja
        int     21h                     ; DOS h°v†s beolvas†sra
        cmp     al,27                   ; ESC volt?
        jz      kilepes                 ; Igen, befejezem
        cmp     al,'q'                  ; A leÅtÇs 'q' volt?
        jz      kilepes                 ; Igen, befejezem
        cmp     al,'Q'                  ; A leÅtÇs 'Q' volt?
        jz      kilepes                 ; Igen, befejezem
        mov     ah,9                    ; Szîvegki°rat†s k¢dja
        mov     dx,offset egyszo        ; Szîvegc°m
        cmp     al,'1'                  ; êppen az 1-es?
        jz      ponteg                  ; Most Çppen az
        mov     dx,offset ketszo        ; Szîvegc°m
        cmp     al,'2'                  ; êppen a 2-es?
        jz      ponteg                  ; Most Çppen az
        mov     dx,offset harszo        ; Szîvegc°m
        cmp     al,'3'                  ; êppen a 3-as?
        jz      ponteg                  ; Most Çppen az
        mov     dl,al                   ; Most csak a m†solatot °rom ki
        mov     ah,2                    ; Egy karakter kitÇtele
ponteg:
        int     21h                     ; DOS m˚velet kÇrÇs
        loop    ciklus                  ; Ha maradt mÇg, visszalÇpek
kilepes:
	mov	ah,4ch
	int	21h


szoveg  db      'össîn le billenty˚ket!',10,13,'$'
egyszo  db      'EGY$'
ketszo  db      'KETTä$'
harszo  db      'HµROM$'

code	ends
	end	start

