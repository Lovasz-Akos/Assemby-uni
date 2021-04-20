code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; Képernyőtörléshez módváltás
        int     10h                     ; Video Bios hívása törléshez
        mov     bx,1                    ; Ennyivel kezdünk
ujsoki:
        mov     si,offset asstxt        ; Itt kezdünk
        mov     cx,bx                   ; Átteszem a ciklusszámot
        mov     ah,2                    ; Egy karakter kiíratás kódja
kakici:
        mov     dl,[si]                 ; Ez a karakter a kiíratandó
        inc     si                      ; Lépek a következőre
        int     21h                     ; Kiírom DOS-sal
        loop    kakici                  ; Ciklusban
        mov     dl,13                   ; CR karakter
        int     21h                     ; Kiírom DOS-sal
        mov     dl,10                   ; LF karakter
        int     21h                     ; Kiírom DOS-sal
        inc     bx                      ; Következő mennyiség
        cmp     bx,betnum               ; Van még hátra?
        jbe     ujsoki                  ; Mehet ki újra

        mov     ah,4ch
        int     21h

asstxt  db      'Assembly'
betnum  equ     $-asstxt


code	ends
	end	start