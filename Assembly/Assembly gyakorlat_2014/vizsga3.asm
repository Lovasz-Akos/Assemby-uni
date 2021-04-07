code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; VIDEO BIOS h°v†sa, m¢dv†lt†shoz
;
; Bekapcsolom az egÇrkurzort
;
        mov     ax,1                    ; EgÇr kurzor bekapcsol†s k¢dja
        int     33h                     ; EgÇr kurzor bekapcsol†sa
;
; DI-be olyan ÇrtÇket teszek, amilyen biztos nem jîn
;
        mov     di,0ffffh               ; Ilyen biztos nincs
;
; Ez az egÇrkÇrdezgetã ciklus eleje
;
azeges:
        mov     ax,3                    ; EgÇr†llapot lekÇrdezÇs
        int     33h                     ; KÇrdezem az egÇr drivert
;
; ôsszehasonl°tom az elãzã gomb†llapotot (DI)  a most beolvasottal (BX)
;
        cmp     bx,di                   ; Azonosak?
        jz      nemiro                  ; Igen, nem kell ki°rni szîveget
        mov     di,bx                   ; Most m†r egyform†k
;
; Mivel volt eltÇrÇs, kialak°tom a szîveg c°m†t DX-be
;
        mov     dx,offset egyiks        ; A szîveg, ha egyik sem
        and     bx,11b                  ; Csak a kÇt legals¢ bit marad
        jz      megvan                  ; Nincs egyik sem lenyomva
        mov     dx,offset balgom        ; A szîveg, ha csak a bal
        dec     bx                      ; Ha csak 1 van a BX-ben, 0 lesz
        jz      megvan                  ; Csak a bal van lenyomva
        mov     dx,offset jobgom        ; A szîveg, ha csak a jobb
        dec     bx                      ; Ha m†r csak 1 van a BX-ben, 0 lesz
        jz      megvan                  ; Csak a jobb van lenyomva
        mov     dx,offset mindke        ; A szîveg, ha mindkettã
;
; DX-ben a ki°ratand¢ szîveg c°me, de elãtte kikapcsolom a kurzurt
;
megvan:
        mov     ax,2                    ; Kikapcsolom a kurzort
        int     33h                     ; Kurzor kikapcsol†sa egÇr driverrel
;
; DX-ben a ki°ratand¢ szîveg c°me, h†t sim†n ki°rom
;
        mov     ah,9                    ; String ki°rat†s k¢dja
        int     21h                     ; Ki°ratom a DOS-sal
;
; Visszakapcsolom a kurzurt
;
        mov     ax,1                    ; Bekapcsolom a kurzort
        int     33h                     ; Kurzor bekapcsol†sa egÇr driverrel
;
; Elimin†lom az als¢ 3 biteket az X Çs Y poz°ci¢b¢l,
; mivel a kurzor poz°ci¢ja 8-al oszthat¢ ÇrtÇkeken van
;
nemiro:
        and     cx,NOT 111b             ; EltÅntetm az als¢ 3 bitet a X-bãl
        and     dx,NOT 111b             ; EltÅntetm az als¢ 3 bitet az Y-b¢l
;
; Null†ra megvizsg†lom X Çs Y poz°ci¢t
;
        or      dx,cx                   ; Nulla a poz°ci¢?
        jnz     azeges                  ; Ez a ciklus
;
; KilÇpÇs elãtt kikapcsolom a kurzort
;
        mov     ax,2                    ; EgÇr kurzor kikapcsol†s k¢dja
        int     33h                     ; EgÇr kurzor kikapcsol†sa
	mov	ah,4ch
	int	21h

balgom  db      'Bal gomb    ',13,'$'
jobgom  db      'Jobb gomb   ',13,'$'
mindke  db      'MindkÇt gomb',13,'$'
egyiks  db      'Egyik sem   ',13,'$'


code	ends
	end	start

