code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
	
szeles	EQU	80				; Ennyi pont sz‚les lesz egy sz¡n
magas	EQU	150				; Ennyi sor "magas" lesz a z szl¢

kezsor	EQU	(200 - magas) / 2		; Ebben a sorban kezd‹dik
kezosz	EQU	(320 - ( 3 * szeles)) / 2	; Ez a kezd‚s oszlopa
kezpos	EQU	(kezsor * 320) + kezosz		; A z szl¢ kezd‹pontja

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
; Val¢j ban lett volna m¢d a kezd‹ poz¡ci¢t	;
; £gy meghat rozni, hogy			;
;(((200 - (3 * magas)) / 2) * 320) + ((320- szeles) / 2);
; csak ‚rthet‹ m¢don kev‚sb‚  tl that¢. :-)	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,kezpos				; Itt kezd‹dik a z szl¢
	mov cx,magas				; Ennyiszer kell a sorokat kit”lteni
zamato:
	push cx					; Elromlana
	mov al,0				; Kezd‹‚rt‚k
zacipa:
	inc al					; A k”vetkez‹ sz¡nsz m
	mov cx,szeles				; Ennyi pontot kell kitenni
	rep stosb				; Kiteszem AL szerint a pontokat
	cmp al,3				; Van m‚g?
	jnz zacipa				; Igen, m‚g van a sorb¢l
	add di,320 - (3 * szeles)		; A k”vetkez‹ sor elej‚re l‚pek
	cmp al,3				; Van m‚g sz¡nsz m?
	jnz zacipa				; Mehet m‚g a k”vetkez‹ sz¡nre
	pop cx					; Vissza a sorsz ml l¢
	loop zamato				; Van m‚g a sorokb¢l
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
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
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
; Indul a "legfels‹" sz¡n kialak¡t sa
;
	mov al,1				; A "legfels‹" sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
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
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
;
; Minden ”sszetev‹ 63, azaz feh‚r lesz
;	
	mov al,63				; A sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
;
; Indul az "als¢" sz¡n kialak¡t sa
;
	mov al,3				; Az "als¢" sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
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
; A h tt‚r, a "fels‹" ‚s "als¢" sz¡neket 	;
; £jra be ll¡tom.				;
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
; Indul a "legfels‹" sz¡n kialak¡t sa
;
	mov al,1				; A "legfels‹" sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
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
; Indul az "als¢" sz¡n kialak¡t sa
;
	mov al,3				; Az "als¢" sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nbek c¡m‚re
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

