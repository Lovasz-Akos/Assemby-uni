code    segment para   public  'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; KÇpernyãtîrlÇshez m¢d Çs k¢d
        int     10h                     ; Video BIOS h°v†sa
        mov     dx,offset escszo        ; A szîveg c°me
        mov     ah,9                    ; A ki°rat†skÇrÇs k¢dja
        int     21h                     ; A DOS h°v†sa ki°rat†sra
elokez:
        mov     bl,0                    ; Nincs semmi
cikkor:
        mov     ah,8                    ; NÇma leÅtÇsv†r†s k¢dja
        int     21h                     ; A DOS h°v†sa leÅtÇsv†r†sra 
        cmp     al,27                   ; êppen az ESC karakter?
        jz      befeje                  ; Igen, akkor vÇge van
        mov     dl,al                   ; A kiteendã karakter
        mov     ah,2                    ; A ki°rat†skÇrÇs k¢dja
        int     21h                     ; A DOS h°v†sa ki°rat†sra
        cmp     dl,'a'                  ; êppen az 'a' karakter?
        jnz     talble                  ; Nem, akkor 'b'-t vizsg†lom
        mov     bl,1                    ; Jelzem, hogy volt 'a'
        jmp     cikkor                  ; Èj leÅtÇst v†rok
;
; 'a' ut†n a 'b'-t vizsg†lom
;
talble:
        cmp     dl,'b'                  ; êppen a 'b' karakter?
        jnz     talcle                  ; Nem, akkor lehet a 'c'
        cmp     bl,1                    ; Elãtte 'a' volt?
        jnz     elokez                  ; Nem, kezdjÅk az elejÇn
        mov     bl,2                    ; Jelzem, hogy 'b' is volt
        jmp     cikkor                  ; Èj leÅtÇst v†rok
;
; 'b' ut†n a 'c'-re v†rok
;                     
talcle:
        cmp     dl,'c'                  ; êppen a 'c' karakter?
        jnz     elokez                  ; Nem, akkor lehet a 'c'
        cmp     bl,2                    ; Elãtte 'b' volt?
        jnz     elokez                  ; Nem, kezdjÅk az elejÇn
befeje:
	mov	ah,4ch
        int     21h

escszo  db      'ESC, vagy abc egym†s ut†ni leÅtÇsre vÇge!', 13, 10, '$'  

code	ends
	end	start

                                        
