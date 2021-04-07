code    segment para   public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K‚perny‹t”rl‚shez m¢d ‚s k¢d
        int     10h                     ; Video BIOS h¡v sa
        mov     dx,offset escszo        ; A sz”veg c¡me
        mov     ah,9                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
cikkor:
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r sra 
        cmp     al,27                   ; ppen az ESC karakter?
        jz      befeje                  ; Igen, akkor v‚ge van
        mov     dl,al                   ; A kiteend‹ karakter
        mov     ah,2                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        cmp     dl,'a'                  ; ppen az 'a' karakter?
        jnz     cikkor                  ; M‚g van mit ki¡rni
;
; 'a' u n a 'b'-t v rom
;
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r sra 
        cmp     al,27                   ; ppen az ESC karakter?
        jz      befeje                  ; Igen, akkor v‚ge van
        mov     dl,al                   ; A kiteend‹ karakter
        mov     ah,2                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        cmp     dl,'b'                  ; ppen a 'b' karakter?
        jnz     cikkor                  ; Nem, akkor vissza az eredetibe
;
; 'b' ut n a 'c'-re v rok
;
        mov     ah,8                    ; N‚ma let‚sv r s k¢dja
        int     21h                     ; A DOS h¡v sa let‚sv r sra 
        cmp     al,27                   ; ppen az ESC karakter?
        jz      befeje                  ; Igen, akkor v‚ge van
        mov     dl,al                   ; A kiteend‹ karakter
        mov     ah,2                    ; A ki¡rat sk‚r‚s k¢dja
        int     21h                     ; A DOS h¡v sa ki¡rat sra
        cmp     dl,'c'                  ; ppen a 'b' karakter?
        jnz     cikkor                  ; Nem, akkor vissza az eredetibe
befeje:
	mov	ah,4ch
        int     21h

escszo  db      'ESC, vagy abc egym s ut ni let‚sre v‚ge!', 13, 10, '$'  

code	ends
	end	start

                                        
