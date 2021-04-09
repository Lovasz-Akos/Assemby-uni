code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
    mov ax,3
    int 10h

gombnyom:
    mov ah,8        ;silent beolvas
    int 21h

    cmp al,27       ;ha esc akkor kilep
    jz kilep
    
    inc bx          ;ennyiszer fog irni, folyton novelem

    mov ah, 2       ;lathato kiiras
    mov dl, al      ;dl-be teszem amit beolvastam, mert dl-bol ir ki ah,2 miatt az int 21h
    
    mov cx,bx       ;a loop addig megy, amennyi a cx-ben van, ebbe mindig beteszem az egyre nagyobb bx-et, a loop lentebb annyiszor fut le
kiiro:
    int 21h         ;minden interruptra kiirja loop-szor a dl tartalmát, itt bx-szer az utolso dl-t
    loop kiiro
    jmp gombnyom    ;ha ki loopolta magat, mehet a kovetkezo olvasas


kilep:
	mov ah,4ch					;kilépés
	int 21h						;dos kilépés

code	ends
	end	start
