code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

                      
start:
        mov     ax,3                    ; K‚perny‹t”rl‚shez m¢dv lt s k¢dja
        int     10h                     ; VIDEO BIOS-al k‚perny‹t”rl‚s
        mov     dx,offset hogyhi        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡rat s k¢dja
        int     21h                     ; DOS h¡v sa ki¡rat shoz
        mov     cx,10                   ; Maximum ennyi karakterb‹l  ll
        mov     bx,offset nevhel        ; A t rol¢ els‹ c¡me
karbeo:
        mov     ah,8                    ; N‚ma beolvas s k¢dja
        int     21h                     ; A DOS seg¡ts‚g‚vel beolvasok
        cmp     al,13                   ; ENTER volt?
        jz      endaci                  ; Igen, a ciklus v‚g‚re
        mov     ah,2                    ; Karakter ki¡rat s k¢dja
        mov     dl,al                   ; Karakter ki¡rat sra
        int     21h                     ; DOS ki¡rat sra
        mov     [bx],al                 ; Kiteszem a t rol¢ba
        inc     bx                      ; A k”vetkez‹ t rol¢c¡mre l‚pek
        loop    karbeo                  ; Ciklusban beolvasok
endaci:
        mov     byte ptr [bx],'$'       ; Kiteszem a t rol¢ba
        mov     ah,9                    ; Stringki¡rat s k¢dja
        mov     dx,offset nemane        ; Sz”vegc¡m
        cmp     bx,offset nevhel        ; Valamennyi v lasz v lasz volt?
        jz      nevova                  ; Nem volt
        mov     dx,offset sziasz        ; Sz”vegc¡m
        int     21h                     ; DOS h¡v sa ki¡rat shoz
        mov     dx,offset nevhel        ; A t rol¢ els‹ c¡me
        int     21h                     ; DOS ki¡rat sra
        mov     dx,offset sziave        ; Sz”vegc¡m
nevova:
        int     21h                     ; DOS h¡v sa ki¡rat shoz
	mov	ah,4ch
        int     21h

nemane  db      13, 10, 'Nem adt l meg nevet!', 13,10,'$'
sziave  db      '!', 13,10,'$'
sziasz  db      13,10,'Szia $'

hogyhi  db      'Hogy h¡vnak? $'

nevhel  db      11 dup(?)

code	ends
	end	start

