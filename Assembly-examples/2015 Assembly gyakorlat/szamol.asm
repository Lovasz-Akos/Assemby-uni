

code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; M¢dv†lt†s k¢dja kÇpernyãtîrlÇshez
        int     10h                     ; VIDEO BIOS h°v†sa tîrlÇshez
        mov     bh,'1'                  ; KezdãÇrtÇk
szacik:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; DOS-sal leÅtÇsv†r†s
        cmp     al,27                   ; ESC volt?
        jz      befeje                  ; Igen, akkor vÇge
        cmp     al,'Q'                  ; 'Q' volt?
        jz      befeje                  ; Igen, akkor vÇge
        cmp     al,'q'                  ; 'q' volt?
        jz      befeje                  ; Igen, akkor vÇge
        mov     ah,2                    ; Karakterki°rat†s k¢dja
        mov     dl,bh                   ; Ezt kell ki°rni
        int     21h                     ; Karakterki°rat†s DOS-sal
        mov     dl,13                   ; Ezt kell ki°rni (CR)
        int     21h                     ; Karakterki°rat†s DOS-sal
        mov     dl,10                   ; Ezt kell ki°rni (LF)
        int     21h                     ; Karakterki°rat†s DOS-sal
        inc     bh                      ; Kîvetkezã
        cmp     bh,'9' + 1              ; ElÇrt a vÇgÇre
        jnz     szacik                  ; Nem, ki°rat¢ ciklus
befeje:
        mov     ah,4ch   
        int     21h

szoveg  db      'Assembly'
hossza  equ     $ - szoveg
code	ends
	end	start

