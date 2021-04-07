code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80*25-”s k‚perny‹ k‚r‚s k¢dja
        int     10h                     ; M¢dv lt s, azaz k‚perny‹t”rl‚s
;
; Az eg‚r kurzor l that¢v  t‚tele
;
        mov     ax,1                    ; Az megjelen¡t‚s k¢dja
        int     33h                     ; Kurzor megjelen¡t‚s
;
; Ki¡ratom a k‚perny‹ k”zep‚re a k‚r‚st
;
        mov     dx,offset elsosa        ; A ki¡ratand¢ sz”veg
        mov     bx,elsoho               ; A ki¡rat s hossza
        call    kekoki                  ; Ki¡rat s rutinja
;
; Az eg‚r mozgat s nak kiv r sa
;
varbfs:
        mov     ah,1                    ; Klavi lek‚rdez‚s
        int     16h                     ; Volt let‚s?
        jnz     voltki                  ; Igen, kil‚pnk
        mov     ax,3                    ; A poz¡ci¢lek‚rdez‚s k¢dja
        int     33h                     ; Eg‚r bek‚r‚s
        or      dx,dx                   ; Nulla az Y poz¡ci¢?
        jnz     varbfs                  ; Nem, v runk tov bb
        or      cx,cx                   ; Nulla az X poz¡ci¢?
        jnz     varbfs                  ; Nem, v runk tov bb
;
; Ki¡ratom a k‚perny‹ k”zep‚re a k‚r‚st
;
        mov     dx,offset masods        ; A ki¡ratand¢ sz”veg
        mov     bx,masodh               ; A ki¡rat s hossza
        call    kekoki                  ; Ki¡rat s rutinja
;
; Az eg‚r mozgat s nak kiv r sa
;
varjfs:
        mov     ah,1                    ; Klavi lek‚rdez‚s
        int     16h                     ; Volt let‚s?
        jnz     voltki                  ; Igen, kil‚pnk
        mov     ax,3                    ; A poz¡ci¢lek‚rdez‚s k¢dja
        int     33h                     ; Eg‚r bek‚r‚s
        or      dx,dx                   ; Nulla az Y poz¡ci¢?
        jnz     varjfs                  ; Nem, v runk tov bb
        cmp     cx,632                  ; A jobb oldal az X poz¡ci¢?
        jb      varjfs                  ; Nem, v runk tov bb
;
; Ki¡ratom a k‚perny‹ k”zep‚re a k‚r‚st
;
        mov     dx,offset harmas        ; A ki¡ratand¢ sz”veg
        mov     bx,harmah               ; A ki¡rat s hossza
        call    kekoki                  ; Ki¡rat s rutinja
;
; Az eg‚r mozgat s nak kiv r sa
;
varjas:
        mov     ah,1                    ; Klavi lek‚rdez‚s
        int     16h                     ; Volt let‚s?
        jnz     voltki                  ; Igen, kil‚pnk
        mov     ax,3                    ; A poz¡ci¢lek‚rdez‚s k¢dja
        int     33h                     ; Eg‚r bek‚r‚s
        cmp     dx,192                  ; Az als¢ sor az Y poz¡ci¢?
        jb      varjas                  ; Nem, v runk tov bb
        cmp     cx,632                  ; A jobb oldal az X poz¡ci¢?
        jb      varjas                  ; Nem, v runk tov bb
;
; Ki¡ratom a k‚perny‹ k”zep‚re a k‚r‚st
;
        mov     dx,offset negyes        ; A ki¡ratand¢ sz”veg
        mov     bx,negyeh               ; A ki¡rat s hossza
        call    kekoki                  ; Ki¡rat s rutinja
;
; Az eg‚r mozgat s nak kiv r sa
;
varbas:
        mov     ah,1                    ; Klavi lek‚rdez‚s
        int     16h                     ; Volt let‚s?
        jnz     voltki                  ; Igen, kil‚pnk
        mov     ax,3                    ; A poz¡ci¢lek‚rdez‚s k¢dja
        int     33h                     ; Eg‚r bek‚r‚s
        cmp     dx,192                  ; Az als¢ sor az Y poz¡ci¢?
        jb      varbas                  ; Nem, v runk tov bb
        or      cx,cx                   ; Nulla az X poz¡ci¢?
        jnz     varbas                  ; Nem, v runk tov bb
;
; R”gt”n ut na kil‚pnk
;
kilep:
;
; Az eg‚r kurzor neml that¢v  t‚tele
;
        mov     ax,2                    ; Az elrejt‚s k¢dja
        int     33h                     ; Kurzor megjelen¡t‚s
	mov	ah,4ch
	int	21h
;
; A kil‚p‚s el‹tt be kell olvasni a let‚st!!
;
voltki:
        mov     ah,0                    ; Let‚sbeolvas s k¢dja a klavir¢l
        int     16h                     ; Beolvas s a klavir¢l
        jmp     kilep                   ; Majd kil‚pnk
;
; A k‚perny‹ k”zep‚re ki¡rat¢ rutin
;
kekoki:
        mov     ax,0b800h               ; A k‚perny‹ direkt szegmense
        mov     es,ax                   ; ES <- B800
        mov     di,(12 * 80) * 2        ; A 13. sor eleje
        mov     cx,80                   ; Egy sor hossza
;
; Sort”rl‚s 80 sz¢k”z kit‚tel‚vel
;
sortor:
        mov     byte ptr es:[di],' '    ; Sz¢k”z mint a t”rl‚s karakter
        inc     di                      ; Az attrib£tumot  tl‚pem
        inc     di                      ; A k”vetkez‹re l‚pek
        loop    sortor                  ; A sor t”rl‚se ciklusban
;
; Kisz m¡tom a kzd‹ poz¡ci¢t
;
        mov     di,80                   ; Egy sor hossza
        sub     di,bx                   ; Levonom bel‹le a karakterek hossz t
        shr     di,1                    ; A marad‚k fele maradjon
        shl     di,1                    ; Mivel egy poz¡ci¢ 2 hossz£
        add     di,(12 * 80) * 2        ; A 13. sor elej‚vel eltolom
;
; Ki¡rat si ciklus el‹k‚sz¡t‚s
;
        mov     si,dx                   ; µtm solom a kezd‹ karakterpoz¡ci¢t
        mov     cx,bx                   ; A hossz m solata
;
; A t‚nyleges ki¡rat s ciklusa
;
kakici:
        mov     al,[si]                 ; AL <- forr s karakter (a programb¢l)
        mov     es:[di],al              ; Kitettem a k‚perny‹terletre        
        inc     si                      ; L‚pek a forr ssal
        inc     di                      ; µtl‚pem a terleten az attrib£tumot
        inc     di                      ; L‚pek a c‚llal is
        loop    kakici                  ; Ciklusban ki a karakter
        ret                             ; K‚sz a ki¡rat s

elsosa  db      'Mozgasd az egeret a bal fels‹ sarokba!'
elsoho  equ     $-elsosa

masods  db      'Mozgasd az egeret a jobb fels‹ sarokba!'
masodh  equ     $-masods

harmas  db      'Mozgasd az egeret a jobb als¢ sarokba!'
harmah  equ     $-harmas

negyes  db      'Mozgasd az egeret a bal als¢ sarokba!'
negyeh  equ     $-negyes


code	ends
	end	start

