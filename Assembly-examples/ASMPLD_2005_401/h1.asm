code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; 80x25-�s m�dbe�ll�t�s-k�r�s k�dja
        int     10h                     ; Vide�-kezel� megszak�t�s h�v�s
;
; Be�ll�tom a ciklussz�mnak megfelel�en a CX regisztert
;
        mov     cx,hossz                ; Ez a ciklussz�m
;
; Be�ll�tom a m�sol�s kezd�c�m�t
;
        mov     si,offset vakszo + hossz - 1; A sz�veg utols� b�jtj�nak c�me
        mov     di,offset ureszo + hossz - 1; A k�sz utols� b�jtj�nak c�me
        mov     dx,offset ureszo        ; A k�ratand� sz�vegr�sz c�me
vakcik:
        mov     al,[si]                 ; A bem�soland� karakter AL-be
        mov     [di],al                 ; Kiteszem a ki�ratand� helyre
        dec     si                      ; L�pek az el�z�re a forr�ssal
        dec     di                      ; L�pek a c�llal is
        mov     ah,9                    ; A ki�rat�sk�r�s k�dja
        int     21h                     ; A DOS megh�v�sa annyiszor
        mov     ah,8                    ; N�ma bek�r�s k�dja
        int     21h                     ; DOS h�v�s
        loop    vakcik                  ; A k�vetkez� r�sz ki�r�sa j�ne
;
; Kil�p�nk a programunkb�l
;
kilep:
        mov     ah,4ch                  ; A kil�p�sk�r�s k�dja
        int     21h                     ; A DOS h�v�sa kil�p�sre,
                                        ; Innen m�r nem t�r�nk vissza!!!!

vakszo  db      'VAK�CI�!'              ; Ezt kell maj m�solgatni
hossz   equ     $-vakszo                ; A hossz szimb�lum kisz�m�t�sa

ureszo  db      hossz dup(' '), 10,13,'$'

code	ends
	end	start

