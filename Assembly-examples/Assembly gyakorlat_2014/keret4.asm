code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing



        org     80h

darabe  db      ?                       ; A darabsz m helye
        db      ?                       ; Az elv laszt¢ karakter helye
        db      126 dup (?)             ; A parancs karakterei


	org	100h

start:
        mov     ax,3                    ; M¢dv lt s k‚perny‹t”rl‚shez
        int     10h                     ; K‚perny‹t”rl‚s VIDEO BIOS-al
        mov     si,offset darabe        ; A parancssor hossz nak helye
        lodsb                           ; AL <- darabsz m
        cmp     al,5                    ; ppen 5 a hossz?
        jnz     helpki                  ; Sz”veg megy ki
        inc     si                      ; µtl‚pem az elv laszt¢t
        lodsb                           ; Ez az els‹ jegy
        cmp     al,'0'                  ; Enn‚l kisebb?
        jb      helpki                  ; Igen, baj van
        cmp     al,'7'                  ; Enn‚l nagyobb?
        ja      helpki                  ; Igen, baj van
        and     ax,0000000000001111b    ; A sz m marad
        shl     ax,1                    ; Dupl ja
        mov     bp,ax                   ; Kell k‚s‹bb
        shl     ax,1                    ; 4*
        shl     ax,1                    ; 8*
        add     bp,ax                   ; 10-szeres lett
        lodsb                           ; Ez a m sodik jegy
        cmp     al,'0'                  ; Enn‚l kisebb?
        jb      helpki                  ; Igen, baj van
        cmp     al,'9'                  ; Enn‚l nagyobb?
        ja      helpki                  ; Igen, baj van
        and     ax,0000000000001111b    ; A sz m marad
        add     bp,ax                   ; Egytt
        cmp     bp,3                    ; Ennyi minimum legyen
        jb      helpki                  ; Kisebb, baj van
        cmp     bp,79                   ; Ennyi m r nem lehet
        jae     helpki                  ; Nagyobb, vagy egyenl‹, baj van
        lodsb                           ; Ez az elv laszt¢
        cmp     al,' '                  ; Sz¢k”z?
        jnz     helpki                  ; Nem, baj van
        lodsb                           ; Ez a darab jegye
        cmp     al,'1'                  ; Enn‚l kisebb?
        jb      helpki                  ; Igen, baj van
        cmp     al,'9'                  ; Enn‚l nagyobb?
        ja      helpki                  ; Igen, baj van
        and     ax,0000000000001111b    ; A sz m marad
        mov     si,ax                   ; Egytt
        mov     dx,offset elmozd        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; A string ki¡rat sa DOS-sal
        mov     ah,2                    ; Egy karakter kipakol s k¢dja
        call    sorbao                  ; Egy sor 'O' karakter
sorkoz:
        call    eleveo                  ; Elej‚re, v‚g‚re 'O'
        dec     si                      ; cs”kkentem a sz ml l¢t
        jnz     sorkoz                  ; Sorkit‚tel ciklus
        call    sorbao                  ; Egy sor 'O' karakter
kilep:
        mov     ah,4ch
	int	21h
helpki:
        mov     dx,offset helpsz        ; A sz”veg c¡me
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; A string ki¡rat sa DOS-sal
        jmp     kilep                   ; Be is fejezem
;
; Egy "sornyi" O karakter kit‚tele, majd CR LF
;
sorbao:
        call    elejes                  ; Az elej‚re sz¢k”z
        mov     cx,bp                   ; Ennyi 'O' lesz kit‚ve
        mov     dl,'O'                  ; Ezt tesszk ki
        call    sorbel                  ; Kipakol s ciklusban
        jmp     crlf                    ; CR ‚s LF kit‚tel
;
; K”ztes sor kit‚tele
;
eleveo:
        call    elejes                  ; Az elej‚re sz¢k”z
        mov     dl,'O'                  ; Ezt tesszk ki
        int     21h                     ; Kiteszem a karaktert
        lea     cx,[bp - 2]             ; Ennyi ' ' lesz kit‚ve
        call    sorbes                  ; Kipakol s ciklusban
        mov     dl,'O'                  ; Ezt tesszk ki
        int     21h                     ; Kiteszem a karaktert
crlf:
        mov     dl,13                   ; CR karakter
        int     21h                     ; Kiteszem a karaktert
        mov     dl,10                   ; LF karakter
        int     21h                     ; Kiteszem a karaktert
        ret                             ; K‚sz a CR ‚s LF

elejes:
        mov     cx,80                   ; Ez a sor hossza
        sub     cx,bp                   ; Ez a marad‚k dupl ja
        shr     cx,1                    ; A fele kell csak
sorbes:
        mov     dl,' '                  ; Ezt tesszk ki
sorbel:
        int     21h                     ; Kiteszem a karaktert
        loop    sorbel                  ; Kitettem ciklusban t”bbsz”r
        ret                             ; Visszt‚r‚s mert csak ennyi volt

helpsz  db      'Haszn lata: Keret4 XX Y', 13, 10, 'ahol XX ‚s Y sz mjegyek.', 13, 10
        db      'XX minimum 3, maximum 78, Y minimum 1 maximum 9', 10, 13, '$'
elmozd  db      13, 10, 10, 10, '$'

code	ends
	end	start

