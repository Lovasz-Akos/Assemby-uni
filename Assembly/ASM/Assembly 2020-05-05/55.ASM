code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
	
start:
	mov si,80h				; A parancssor sz ml l¢ja
	lodsb					; Beolvasom
	cmp al,2				; J¢ a mennyis‚g?
	jnz helpre				; Nem j¢
	inc si					; µtlpem a hat rol¢t
	lodsb					; Beolvasom a sz‚less‚get
	cmp al,'1'				; Enn‚l kisebb?
	jb helpre				; Igen, akkor ez nem j¢
	cmp al,'9'				; Enn‚l nagyobb?
	jbe paramo				; Nem, akkor ez j¢
helpre:
	mov dx,offset helpsz			; Sz”vegc¡m
	mov ah,9				; String ki¡rat s k¢dja
	int 21h					; DOS h¡v s ki¡rat sra
	jmp kilep				; Befejezem
paramo:
	and ax,0000000000001111b		; AX <- darabsz m
	mov bp,ax				; µtm soltam
	mov ax,13h				; MCGA grafikus m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
	mov ax,0a000h				; Az MCGA szegmens ‚rt‚ke
	mov es,ax				; ES <- MCGA szegmens
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; El‹sz”r kit”lt”m a vonalok pontjait.		;
; Az 1-es sz¡n lesz a piros, a 2-es a feh‚r,	;
; a 3-as a z”ld. (Majd k‚s‹bb  ll¡tom be a	;
; sz¡neket.)					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov si,320 * 100			; A fele k‚perny‹ poz¡ci¢ja
	mov cx,3				; H rom vonal lesz kit‚ve
	mov bl,0				; Az els‹ vonal el‹tti sz¡n sz ma
vonkip:
	inc bl					; A sz¡n sz ma
	mov al,bl				; µtm soltam
	mov cx,bp				; A vonal sz‚less‚ge
vonali:
	mov di,si				; Kezd‹ poz¡ci¢
tovoki:
	stosb					; Egy pont kit‚tel
	add di,320				; A k”vetkez‹ sorra
	cmp di,320 * 200			; T£l ny£lik m r a terleten?
	jb tovoki				; Nem, m‚g tart a vonal
	add si,320				; Egy sorral lejebb lesz a kezdet
	loop vonali				; A vonal kit‚tel ciklusban
	mov ax,320				; Egy sor m‚rete
	mul bp					; Megszorzom a m‚rettel
	add si,ax				; Itt a h‚zag eltol sa
	cmp bl,3				; Van m‚g vonal?
	jnz vonkip				; Van m‚g vonal
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most kialak¡tom a sz¡neket.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,3c8h				; A sz¡nsz m I/O regiszter c¡me
;
; Indul az h tt‚r sz¡n kialak¡t sa
;
	mov al,0				; A h tt‚r sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Igaz b¢l nem kellene az AL-t t”lteni, hiszen az van benne,
; csak ¡gy  tl that¢bb
;
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
; Indul az els‹ vonal sz¡n kialak¡t sa
;
	mov al,1				; Az els‹ vonal sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Csak a piros ‚rt‚ke nem 0
;	
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
; Indul a m sodik vonal sz¡n kialak¡t sa
;
	mov al,2				; A m sodik vonal sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Minden ”sszetev‹ 63, azaz feh‚r lesz
;	
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
; Indul a harmadik vonal sz¡n kialak¡t sa
;
	mov al,3				; A harmadik vonal sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Csak a z”ld ‚rt‚ke nem 0
;	
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; V rok let‚sre, hogy "l tsz¢djon".		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov ah,8				; N‚ma let‚sv r s k¢dja
	int 21h					; DOS h¡v sa beolvas sra (v rkoz sra)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A "bal oldali" ‚s a "jobb oldali" sz¡neket 	;
; £jra be ll¡tom.				;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Indul az h tt‚r sz¡n kialak¡t sa
;
	mov al,0				; A h tt‚r sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Igaz b¢l nem kellene az AL-t t”lteni, hiszen az van benne,
; csak ¡gy  tl that¢bb
;
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
; Indul az els‹ vonal sz¡n kialak¡t sa
;
	mov al,1				; Az els‹ vonal sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Csak a z”ld ‚rt‚ke nem 0
;	
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
; Indul a harmadik vonal sz¡n kialak¡t sa
;
	mov al,3				; A harmadik vonal sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; Csak a piros ‚rt‚ke nem 0
;	
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	mov al,0				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; V rok let‚sre, hogy "l tsz¢djon".		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov ah,8				; N‚ma let‚sv r s k¢dja
	int 21h					; DOS h¡v sa beolvas sra (v rkoz sra)
;
; Vissza llok karakteres zemm¢dra, ‚s kil‚pek
;	
	mov ax,3				; 80X25-”s sz¡nes m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

helpsz	db 'Haszn lata: 55 sz‚less‚g. (Sz‚less‚g 1..9 lehet!)', 13, 10, '$'

code	ends
	end	start

