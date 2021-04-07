code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
	
szeles	EQU	100				; Ennyi pont sz‚les lesz a trap‚z teteje
magas	EQU	150				; Ennyi sor "magas" lesz a trap‚z

kezsor	EQU	(200 - magas) / 2		; Ebben a sorban kezd‹dik
kezosz	EQU	(320 - (szeles + magas)) / 2	; Ez a kezd‚s oszlopa
kezpos	EQU	(kezsor * 320) + kezosz		; A trap‚z kezd‹pontja

start:
	mov ax,13h				; MCGA grafikus m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
	mov ax,0a000h				; Az MCGA szegmens ‚rt‚ke
	mov es,ax				; ES <- MCGA szegmens
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; El‹sz”r kit”lt”m a trap‚z pontjait.		;
; Az 1-es sz¡n lesz a maga a trap‚z.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,kezpos				; Itt kezd‹dik a trap‚z
	mov si,320 - szeles			; Ilyen t vol van (lesz) a
						; k”vetkez‹ sor kezdete
	mov bx,szeles				; Ilyen sz‚les a kezd‹sor
	mov al,1				; A trap‚z sz¡ne
	mov cx,magas				; Ennyi sort kell kitenni
trapez:
	push cx					; Elrontom "mingy "
	mov cx,bx				; Ennyi a sz‚less‚g most
	rep stosb				; Kiteszem a sort
	add di,si				; A k”vetkez‹ sor elej‚re l‚pek
	inc bx					; Egyel hosszabb a k”vetkez‹ sor
	dec si					; A t vols g viszont egyel kevesebb
	pop cx					; Vissza a rontott
	loop trapez				; M‚g kell kitenni
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
; Indul a trap‚z sz¡n kialak¡t sa
;
	mov al,1				; A trap‚z sz¡n sz ma
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
; A h tt‚r ‚s trap‚z sz¡neket £jra be ll¡tom.	;
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
; Indul a trap‚z sz¡n kialak¡t sa
;
	mov al,1				; A trap‚z sz¡n sz ma
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

