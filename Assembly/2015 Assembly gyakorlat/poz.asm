code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:               
        mov     ax,3                    ; KÇpernyãtîrlÇshez v†lt†s k¢d
        int     10h                     ; Video Bios-al tîrlÇs
        mov     ax,1                    ; EgÇr kurzor bekapcsol†s
        int     33h                     ; EgÇr driver h°v†sa
        mov     si,0ffffh               ; Ilyen X koordin†ta nincs
        mov     bp,0ffffh               ; Ilyen Y koordin†ta nincs
egecik:
        mov     ah,1                    ; LeÅtÇs vizsg†lat k¢dja
        int     16h                     ; Klavi a Bios-ban
        jz      ninleu                  ; Nincs leÅtÇs
        mov     ah,0                    ; LeÅtÇs beolvas†s
        int     16h                     ; Klavi a Bios-ban
        cmp     al,27                   ; êppen ESC volt?
        jz      kileci                  ; Igen, kilÇpek a ciklusb¢l
ninleu:
        mov     ax,3                    ; EgÇr†llapot lekÇrdezÇs k¢dja
        int     33h                     ; EgÇr driver h°v†sa
        cmp     cx,si                   ; Ilyen volt az X?
        jnz     kooval                  ; Nem, v†ltozott
        cmp     dx,bp                   ; Ilyen volt az Y?
        jz      koonev                  ; Igen, nincs v†ltoz†s
kooval:
        mov     si,cx                   ; Az £j X koordin†ta
        mov     bp,dx                   ; Az £j Y koordin†ta
;
; Most ki°rom a koordin†t†kat
;                                             
        mov     ax,2                    ; EgÇr kurzor kikapcsol†s
        int     33h                     ; EgÇr driver h°v†sa
        mov     ah,2                    ; Egy karakter ki°r†sa
        mov     dl,'X'                  ; Ezt °rja ki
        int     21h                     ; Ki°rat†s DOS-sal
        mov     dl,'='                  ; Ezt °rja ki
        int     21h                     ; Ki°rat†s DOS-sal
        mov     ax,si                   ; Ezt °rja ki
        call    axdeko                  ; AX ki°rat†sa decim†lisan
        mov     ah,2                    ; Egy karakter ki°r†sa
        mov     dl,'Y'                  ; Ezt °rja ki
        int     21h                     ; Ki°rat†s DOS-sal
        mov     dl,'='                  ; Ezt °rja ki
        int     21h                     ; Ki°rat†s DOS-sal
        mov     ax,bp                   ; Ezt °rja ki
        call    axdeko                  ; AX ki°rat†sa decim†lisan
        mov     ah,9                    ; Karakter string ki°r†sa
        mov     dx,offset martor        ; Ezt °rja ki
        int     21h                     ; Ki°rat†s DOS-sal
        mov     ax,1                    ; EgÇr kurzor bekapcsol†s
        int     33h                     ; EgÇr driver h°v†sa
koonev:
        jmp     egecik                  ; EgÇr v†r¢ ciklus
kileci:
        mov     ax,2                    ; EgÇr kurzor kikapcsol†s
        int     33h                     ; EgÇr driver h°v†sa
	mov	ah,4ch
        int     21h
axdeko:
        mov     cl,3                    ; Ennyiszer lÇpjen
        shr     ax,cl                   ; Osztom 8-al
        mov     cx,sp                   ; Most Åres a stack
        mov     bx,10                   ; Ezzel osztogatok
kokasz:
        xor     dx,dx                   ; H rÇsz Åres legyen
        div     bx                      ; DX:AX oszt†sa
        push    dx                      ; Karakternek val¢
        or      ax,ax                   ; Megvizsg†lom, hogy nulla-e
        jnz     kokasz                  ; MÇg sz†molni kell
        mov     ah,2                    ; Egy karakter ki°rat†sa
vanmik:
        pop     dx                      ; A maradÇk
        or      dl,'0'                  ; KarakterrÇ alak°tom
        int     21h                     ; Ki°rat†s DOS-sal        
        cmp     cx,sp                   ; A vÇgÇre Çrt m†r?
        jnz     vanmik                  ; Nem, mÇg veszek ki
        ret                             ; KÇsz vagyok

martor  db      '      ', 13, '$'


code	ends
	end	start

