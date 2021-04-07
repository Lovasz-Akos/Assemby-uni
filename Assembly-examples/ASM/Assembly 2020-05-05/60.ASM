code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
	
szeles	EQU	5				; Ilyen sz‚les a vonal
magas	EQU	150				; Ennyi sor "magas" lesz az "A" betû

kezsor	EQU	(200 - magas) / 2		; Ebben a sorban kezd‹dik
kezosz	EQU	(320 - szeles) / 2		; Ez a kezd‚s oszlopa
kezpos	EQU	(kezsor * 320) + kezosz		; Az "A" betû kezd‹pontja

vonlef	EQU	(magas / 3) * 2			; Itt lesz a vizszintes vonal
vonpos	EQU	(vonlef * 320) + kezpos - vonlef + szeles; Itt kezd‹dik a vonal
vonhos	EQU	(vonlef * 2) - szeles		; A vonal hossza kezdetben

start:
	mov ax,13h				; MCGA grafikus m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
	mov ax,0a000h				; Az MCGA szegmens ‚rt‚ke
	mov es,ax				; ES <- MCGA szegmens
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; El‹sz”r kit”lt”m az "A" betû balra tart¢	;
; pontjait. Az 1-es sz¡n lesz a maga a betû.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov al,1				; Az "A" betû sz¡ne
	mov di,kezpos				; Itt kezd‹dik az "A" betû
	mov cx,magas				; Ennyi sort kell kitenni
balraa:
	push cx					; Elrontom "mingy "
	mov cx,szeles				; Ennyi a sz‚less‚g most
	rep stosb				; Kiteszem a sort
	add di,(320 - szeles) - 1		; A -1 miatt "balra" tart
	pop cx					; Vissza a rontott
	loop balraa				; M‚g kell kitenni
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most kit”lt”m az "A" betû jobbra tart¢	;
; pontjait. 					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,kezpos				; Itt kezd‹dik az "A" betû
	mov cx,magas				; Ennyi sort kell kitenni
jobbra:
	push cx					; Elrontom "mingy "
	mov cx,szeles				; Ennyi a sz‚less‚g most
	rep stosb				; Kiteszem a sort
	add di,(320 - szeles) + 1		; A +1 miatt "jobbra" tart
	pop cx					; Vissza a rontott
	loop jobbra				; M‚g kell kitenni
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most kit”lt”m az "A" betû vizszintes r‚sz‚t.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,vonpos				; Itt kezd‹dik az "A" betû
	mov cx,szeles				; Ennyi sort kell kitenni
	mov bx,vonhos				; A vonal hossza kezdetben
viszcs:
	push cx					; Elrontom "mingy "
	mov cx,bx				; Ennyi a sz‚less‚g most
	rep stosb				; Kiteszem a sort
	add di,320				; Egy sorral lejebb
	sub di,bx				; A hosszal vissza az elej‚re
	dec di					; Egy ponttal "balra"
	add bx,2				; Mindk‚t ir nyba +1
	pop cx					; Vissza a rontott
	loop viszcs				; M‚g kell kitenni
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most kialak¡tom a sz¡neket.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,3c8h				; A sz¡nsz m I/O regiszter c¡me
	mov al,0				; A h tt‚r sz¡nsz ma
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
; Indul az "A" betû sz¡n kialak¡t sa
;
	mov al,1				; Az "A" betû sz¡n sz ma
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
; A h tt‚r ‚s betû sz¡neket £jra be ll¡tom.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov al,0				; A h tt‚r sz¡nsz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
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
; Indul az "A" betû sz¡n kialak¡t sa
;
	mov al,1				; Az "A" betû sz¡n sz ma
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
; Vissza llok karakteres zemm¢dra, ‚s kil‚pek
;	
	mov ax,3				; 80X25-”s sz¡nes m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

code	ends
	end	start

