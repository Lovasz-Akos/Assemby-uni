code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; M¢dbe ll¡t s 3-as ‚rt‚kre
        int     10h                     ; M¢dbe ll¡t s (k‚perny‹ t”rl‚s)
        mov     ah,9                    ; Sz”vegki¡rat s k¢dja
        mov     dx,offset szoveg        ; Sz”vegc¡m a DX-be
        int     21h                     ; Ki¡ratom DOS-sal
        mov     cx,10                   ; Ennyi billentyûre fogok v rni
;
; El‹sz”r megvizsg lom, hogy az ALT le van-e nyomva
;
varcik:
        mov     ah,2                    ; St tuszlek‚rdez‚s k¢dja (BIOS)
        int     16h                     ; BIOS h¡v sa st tuszvizsg latra
        test    al,00001000b            ; ALT bitje be ll¡tva?
        jnz     kilep                   ; Igen, ki is l‚pek
;
; Lek‚rdezem, hogy volt-e let‚s (de nem olvasom be!!!)
;
        mov     ah,1                    ; Let‚slek‚rdez‚s k¢dja (BIOS)
        int     16h                     ; BIOS h¡v sa let‚s vizsg latra
        jz      varcik                  ; M‚g v rok
;
; Tal ltam let‚st, ‚s beolvasom. Tulajdonk‚ppen ez a k¢dr‚sz
; let‚sv r s lenne, de mivel az el‹z‹ h¡v sb¢l kiderlt, hogy
; van m r let‚s, nem v r semmit
;
        mov     ah,0                    ; Let‚s beolvas s k¢dja (BIOS)
        int     16h                     ; BIOS h¡v sa let‚sv r sra
        cmp     al,33o                  ; ppen ESC volt?
        jz      kilep                   ; Igen, ALT vizsg latra megyek
        cmp     al,'Q'                  ; A 'Q' karakter volt?
        jz      kilep                   ; Igen, ALT vizsg latra megyek
        cmp     al,'q'                  ; A 'q' karakter volt?
        jz      kilep                   ; Igen, ALT vizsg latra megyek
        mov     dl,al                   ; DL-b‹l fogok ki¡ratni
        inc     dl                      ; De egyel nagyobb k¢d£t
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa egy karakter ki¡r sra
        loop    varcik                  ; M‚g kell billentyû
kilep:
	mov	ah,4ch
	int	21h

szoveg  db      'šss‚l le billentyûket!', 10, 13, '$'

code	ends
	end	start

