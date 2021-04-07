code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

pardar  db      ?

	org	100h
        

start:
        mov     ax,3                    ; 80x25-”s m¢dbe ll¡t s-k‚r‚s k¢dja
        int     10h                     ; Vide¢-kezel‹ megszak¡t s h¡v s
;
; Kielemzem a parancssort
;
        mov     bx,offset pardar        ; Itt van a parancssor darabsz m
        mov     cl,[bx]                 ; Beolvasom a darabsz mot
        mov     ch,0                    ; A H r‚sz null za miatt CX <- darab
        add     bx,cx                   ; A v‚g‚re l‚pek
        jcxz    bajdar                  ; Ha nulla figyelmeztet‚s
        dec     cx                      ; Egy a darabsz m?
        jcxz    bajdar                  ; Ha egy figyelmeztet‚s
        inc     bx                      ; Ide j”n a v‚gjel
        mov     byte ptr [bx],'$'       ; V‚gjel kipakol s
;
; Ez a ki¡rat s ciklusa
;
vakcik:
        dec     bx                      ; Egyel el‹tte folytatom
        push    cx                      ; Elromlik a ciklussz ml l¢
        dec     cx                      ; Egyel kevesebbet
        jcxz    nemspc                  ; Ha ¡gy a CX 0, nem tesz sz¢k”z”ket
        mov     ah,2                    ; Karakterki¡r si k¢d
        mov     dl,' '                  ; A sz¢k”z, amit ki¡runk
spkirc:
        int     21h                     ; DOS h¡v sa karakterki¡r sra
        loop    spkirc                  ; Sz¢k”z cikluis
nemspc:
        pop     cx                      ; Eredeti sz ml l¢ vissza
        mov     ah,9                    ; A ki¡rat sk‚r‚s k¢dja
        mov     dx,bx                   ; A k¡ratand¢ sz”vegr‚sz c¡me
        int     21h                     ; A DOS megh¡v sa annyiszor
        mov     ah,2                    ; Karakterki¡r si k¢d
        mov     dl,10                   ; LF, amit ki¡runk
        int     21h                     ; DOS h¡v sa karakterki¡r sra
        mov     dl,13                   ; CR, amit ki¡runk
        int     21h                     ; DOS h¡v sa karakterki¡r sra
        mov     ah,8                    ; N‚ma bek‚r‚s k¢dja
        int     21h                     ; DOS h¡v sa beolvas sra
        loop    vakcik                  ; A k”vetkez‹ r‚sz ki¡r sa j”ne
;
; Kil‚pnk a programunkb¢l
;
befejez:
        mov     ax,4ch                  ; A kil‚p‚sk‚r‚s k¢dja 
        int     21h                     ; A DOS h¡v sa kil‚p‚sre,
                                        ; Innen m r nem t‚rnk vissza!!!!
bajdar:
        mov     dx,offset fafeju        ; Sz”vegc¡m
        mov     ah,9                    ; Ki¡r sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡r sra
        jmp     befejez                 ; Nincs tov bb, kil‚pek

fafeju  db      'Nincs megadva param‚ter!',10,13,'$'

code	ends
	end	start

