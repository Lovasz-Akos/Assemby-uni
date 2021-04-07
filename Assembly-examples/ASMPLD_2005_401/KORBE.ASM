code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        xor     ax,ax                   ; AX <- 0
        int     33h                     ; Eg‚rdriver h¡v sa
        or      ax,ax                   ; Nulla maradt?
        jz      ninege                  ; Nincs eg‚r
;
; Van eg‚rdriver, k‚perny‹t”rl‚s j”n
;
        mov     ax,3                    ; M¢dv lt s k¢dja
        int     10h                     ; T”rl‚s m¢dv lt ssal
;
; A kurzor l that¢v  t‚tele, majd ki¡r s
;
        mov     ax,1                    ; Kurzor l that¢v  t‚tel k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        mov     si,offset balfel        ; Sz”vegc¡m
        call    sorkii                  ; K‚perny‹ k”zep‚re
;
; Kiv rom, hogy a bal fels‹ sarokba vigy‚k
;
nibafe:
        call    egerke                  ; Kattint s v r s
        or      cx,dx                   ; Ott van?
        jnz     nibafe                  ; Igen, v rok
;
; Oda vitt‚k, k”vetkez‹
;
        mov     si,offset jobfel        ; Sz”vegc¡m
        call    sorkii                  ; K‚perny‹ k”zep‚re
;
; Kiv rom, hogy a jobb fels‹be kerlj”n
;
nijofe:
        call    egerke                  ; Kattint s v r s
        or      dx,dx                   ; Y koordin ta nulla?
        jnz     nijofe                  ; Nem nulla
        cmp     cx,79 * 8               ; A v‚g‚n van?
        jb      nijofe                  ; Nem, v rok
;
; Oda vitt‚k, k”vetkez‹
;
        mov     si,offset jobals        ; Sz”vegc¡m
        call    sorkii                  ; K‚perny‹ k”zep‚re
;
; Kiv rom, a jobb als¢ba vigy‚k
;
nijoal:
        call    egerke                  ; Kattint s v r s
        cmp     dx,24 * 8               ; A v‚g‚n van?
        jb      nijoal                  ; Nem, v rok
        cmp     cx,79 * 8               ; A v‚g‚n van?
        jb      nijoal                  ; Nem, v rok
;
; Oda vitt‚k, k”vetkez‹
;
        mov     si,offset balals        ; Sz”vegc¡m
        call    sorkii                  ; K‚perny‹ k”zep‚re
;
; Kiv rom, a bal als¢ba vigy‚k
;
nibaal:
        call    egerke                  ; Kattint s v r s
        cmp     dx,24 * 8               ; A v‚g‚n van?
        jb      nibaal                  ; Nem, v rok
        or      cx,cx                   ; Nulla?
        jnz     nibaal                  ; Nem nulla
;
; Eltntetem a kurzort, a sz”veget, majd kil‚pek
;
        mov     si,offset uresor        ; Sz”vegc¡m
        call    sorkii                  ; K‚perny‹ k”zep‚re
        mov     ax,2                    ; Kurzor neml that¢v  t‚tel k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
kilep:
	mov	ah,4ch
	int	21h
;
; Nincs eg‚rdriver ki¡rat sa, majd kil‚p‚s
;
ninege:
        mov     dx,offset nindrv        ; Sz”vegc¡m
        mov     ah,9                    ; Ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat sra
        jmp     kilep                   ; Kil‚p‚sre
;
; Eg‚rrel kattint sra v rok. Visszat‚r‚s: CX, DX-ben koordin ta
;
egerke:
        mov     ax,3                    ; µllapotlek‚rdez‚s k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,000111b              ; Van lenyomva?
        jz      egerke                  ; Nem, nincs lenyomva
;
; Valamelyik gombot lenyomt k, megv rom, hogy elengedj‚k
;
megvan:
        mov     ax,3                    ; µllapotlek‚rdez‚s k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        test    bx,000111b              ; Van lenyomva?
        jnz     megvan                  ; Igen, le van nyomva
        ret                             ; K‚sz
;
; Direkt k‚perny‹kezel‚ssel ki¡rok
;
sorkii:
        mov     ax,2                    ; Kurzor neml that¢v  t‚tel k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        mov     ax,0b800h               ; Direkt k‚perny‹ szegmens
        mov     es,ax                   ; ES kit”ltve
        mov     cx,80                   ; Ennyi karakter egy sor
        mov     di,12 * 80 * 2          ; Itt a k”zepe
cikben:
        mov     al,[si]                 ; AL kicser‚lve
        mov     es:[di],al              ; éj ‚rt‚k kit‚ve
        inc     si                      ; A k”vetkez‹ elemre
        add     di,2                    ; A k‚perny‹n kett‹nk‚nt van
        loop    cikben                  ; Ciklusban kim solom
        mov     ax,1                    ; Kurzor l that¢v  t‚tel k¢dja
        int     33h                     ; Eg‚rdriver h¡v sa
        ret                             ; Kitettem

nindrv  db      'Nincs eg‚rdriver!', 10, 13, '$'

;                01234567890123456789012345678901234567890123456789012345678901234567890123456789
balfel  db      '               Vidd a kurzort a bal fels” sarokba ‚s kattints!                  '
jobfel  db      '               Vidd a kurzort a jobb fels” sarokba ‚s kattints!                 '
jobals  db      '               Vidd a kurzort a jobb als¢ sarokba ‚s kattints!                  '
balals  db      '                Vidd a kurzort a bal als¢ sarokba ‚s kattints!                  '
uresor  db      '                                                                                '

code	ends
	end	start

