code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80x25-”s m¢dbe ll¡t s-k‚r‚s k¢dja
        int     10h                     ; Vide¢-kezel‹ megszak¡t s h¡v s
;
; Nem v‚letlen, hanem a be ll¡tott ‚rt‚ke kerl ki¡r sra
;
        mov     bx,0abcdh               ; Ezt az ‚rt‚ket ¡rassuk ki
;
; Mivel a rutin AX-et fogja ki¡rni, oda bem solom BX-et
;
        mov     ax,bx                   ; Ez lesz a ki¡ratand¢
        call    axdeko                  ; AX ki¡rat sa HEX ban
;
; Ut na soremel‚s kocsivissza
;
        call    crlf                    ; Emel‚s
;
; Mivel a rutin AX-et fogja ki¡rni, oda bem solom a k¢dszegmens ‚rt‚k‚t
;
        mov     ax,cs                   ; K¢dszegmens AX-be
        call    axdeko                  ; AX ki¡rat sa HEX ban
;
; Ut na soremel‚s kocsivissza
;
        call    crlf                    ; Emel‚s
;
; Mivel a rutin AX-et fogja ki¡rni, oda bem solom a BP ‚rt‚k‚t
;
        mov     ax,bp                   ; BP ‚rt‚ke AX-be
        call    axdeko                  ; AX ki¡rat sa HEX ban
;
; Kil‚pnk a programunkb¢l
;
        mov     ax,4c00h                ; A kil‚p‚sk‚r‚s k¢dja sikeresen
        int     21h                     ; A DOS h¡v sa kil‚p‚sre,
                                        ; Innen m r nem t‚rnk vissza!!!!
;
; Az a soremel‚s-kocsivissza ki¡rat¢ szubrutin
;
crlf:
        mov     ah,2                    ; Egy karakter ki¡rat s nak k¢dja
        mov     dl,10                   ; Ez az LF k¢dja
        int     21h                     ; Ki¡rat s DOS-al
        mov     dl,13                   ; Ez a CR k¢dja
        int     21h                     ; Ki¡rat s DOS-al
        ret                             ; Visszat‚r‚s
;
; AX ki¡rat sa £gy t”rt‚nik, hogy el‹sz”r AH, majd AL ki¡r sa t”rt‚nik meg
;
axdeko:
        push    ax                      ; K‚s‹bb m‚g kell
        mov     al,ah                   ; AL k¡r sa miatt AH-t beleteszem
        call    aldeko                  ; AL ki¡rat sa
        pop     ax                      ; Eredeti ‚rt‚k vissza
        call    aldeko                  ; AL ki¡rat sa 
        ret                             ; K‚sz a ki¡rat s
;
; AL ki¡rat sa £gy, hogy el‹sz”r a fels‹ 4 bitje, majd az als¢ 4 bitje
;
aldeko:
        push    ax                      ; Elteszem k‚s‹bbre
        shr     al,1                    ; Lel‚ptetem 1-et
        shr     al,1                    ; Lel‚ptetem 1-et
        shr     al,1                    ; Lel‚ptetem 1-et
        shr     al,1                    ; Lel‚ptetem 1-et (”sszesen n‚gyszer!)
        call    nebiki                  ; AL als¢ n‚gy bitj‚t ki¡ratom
        pop     ax                      ; AL als¢ n‚gy bit (is) vissza
        call    nebiki                  ; AL als¢ n‚gy bitj‚t ki¡ratom
        ret                             ; K‚sz vagyok
;
; AL als¢ n‚gy bitj‚t ki¡ratom HEX ban
;
nebiki:
        and     al,00001111b            ; Csak az als¢ n‚gy bit maradjon
        mov     dl,al                   ; DL-be a kiratand¢ ‚rt‚k
        add     dl,'0'                  ; Karakterr‚ konvert lom
        cmp     dl,'9'                  ; Enn‚l nagyobb?
        jbe     monosz                  ; Nem, akkor most ez sz mjegy
        add     dl,'A' - ('9' + 1)      ; Ez a 10. ‚s az 'A' kl”nbs‚ge
monosz:
        mov     ah,2                    ; A DOS egy karakter ki¡r s k‚r‚s
        int     21h                     ; DOS h¡v s
        ret                             ; Ki¡rat s k‚sz
code	ends
	end	start

