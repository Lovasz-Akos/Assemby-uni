code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s k¢dja
        int     10h                     ; Video BIOS h°v†sa a tîrlÇshez
        mov     dx,offset szoveg        ; Szîvegc°m
        mov     ah,9                    ; String ki°r†s k¢dja
        int     21h                     ; DOS h°v†sa ki°r†sra
ciklus:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        mov     ah,2                    ; Karakter ki°r†s k¢dja
        cmp     al,27                   ; êppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Innen kell ki°ratnom
        int     21h                     ; DOS h°v†sa ki°r†sra
vizsga:
        cmp     dl,'a'                  ; êppen az 'a' volt?
        jnz     ciklus                  ; Nem az volt, kezdem az elejÇn
;
; Az 'a' m†r le volt Åtve, v†rok 'b'-t
;
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        mov     ah,2                    ; Karakter ki°r†s k¢dja
        cmp     al,27                   ; êppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Innen kell ki°ratnom
        int     21h                     ; DOS h°v†sa ki°r†sra
        cmp     dl,'b'                  ; êppen a 'b' volt?
        jnz     vizsga                  ; Nem az volt, kezdem az '-'-val
;
; Az 'a' Çs a 'b' m†r le volt Åtve, v†rok 'c'-t
;
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        mov     ah,2                    ; Karakter ki°r†s k¢dja
        cmp     al,27                   ; êppen az ESC?
        jz      abbaha                  ; Igen, akkor abba is hagyom
        mov     dl,al                   ; Innen kell ki°ratnom
        int     21h                     ; DOS h°v†sa ki°r†sra
        cmp     dl,'c'                  ; êppen a 'c' volt?
        jnz     vizsga                  ; Nem az volt, kezdem az '-'-val
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

