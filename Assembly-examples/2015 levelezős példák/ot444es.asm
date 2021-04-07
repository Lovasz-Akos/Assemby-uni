code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

darabs  db      ?
        db      ?
parsor  db      126 dup(?)

	org	100h

     
start:
        cmp     [darabs],0              ; Van valamennyi?
        jnz     voltso                  ; Igen, van
        mov     dx,offset hibasz        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
        jmp     endaka                  ; Kil�pek
voltso:
        mov     dx,offset kerkar        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
        mov     ah,1                    ; Visszhangos le�t�sv�r�s k�dja
        int     21h                     ; DOS-sal v�rok
        mov     cl,'0'                  ; Kezd� �rt�k
        mov     ch,al                   ; Ezt keresem
        mov     bx,offset parsor        ; T�rol� c�me
talszv:
        cmp     [bx],ch                 ; Ez volt az?
        jnz     masvol                  ; Nem, m�s volt
        inc     cl                      ; Az volt, sz�ml�lok
masvol:
        inc     bx                      ; K�vetkez�
        cmp     byte ptr [bx],13        ; CR volt?
        jnz     talszv                  ; Nem, tov�bb vizsg�lok
        cmp     cl,'0'                  ; Volt valamennyi?
        jz      egysem                  ; Nem volt tal�lat
        mov     dx,offset talsza        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
        mov     ah,2                    ; Egy karakter ki�r�s k�dja
        mov     dl,cl                   ; Ez j�n ut�na
        int     21h                     ; Ki�rom DOS-sal
        jmp     endaka                  ; Most v�ge
egysem:
        mov     dx,offset nincst        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
endaka:
        mov     ah,4ch
        int     21h

kerkar  db      13,10,'K�rek egy karaktert! $'
hibasz  db      'Nem lehet �res a parancs param�tere!',13,10,'$'               
talsza  db      13,10,'A tal�latok sz�ma: $'
nincst  db      13,10,'Nincs tal�lat!$'

code	ends
	end	start

