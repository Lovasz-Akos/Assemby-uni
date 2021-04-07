code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; Hogy az �zemm�d ilyen legyen...
        int     10h                     ; Be�ll�tom
        cld                             ; N�vekv� c�mes stringm�veletek
        mov     ax,0b800h               ; Ez a szegmens �rt�ke
        mov     es,ax                   ; ES <- B800 t�lt�s
        mov     ax,0700h + ' '          ; Ezzel fogom kit�lteni az eg�szet
        mov     cx,80 * 25              ; Ennyi a hossza a k�perny�nek
        xor     di,di                   ; Az offszet legyen 0
        rep     stosw                   ; Let�r�l�m az eg�sz k�perny�t

        mov     di,((2 * 80) + 30) * 2  ; A m�sodik sorba a Z-k hely�re l�pek
        mov     ax,0700h + 'Z'          ; Ezzel fogom kit�lteni
        mov     cx,20                   ; Ennyi a hossza a bet�nek
        rep     stosw                   ; Kiteszem a Z bet�ket
        mov     cx,18                   ; Ennyi a magass�ga a bet�nek
zbetki:
        add     di,78 * 2               ; �tl�pek a soban, de vissza is
        stosw                           ; Kimegy a bet�
        loop    zbetki                  ; Ki-ki teszem a sorokba
        add     di,78 * 2               ; �tl�pek a soban, de vissza is
        mov     cx,20                   ; Ennyi a hossza a bet�nek
        rep     stosw                   ; Kiteszem a Z bet�ket
        mov     ah,8                    ; Le�t�sv�r�s k�dja
        int     21h                     ; Kiv�rom a le�t�st
	mov	ah,4ch
	int	21h

code	ends
	end	start

