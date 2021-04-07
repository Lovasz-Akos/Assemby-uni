code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; VIDEO BIOS h�v�sa, m�dv�lt�shoz
;
; Bekapcsolom az eg�rkurzort
;
        mov     ax,1                    ; Eg�r kurzor bekapcsol�s k�dja
        int     33h                     ; Eg�r kurzor bekapcsol�sa
;
; DI-be olyan �rt�ket teszek, amilyen biztos nem j�n
;
        mov     di,0ffffh               ; Ilyen biztos nincs
;
; Ez az eg�rk�rdezget� ciklus eleje
;
azeges:
        mov     ax,3                    ; Eg�r�llapot lek�rdez�s
        int     33h                     ; K�rdezem az eg�r drivert
;
; �sszehasonl�tom az el�z� gomb�llapotot (DI)  a most beolvasottal (BX)
;
        cmp     bx,di                   ; Azonosak?
        jz      nemiro                  ; Igen, nem kell ki�rni sz�veget
        mov     di,bx                   ; Most m�r egyform�k
;
; Mivel volt elt�r�s, kialak�tom a sz�veg c�m�t DX-be
;
        mov     dx,offset egyiks        ; A sz�veg, ha egyik sem
        and     bx,11b                  ; Csak a k�t legals� bit marad
        jz      megvan                  ; Nincs egyik sem lenyomva
        mov     dx,offset balgom        ; A sz�veg, ha csak a bal
        dec     bx                      ; Ha csak 1 van a BX-ben, 0 lesz
        jz      megvan                  ; Csak a bal van lenyomva
        mov     dx,offset jobgom        ; A sz�veg, ha csak a jobb
        dec     bx                      ; Ha m�r csak 1 van a BX-ben, 0 lesz
        jz      megvan                  ; Csak a jobb van lenyomva
        mov     dx,offset mindke        ; A sz�veg, ha mindkett�
;
; DX-ben a ki�ratand� sz�veg c�me, de el�tte kikapcsolom a kurzurt
;
megvan:
        mov     ax,2                    ; Kikapcsolom a kurzort
        int     33h                     ; Kurzor kikapcsol�sa eg�r driverrel
;
; DX-ben a ki�ratand� sz�veg c�me, h�t sim�n ki�rom
;
        mov     ah,9                    ; String ki�rat�s k�dja
        int     21h                     ; Ki�ratom a DOS-sal
;
; Visszakapcsolom a kurzurt
;
        mov     ax,1                    ; Bekapcsolom a kurzort
        int     33h                     ; Kurzor bekapcsol�sa eg�r driverrel
;
; Elimin�lom az als� 3 biteket az X �s Y poz�ci�b�l,
; mivel a kurzor poz�ci�ja 8-al oszthat� �rt�keken van
;
nemiro:
        and     cx,NOT 111b             ; Elt�ntetm az als� 3 bitet a X-b�l
        and     dx,NOT 111b             ; Elt�ntetm az als� 3 bitet az Y-b�l
;
; Null�ra megvizsg�lom X �s Y poz�ci�t
;
        or      dx,cx                   ; Nulla a poz�ci�?
        jnz     azeges                  ; Ez a ciklus
;
; Kil�p�s el�tt kikapcsolom a kurzort
;
        mov     ax,2                    ; Eg�r kurzor kikapcsol�s k�dja
        int     33h                     ; Eg�r kurzor kikapcsol�sa
	mov	ah,4ch
	int	21h

balgom  db      'Bal gomb    ',13,'$'
jobgom  db      'Jobb gomb   ',13,'$'
mindke  db      'Mindk�t gomb',13,'$'
egyiks  db      'Egyik sem   ',13,'$'


code	ends
	end	start

