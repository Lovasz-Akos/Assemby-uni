code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
;
; Els‹nek k‚perny‹t”rl‚s
;
        mov     ax,3                    ; 80*25-”s m¢d k¢dja
        int     10h                     ; Vide¢ m¢d  t ll¡t s (k‚perny‹t”rl‚s)
;
; Ki¡rom a bek‚r‹ sz”veget. CR ‚s LF is legyen a v‚gen, hogy £j sorban
; kezdhessnk automatikusan!!!
;
        mov     dx,offset billsz        ; Sz”vegc¡m
        mov     ah,9                    ; Ki¡rat s k¢dja
        int     21h                     ; Ki¡rjuk a sz”veget
;
; Az SI regiszter fogja t rolni a ki¡r sok sz m nak t rol s t
;
        mov     si,1                    ; Els‹nek ennyiszer kell csin lnia
;
; Mivel 10-szer kell megcsin lni bet”lt”m a ciklussz mot
;
        mov     cx,10                   ; Ennyiszer kell maximum
;
; Maga a ciklus
;
cikfel:
;
; DOS-os n‚ma let‚sk‚r‚s
;
        mov     ah,8                    ; "N‚ma" bek‚r‚s k¢dja
        int     21h                     ; DOS h¡vs beolvas sra
;
; Meg kell vizsg lni, hogy ESC, 'Q' vagy 'q' esetleg amit let”ttnk!
;
        cmp     al,'Q'                  ; Ez a 'Q' karakter lenne?
        jz      kilep                   ; Igen, ‚ppen a 'Q', kil‚pek
        cmp     al,'q'                  ; Ez a 'q' karakter lenne?
        jz      kilep                   ; Igen, ‚ppen a 'q', kil‚pek
        cmp     al,1bh                  ; Ez az ESC karakter lenne?
        jz      kilep                   ; Igen, ‚ppen az ESC, kil‚pek
;
; Nem a "forr¢" billentyûk egyike, j”het a ki¡rat s
;
        push    cx                      ; Ciklussz ml l¢ ment‚s
        mov     cx,si                   ; CX <- amennyiszer ki kell ¡rni
;
; El‹k‚sz¡tem a ki¡rat st
;
        mov     ah,2                    ; Karakterki¡rat s k¢dja
        mov     dl,al                   ; A ki¡ratand¢ karakter  tm sol sa
;
; Ki¡rat s ciklusban a let”tt karaktert CX-szer
;
kaciki:
        int     21h                     ; Ki-ki ¡rogatok
        loop    kaciki                  ; Annyiszor amennyi SI-ben volt
;
; Ciklusz r si feladatok
;
        pop     cx                      ; Ciklussz ml l¢ vissza
        inc     si                      ; A k”vetkez”ben 1-el t”bbsz”r kell!
        loop    cikfel                  ; A feladat ciklusban
;
; A kil‚p‚s k‚r‚se a DOS-t¢l
;
kilep:
	mov	ah,4ch
	int	21h

billsz  db      'šss”n le billentyûket!',10,13,'$'

code	ends
	end	start

