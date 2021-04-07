code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        xor     ax,ax                   ; AX <- 0
        int     33h                     ; Eg‚rdriver h¡v sa
        or      ax,ax                   ; Van eg‚rdriver?
        jnz     taldrv                  ; Van driver
        jmp     nindrv                  ; Nincs eg‚rdriver
taldrv:
        mov     ax,3                    ; K‚perny‹t”rl‚s lesz a m¢dv lt sb¢l
        int     10h                     ; M¢dv lt s, azaz k‚perny‹t”rl‚s
;
; Bekapcsolom az eg‚rpointert
;
        mov     ax,1                    ; AX <- eg‚rpointer megjelen¡‚s
        int     33h                     ; Eg‚rdriver h¡v sa
;
; Megn‚zem, hogy alappoz¡ci¢n van-e
;
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        or      cx,dx                   ; Nulla?
        jnz     nemnup                  ; Nem ott van
;
; ppen ott van sz”vegk¡rat s
;
        mov     si,offset viddon        ; Ez kell ki¡ratni
        call    sorkii                  ; Kiteszem a sz”veget
;
; Megn‚zem, hogy alappoz¡ci¢n van-e m‚g mindig
;
alvarp:
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        or      cx,dx                   ; Nulla?
        jz      alvarp                  ; M‚g ott van
;
; Els‹ sz”veg kit‚tele
;
nemnup:
        mov     si,offset balfel        ; Ez kell ki¡ratni
        call    sorkii                  ; Kiteszem a sz”veget
varkat:
        call    katvar                  ; Kattint sra v rok
        jz      varkat                  ; M‚g nem kattintottak
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        or      cx,dx                   ; Nulla?
        jnz     varkat                  ; Nincs m‚g ott
;
; M sodik sz”veg kit‚tele
;
        mov     si,offset jobfel        ; Ez kell ki¡ratni
        call    sorkii                  ; Kiteszem a sz”veget
varkjf:
        call    katvar                  ; Kattint sra v rok
        jz      varkjf                  ; M‚g nem kattintottak
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        or      dx,dx                   ; Nulla?
        jnz     varkjf                  ; Nincs m‚g ott
        cmp     cx,79 * 8               ; El‚rt a v‚g‚t?
        jb      varkjf                  ; Nem, nincs m‚g ott
;
; Harmadik sz”veg kit‚tele
;
        mov     si,offset jobals        ; Ez kell ki¡ratni
        call    sorkii                  ; Kiteszem a sz”veget
varkja:
        call    katvar                  ; Kattint sra v rok
        jz      varkja                  ; M‚g nem kattintottak
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        cmp     dx,24 * 8               ; El‚rt a v‚g‚t?
        jb      varkja                  ; Nem, nincs m‚g ott
        cmp     cx,79 * 8               ; El‚rt a v‚g‚t?
        jb      varkja                  ; Nem, nincs m‚g ott
;
; Negyedik sz”veg kit‚tele
;
        mov     si,offset balals        ; Ez kell ki¡ratni
        call    sorkii                  ; Kiteszem a sz”veget
varkba:
        call    katvar                  ; Kattint sra v rok
        jz      varkba                  ; M‚g nem kattintottak
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        cmp     dx,24 * 8               ; El‚rt a v‚g‚t?
        jb      varkba                  ; Nem, nincs m‚g ott
        or      cx,cx                   ; El‚rt azelej‚re?
        jnz     varkba                  ; Nem, nincs m‚g ott
;
; Kil‚pek
;
        mov     si,offset uresor        ; Ez kell ki¡ratni
        call    sorkii                  ; Kiteszem a sz”veget
        mov     ax,2                    ; AX <- eg‚rpointer kikapcsol s
        int     33h                     ; Eg‚rdriver h¡v sa
        jmp     csakil                  ; Sim n kil‚pek
nindrv:
        mov     dx,offset ninszo        ; Sz”vegc¡m
        mov     ah,9                    ; DOS ki¡rat s k¢dja
        int     21h                     ; DOS h¡v s ki¡r sra
csakil:
	mov	ah,4ch
	int	21h


;
; Katint sra v rok
;
katvar:
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,011b                 ; Valamelyik lenyomva?
        jz      ninmel                  ; M‚g egyik sincs lenyova
;
; Megv rom m¡g elengedi
;
megvan:
        mov     ax,3                    ; AX <- eg‚r  llapot beolvas s
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,011b                 ; Valamelyik lenyomva?
        jnz     megvan                  ; M‚g nincs elengedve
        or      al,1                    ; Nem z‚r¢ st tus
ninmel:
        ret                             ; K‚sz, st tusszal vissza
;
; A sor ki¡rat sa
;
sorkii:
        mov     ax,2                    ; AX <- eg‚rpointer kikapcsol s
        int     33h                     ; Eg‚rdriver h¡v sa
        mov     ax,0b800h               ; A k‚perny‹terlet szegmensc¡me
        mov     es,ax                   ; ES a k‚perny‹terletre
        mov     cx,80                   ; Ennyi a ciklusv ltoz¢
        mov     di,11 * 80 * 2          ; Itt a 12. sor eleje
szokip:
        mov     al,[si]                 ; Ez a kiteend‹ karakter
        mov     es:[di],al              ; Kitettem a terletre
        inc     si                      ; µtl‚pem a karaktert
        add     di,2                    ; µtl‚pem a k‚perny‹ poz¡ci¢t
        loop    szokip                  ; Ciklusban pakolom ki
        mov     ax,1                    ; AX <- eg‚rpointer megjelen¡‚s
        int     33h                     ; Eg‚rdriver h¡v sa
        ret                             ; Kipakol s k‚sz

;                01234567890123456789012345678901234567890123456789012345678901234567890123456789
viddon  db      '                           Vidd onnan el az egeret!                             '
jobfel  db      '          Mozgasd a jobb fels” sarokba az eg‚rkurzort, majd kattints!           '
balfel  db      '         Mozgasd a bal fels” sarokba az eg‚rkurzort, majd kattints!             '
balals  db      '          Mozgasd a bal als¢ sarokba az eg‚rkurzort, majd kattints!             '
jobals  db      '          Mozgasd a jobb als¢ sarokba az eg‚rkurzort, majd kattints!            '
uresor  db      '                                                                                '

ninszo  db      'Nincs eg‚rdriver!', 10, 13, '$'

code	ends
	end	start

