code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢dv†lt†s
        int     10h                     ; VIDEO BIOS h°v†sa, m¢dv†lt†shoz
        mov     bl,99                   ; Ezzel kezdek
;
; A ciklust ki°rat†ssal kezdem
;
tokici:
        mov     al,bl                   ; Ezt kell dek¢dolni
        aam                             ; Mintha szoroztam volna
        mov     bh,al                   ; M†solat az L rÇszrãl
        mov     dl,ah                   ; Az elsã NUMERIKUS ÇrtÇk
        or      dl,'0'                  ; KarakterrÇ alak°tom
        mov     ah,2                    ; Karakterki°rat†s k¢dja
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,bh                   ; A 2. karakter NUMERIKUS ÇrtÇkben
        or      dl,'0'                  ; KarakterrÇ alak°tom
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,13                   ; A CR karakter
        int     21h                     ; Megy ki a karakter DOS-sal
        mov     dl,10                   ; Az LF karakter
        int     21h                     ; Megy ki a karakter DOS-sal

        dec     bl                      ; ElÇrte?
        jz      kilep                   ; Igen, akkorm befejezem
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; V†rok leÅtÇsre DOS-sal
        cmp     al,27                   ; ESC jîtt?
        jnz     tokici                  ; Nem akkor jîn a tov†bbi ki°rat†s
kilep:
	mov	ah,4ch
	int	21h

code	ends
	end	start

