code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s k¢dja
        int     10h                     ; Video BIOS h°v†sa a tîrlÇshez
        mov     dx,offset szoveg        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
        xor     bx,bx                   ; Nincs mÇg semmilyen
ciklus:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        cmp     al,27                   ; êppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; µtteszem a ki°ratand¢t
        int     21h                     ; DOS h°v†sa ki°r†sra
        or      bx,bx                   ; Nem volt mÇg 'a' leÅtÇs?
        jnz     voltma                  ; Volt m†r legal†bb az 'a'
atvizs:
        cmp     al,'a'                  ; êppen az 'a'?
        jnz     ciklus                  ; Nem az, akkor marad
        inc     bx                      ; BX <- 1
        jmp     ciklus                  ; Mehet tov†bb
;
; BX nem nulla, azaz volt m†r 'a' vagy 'ab'
;
voltma:
        cmp     bx,1                    ; Volt m†r 'b' is?
        jnz     voltmb                  ; Igen, volt m†r az 'ab'
        cmp     al,'b'                  ; êppen a 'b'?
        jnz     ujaviz                  ; Nem az, akkor kezdje az 'a'-n†l
        inc     bx                      ; BX <- 2
        jmp     ciklus                  ; Mehet tov†bb
;
; BX nem nulla, nem egy, azaz volt m†r 'ab'
;
voltmb:
        cmp     al,'c'                  ; êppen a 'c'?
        jz      abbaha                  ; Igen, akkor be is fejezem
;
; Nem a 'b' vagy nem a 'c' lett leîÅtve, 'a'-t kell elãkÇsz°teni
;
ujaviz:
        xor     bx,bx                   ; MÇg nem volt semmi
        jmp     atvizs                  ; Az 'a'-t fogom megvizsg†lni
;
; A vÇgÇre CR Çs LF kitÇtele, hogy eleg†nsabban nÇzzen ki. AH mÇg mindig 2!
;
abbaha:
        mov     dl,13                   ; A vÇgÇre CR (hogy szebb legyen)
        int     21h                     ; DOS h°v†sa ki°r†sra
        mov     dl,10                   ; A vÇgÇre LF (hogy szebb legyen)
        int     21h                     ; DOS h°v†sa ki°r†sra
	mov	ah,4ch
	int	21h

szoveg  db      'a, b, c-re vagy  ESC-re vÇge!',13,10,'$'

code	ends
	end	start

