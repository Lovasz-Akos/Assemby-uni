code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

     
start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; Video Bios h°v†sa tîrlÇshez
        mov     bx,1                    ; Ennyivel kezdÅnk
ujsoki:
        mov     si,offset asstxt        ; Itt kezdÅnk
        mov     cx,bx                   ; µtteszem a ciklussz†mot
        mov     ah,2                    ; Egy karakter ki°rat†s k¢dja
kakici:
        mov     dl,[si]                 ; Ez a karakter a ki°ratand¢
        inc     si                      ; LÇpek a kîvetkezãre
        int     21h                     ; Ki°rom DOS-sal
        loop    kakici                  ; Ciklusban
        mov     dl,13                   ; CR karakter
        int     21h                     ; Ki°rom DOS-sal
        mov     dl,10                   ; LF karakter
        int     21h                     ; Ki°rom DOS-sal
        inc     bx                      ; Kîvetkezã mennyisÇg
        cmp     bx,betnum               ; Van mÇg h†tra?
        jbe     ujsoki                  ; Mehet ki £jra

        mov     ah,4ch
        int     21h

asstxt  db      'Assembly'
betnum  equ     $-asstxt


code	ends
	end	start

