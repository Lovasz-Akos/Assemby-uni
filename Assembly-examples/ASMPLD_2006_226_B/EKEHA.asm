code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãm¢d be†ll°t†s k¢dja
        int     10h                     ; ÷gy letîrli (alaphelyztbe hozza)
        mov     cx,10                   ; Maximum ennyi leÅtÇsre v†rok
        mov     dx,offset csaksz        ; Szîvegc°m
        mov     ah,9                    ; Ki°rat†s k¢dja
        int     21h                     ; DOS h°v†sa ki°rat†sra
ujkerd:
        mov     ah,8                    ; Visszhng nÇlkÅli!!! bekÇrÇs k¢dja
        int     21h                     ; DOS h°v†sa leÅtÇsv†r†sra
        cmp     al,1bh                  ; A leÅtÇs ESC volt?
        jz      vegcim                  ; Igen, vÇge a dalnak
        cmp     al,'Q'                  ; A leÅtÇs 'Q' volt?
        jz      vegcim                  ; Igen, vÇge a dalnak
        cmp     al,'q'                  ; A leÅtÇs 'q' volt?
        jz      vegcim                  ; Igen, vÇge a dalnak
        mov     ah,9                    ; Ki°rat†s k¢dja
        mov     dx,offset egyszo        ; Szîvegc°m
        cmp     al,'1'                  ; êppen '1'?
        jz      vakevi                  ; Igen, akkor szîveget °rok
        mov     dx,offset ketszo        ; Szîvegc°m
        cmp     al,'2'                  ; êppen '2'?
        jz      vakevi                  ; Igen, akkor szîveget °rok
        mov     dx,offset harszo        ; Szîvegc°m
        cmp     al,'3'                  ; êppen '2'?
        jz      vakevi                  ; Igen, akkor szîveget °rok
        mov     dl,al                   ; DL-bãl ki°ratom majd
        mov     ah,2                    ; Egy karakter ki°r†s†nak k¢dja
vakevi:
        int     21h                     ; Megh°vom a DOS-t ki°r†sra
        loop    ujkerd                  ; Nem, £j kÇrdÇs jîn
vegcim:
	mov	ah,4ch
	int	21h

csaksz  db      'össîn le betÅket Çs sz†mokat, ESC, Q vagy q vÇge!', 10, 13,'$'
egyszo  db      'egy$'
ketszo  db      'kettã$'
harszo  db      'h†rom$'

code	ends
	end	start

