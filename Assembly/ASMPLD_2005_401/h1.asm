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
;
; Be†ll°tom a m†sol†s kezdãc°mÇt
;
        mov     si,offset vakszo + hossz - 1; A szîveg utols¢ b†jtj†nak c°me
        mov     di,offset ureszo + hossz - 1; A kÇsz utols¢ b†jtj†nak c°me
        mov     dx,offset ureszo        ; A k°ratand¢ szîvegrÇsz c°me
vakcik:
        mov     al,[si]                 ; A bem†soland¢ karakter AL-be
        mov     [di],al                 ; Kiteszem a ki°ratand¢ helyre
        dec     si                      ; LÇpek az elãzãre a forr†ssal
        dec     di                      ; LÇpek a cÇllal is
        mov     ah,9                    ; A ki°rat†skÇrÇs k¢dja
        int     21h                     ; A DOS megh°v†sa annyiszor
        mov     ah,8                    ; NÇma bekÇrÇs k¢dja
        int     21h                     ; DOS h°v†s
        loop    vakcik                  ; A kîvetkezã rÇsz ki°r†sa jîne
;
; KilÇpÅnk a programunkb¢l
;
kilep:
        mov     ah,4ch                  ; A kilÇpÇskÇrÇs k¢dja
        int     21h                     ; A DOS h°v†sa kilÇpÇsre,
                                        ; Innen m†r nem tÇrÅnk vissza!!!!

vakszo  db      'VAKµCI‡!'              ; Ezt kell maj m†solgatni
hossz   equ     $-vakszo                ; A hossz szimb¢lum kisz†m°t†sa

ureszo  db      hossz dup(' '), 10,13,'$'

code	ends
	end	start

