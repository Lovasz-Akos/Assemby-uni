code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
start:
        mov     ax,3                    ; K‚perny‹t”rl‚shez m¢dv lt s k¢dja
        int     10h                     ; Video BIOS h¡v sa a t”rl‚shez
        mov     dx,offset mianev        ; Sz”vegc¡m
        mov     ah,9                    ; String ki¡r s k¢dja
        int     21h                     ; DOS h¡v sa ki¡r sra
;
; Beolvasok nevet 5 karakterben
;
        mov     cx,5                    ; Ennyi karakterb‹l  ll a n‚v
        mov     bx,offset nevtar        ; A karakterek c¡me
        mov     ah,1                    ; Viszhangos let‚sv r s k¢dja
nevbek:
        int     21h                     ; DOS h¡v sa beolvas sra
        mov     [bx],al                 ; Az adott c¡mre kiteszem
        inc     bx                      ; A k”vetkez‹re l‚pek
        loop    nevbek                  ; A nevet bek‚r‹ ciklus
        mov     byte ptr [bx],'$'       ; A v‚g‚re doll r
;       
; N‚vbeolvas s k‚sz, kezdem a sz”veget
;
        mov     dx,offset sziast        ; Sz”vegc¡m
        mov     ah,9                    ; String ki¡r s k¢dja
        int     21h                     ; DOS h¡v sa ki¡r sra
;
; Megy ki a beolvasott n‚v ut na
;
        mov     ah,9                    ; String ki¡rat s k¢dja
        mov     dx,offset nevtar        ; A karakterek c¡me
        int     21h                     ; DOS k‚r‚s katrakter string ki¡r sra
;
; N‚vkivitel k‚sz, lez r¢ sz”veg kikld‚s
;
        mov     dx,offset sziave        ; Sz”vegc¡m
        mov     ah,9                    ; String ki¡r s k¢dja
        int     21h                     ; DOS h¡v sa ki¡r sra
	mov	ah,4ch
	int	21h

mianev  db      'Hogy h¡vnak? $'

sziast  db      13, 10,'Szia $'

sziave  db      '!', 13, 10, '$'

nevtar  db      6 dup(?)

















code	ends
	end	start

