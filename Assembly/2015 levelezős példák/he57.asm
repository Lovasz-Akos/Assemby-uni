code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

darabs  db      ?
        db      ?
parsor  db      126 dup(?)

	org	100h

     
start:
        mov     ax,13h                  ; 320x200-as grafika
        int     10h                     ; VIDEO BIOS-sal t�rl�s
        mov     ax,0a000h               ; Ebben a szegmensben van
        mov     es,ax                   ; ES a grafik�ra mutat
        mov     di,(320 * 40) + 60      ; Itt kezdek
        mov     al,1                    ; 1-es sz�n
        call    csik                    ; Cs�kot rajzolok
        mov     al,2                    ; 2-es sz�n
        call    csik                    ; Cs�kot rajzolok
        mov     al,3                    ; 3-as sz�n
        call    csik                    ; Cs�kot rajzolok
        mov     dx,3c8h                 ; Sz�nsz�m regiszter c�me
        mov     al,0                    ; H�tt�r sz�n sz�m
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,0                    ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,63                   ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre

        mov     al,1                    ; Sz�n sz�m
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,63                   ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre
        mov     al,2                    ; Sz�n sz�m
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,63                   ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,63                   ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,63                   ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre
        mov     al,3                    ; Sz�n sz�m
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,0                    ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,63                   ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; V�rok DOS-sal

        mov     al,3                    ; Sz�n sz�m
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,63                   ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre
        mov     al,1                    ; Sz�n sz�m
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,0                    ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,63                   ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre
        mov     al,0                    ; Sz�n sz�m (h�tt�r)
        out     dx,al                   ; Kik�ldtem
        inc     dx                      ; A sz�n�sszetev�k c�me
        mov     al,0                    ; R �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; G �sszetev�
        out     dx,al                   ; Kik�ldtem
        mov     al,0                    ; B �sszetev�
        out     dx,al                   ; Kik�ldtem
        dec     dx                      ; Vissza a sz�nsz�m regiszterre
        mov     ah,8                    ; N�ma le�t�sv�r�s k�dja
        int     21h                     ; V�rok DOS-sal
        mov     ax,3                    ; T�rl�shez k�d
        int     10h                     ; VIDEO BIOS-sal t�rl�s
        mov     ah,4ch
        int     21h
csik:
        mov     cx,30                   ; Ennyi sor
huz:
        push    cx                      ; El fogom rontani
        mov     cx,200                  ; Ennyi hossz�
        rep     stosb                   ; Kiteszem a cs�kot
        add     di,120                  ; A sor elej�re      
        pop     cx                      ; Vissza
        loop    huz                     ; T�bbsz�r
        ret                             ; k�sz

egysem  db      'Egyik sem',13,'$'
balgom  db      'Bal gomb ',13,'$'
jobgom  db      'Jobb gomb',13,'$'
mindke  db      'Mindkett�',13,'$'

code	ends
	end	start

