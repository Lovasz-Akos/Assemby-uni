code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80x25-”s m¢dbe ll¡t s-k‚r‚s k¢dja
        int     10h                     ; Vide¢-kezel‹ megszak¡t s h¡v s
;
; K‚perny‹t”rl‚s ut n j”n a sz”vegki¡r s
;
        mov     ah,9                    ; A sz”vegki¡rat sk‚r‚s k¢dja
        mov     dx,offset tajszo        ; A ki¡ratand¢ sz”veg c¡me DX-be
        int     21h                     ; DOS h¡v s a ki¡rat sra
;
; Let‚sv r si ciklus, mint a feladat t”rzse
;
ujleut:
        mov     ah,8                    ; Let‚s beolvas si k‚r‚s k¢dja (n‚ma)
        int     21h                     ; A DOS beolvas sk‚r‚se
        cmp     al,27                   ; ppen az ESC billentyû?
        jz      kilep                   ; Ha ‚ppen ESC, "KILEP"-n‚l folytat
;
; A beolvasott karaktert ki kell ¡rnunk
;
        mov     ah,2                    ; Egy karakter ki¡rat sa a DL-b‹l
        inc     al                      ; Egyel nagyobb ASCII k¢d lesz bel‹le
        mov     dl,al                   ; Ez a let‚s karktere
        int     21h                     ; A DOS egy karakterki¡r i h¡v sa
        jmp     ujleut                  ; V rjuk a k”vetkez‹ let‚st
;
; Kil‚pnk a programunkb¢l
;
kilep:
        mov     ax,4c00h                ; A kil‚p‚sk‚r‚s k¢dja sikeresen
        int     21h                     ; A DOS h¡v sa kil‚p‚sre,
                                        ; Innen m r nem t‚rnk vissza!!!!

tajszo  db      'šss”n le billentyûket, ESC v‚ge!',10,13,'$'

code	ends
	end	start

