code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; Hogy az Åzemm¢d ilyen legyen...
        int     10h                     ; Be†ll°tom
        cld                             ; Nîvekvã c°mes stringm˚veletek
        mov     ax,0b800h               ; Ez a szegmens ÇrtÇke
        mov     es,ax                   ; ES <- B800 tîltÇs
        mov     ax,0700h + ' '          ; Ezzel fogom kitîlteni az egÇszet
        mov     cx,80 * 25              ; Ennyi a hossza a kÇpernyãnek
        xor     di,di                   ; Az offszet legyen 0
        rep     stosw                   ; Letîrîlîm az egÇsz kÇpernyãt

        mov     di,((2 * 80) + 30) * 2  ; A m†sodik sorba a Z-k helyÇre lÇpek
        mov     ax,0700h + 'Z'          ; Ezzel fogom kitîlteni
        mov     cx,20                   ; Ennyi a hossza a bet˚nek
        rep     stosw                   ; Kiteszem a Z bet˚ket
        mov     cx,18                   ; Ennyi a magass†ga a bet˚nek
zbetki:
        add     di,78 * 2               ; µtlÇpek a soban, de vissza is
        stosw                           ; Kimegy a bet˚
        loop    zbetki                  ; Ki-ki teszem a sorokba
        add     di,78 * 2               ; µtlÇpek a soban, de vissza is
        mov     cx,20                   ; Ennyi a hossza a bet˚nek
        rep     stosw                   ; Kiteszem a Z bet˚ket
        mov     ah,8                    ; LeÅtÇsv†r†s k¢dja
        int     21h                     ; Kiv†rom a leÅtÇst
	mov	ah,4ch
	int	21h

code	ends
	end	start

