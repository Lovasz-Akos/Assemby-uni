code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
	
szeles	EQU	320 / 3				; Ennyi pont sz‚les a k‚perny‹ harmada

start:
	mov ax,13h				; MCGA grafikus m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
	mov ax,0a000h				; Az MCGA szegmens ‚rt‚ke
	mov es,ax				; ES <- MCGA szegmens
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; El‹sz”r kit”lt”m a z szl¢ pontjait.		;
; Az 1-es sz¡n lesz a piros, a 2-es a feh‚r,	;
; a 3-as a z”ld. (Majd k‚s‹bb  ll¡tom be a	;
; sz¡neket.)					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	xor di,di				; Itt kezd‹dik a z szl¢
	mov cx,200				; A sorok sz ma
sorkip:
	push cx					; Elrontom
	
	mov al,1				; A "bal" oldali sz¡n sz ma
	mov cx,szeles				; A "bal" oldal sz‚less‚ge
	rep stosb				; Kipakoltam
	mov al,2				; A k”z‚ps‹ r‚sz sz¡n sz ma
	mov cx,320 - (2 * szeles)		; A k”z‚ps‹ r‚sz sz‚less‚ge (indirekt)
	rep stosb				; Kipakoltam
	mov al,3				; A "jobb" oldali sz¡n sz ma
	mov cx,szeles				; A "jobb" oldal sz‚less‚ge
	rep stosb				; Kipakoltam
	pop cx					; Vissza a rontott
	loop sorkip				; Van m‚g sor
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most kialak¡tom a sz¡neket.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,3c8h				; A sz¡nsz m I/O regiszter c¡me
;
; Indul a "bal oldali" sz¡n kialak¡t sa
;
	mov al,1				; A "bal oldali" sz¡n sz ma
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
; Indul a "k”z‚ps‹" sz¡n kialak¡t sa
;
	mov al,2				; A "k”z‚ps‹" sz¡n sz ma
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
; Indul a "jobb oldali" sz¡n kialak¡t sa
;
	mov al,3				; A "jobb oldali" sz¡n sz ma
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
; Indul a "bal oldali" sz¡n kialak¡t sa
;
	mov al,1				; A "bal oldali" sz¡n sz ma
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
; Indul az "jobb oldali" sz¡n kialak¡t sa
;
	mov al,3				; A "jobb oldali" sz¡n sz ma
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
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

code	ends
	end	start

