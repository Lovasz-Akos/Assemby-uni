code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
        mov     ax,3                    ; KÇpernyîtîrlÇs m¢dbe†ll°t†ssal k¢d
        int     10h                     ; Video BIOS h°v†sa a tîrlÇshez
        mov     ah,9                    ; String ki°rat†s k¢dja
        mov     dx,offset teendo        ; A szîveg c°me
        int     21h                     ; DOS-sal ki°ratom a stringet
        mov     bl,1                    ; Ennyivel kezdek
        mov     ch,0                    ; A H rÇszt is null†zni kell!!!!!!!
karcik:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; A DOS h°v†sa leÅtÇsv†r†sra
        cmp     al,27                   ; Az ESC volt az?
        jz      kilep                   ; Igen, akkor befejeztem
        mov     dl,al                   ; Ezt a karaktert kell ki°rni
        mov     ah,2                    ; Karakter ki°rat†s k¢dja
        mov     cl,bl                   ; Ennyiszer kell ki°ratni
kaciki:
        int     21h                     ; Ciklusban h°vogatom a DOS-t
        loop    kaciki                  ; Ki°rat¢ ciklus

        inc     bl                      ; Egyel tîbbszîr kell m†r ezut†n
        jmp     karcik                  ; Vissza a leÅtÇsv†r†sra
kilep:
	mov	ah,4ch
	int	21h

teendo  db      'össÇl le billenty˚ket. KilÇpÇs ESC-re.', 13, 10, '$'

code	ends
	end	start

