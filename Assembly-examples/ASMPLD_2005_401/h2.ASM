code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80x25-îs m¢dbe†ll°t†s-kÇrÇs k¢dja
        int     10h                     ; Vide¢-kezelã megszak°t†s h°v†s
;
; Be†ll°tom a ciklussz†mnak megfelelãen a CX regisztert
;
        mov     cx,hossz                ; Ez a ciklussz†m
        mov     bx,offset vakszo + hossz - 1; A szîveg utols¢ b†jtj†nak c°me
;
; Ez a ki°rat†s ciklusa
;
vakcik:
;
;Elãszîr a SPACE ki°rat†sa jîn
;
        push    cx                      ; Elromlik a ciklussz†ml†l¢
        dec     cx                      ; Egyel kevesebbet
        jcxz    nemspc                  ; Ha °gy a CX 0, nem tesz sz¢kîzîket
        mov     ah,2                    ; Karakterki°r†si k¢d
        mov     dl,' '                  ; A sz¢kîz, amit ki°runk
spkirc:
        int     21h                     ; DOS h°v†sa karakterki°r†sra
        loop    spkirc                  ; Sz¢kîz cikluis
nemspc:
        pop     cx                      ; Eredeti sz†ml†l¢ vissza
        mov     ah,9                    ; A ki°rat†skÇrÇs k¢dja
        mov     dx,bx                   ; A k°ratand¢ szîvegrÇsz c°me
        int     21h                     ; A DOS megh°v†sa annyiszor
        mov     ah,8                    ; NÇma bekÇrÇs k¢dja
        int     21h                     ; A DOS megh°v†sa v†r†sra
        dec     bx                      ; Egyel elãtte folytatom
        loop    vakcik                  ; A kîvetkezã rÇsz ki°r†sa jînne
;
; KilÇpÅnk a programunkb¢l
;
kilep:
        mov     ah,4ch                  ; A kilÇpÇskÇrÇs k¢dja
        int     21h                     ; A DOS h°v†sa kilÇpÇsre
                                        ; Innen m†r nem tÇrÅnk vissza!!!!

vakszo  db      'VAKµCI‡!'              ; Ezt kell maj m†solgatni
hossz   equ     $ - vakszo              ; A HOSSZ sz°mb¢lum ÇrtÇkad†sa

        db      10,13,'$'               ; LF, CR, majd vÇge jel

code	ends
	end	start

