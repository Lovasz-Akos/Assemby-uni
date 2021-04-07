code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing
                                                   
	org	100h

     
start:
        mov     ax,3                    ; K�perny�t�rl�shez m�dv�lt�s
        int     10h                     ; Video Bios h�v�sa t�rl�shez
        mov     dx,offset kertxt        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
        mov     bx,offset tarolo        ; T�rol� c�me
pakaka:
        mov     ah,1                    ; Visszhangos le�t�sv�r�s k�dja
kokabe:
        int     21h                     ; DOS-sal v�rok
        mov     [bx],al                 ; Kitettem a le�t�ttet
        cmp     al,13                   ; Enter volt?
        jz      azvolt                  ; Igen, nem k�rek t�bbet
        inc     bx                      ; A t�rol� k�vetkez� elem�re l�pek
        jmp     kokabe                  ; �jat olvasok be
azvolt:
        cmp     bx,offset tarolo        ; �res sor volt?
        jnz     voltso                  ; Nem, volt valamennyi
        mov     dx,offset hibasz        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
        jmp     pakaka                  ; �jra v�rom
voltso:
        mov     dx,offset kerkar        ; Sz�veg c�m
        mov     ah,9                    ; Stringki�r�s k�dja
        int     21h                     ; Ki�rom DOS-sal
        mov     ah,1                    ; Visszhangos le�t�sv�r�s k�dja
        int     21h                     ; DOS-sal v�rok
        mov     cl,'0'                  ; Kezd� �rt�k
        mov     ch,al                   ; Ezt keresem
        mov     bx,offset tarolo        ; T�rol� c�me
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

kertxt  db      'K�rek egy stinget! (Enter a v�ge.)',13,10, '$'
kerkar  db      13,10,'K�rek egy karaktert! $'
hibasz  db      'Nem lehet �res a sor!',13,10,'$'               
talsza  db      13,10,'A tal�latok sz�ma: $'
nincst  db      13,10,'Nincs tal�lat!$'

tarolo  db      100 dup (?)

code	ends
	end	start

