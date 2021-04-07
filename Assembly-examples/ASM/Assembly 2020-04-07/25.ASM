code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing


;
	org	100h
;
start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov dx,offset tajeko			; A ki¡ratand¢ sz”veg c¡me
	mov ah,9				; A string ki¡rat s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
	mov cx,10				; Maximum ennyi lehet
ciklus:
	mov ah,8				; A n‚ma beolvas s k¢dja
	int 21h					; A DOS h¡v sa bolvas sra
	cmp al,1bh				; ppen az ESC az?
	jz kilep				; Igen, akkor kil‚pek
	cmp al,'Q'				; ppen a 'Q' az?
	jz kilep				; Igen, akkor kil‚pek
	cmp al,'q'				; ppen a 'q' az?
	jz kilep				; Igen, akkor kil‚pek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Mivel csak betûket v rok, nem kell csak	;
; azt eld”nteni, hogy kis vagy nagy betû.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp al,'Z'				; Ha enn‚l nagyobb, akkor kisbetû
	ja kisbet				; Nagyobb, azaz kisbetû
	add al,'a'-'A'				; A kl”nbs‚get hozz adom
	jmp kiiras				; Mehet ki¡rni
kisbet:
	sub al,'a'-'A'				; A kl”nbs‚ggel visszal‚pek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Az ASCII k¢dt bla saj toss ga miatt a		;
; vizsg lat helyett el‚g (lett volna) csak a	;
; kl”nbs‚g bitet komplement lni, azaz		;
; XOR AL,00100000b utas¡t ssal  tv ltani!	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
kiiras:
	mov dl,al				; Ez a ki¡ratand¢
	mov ah,2				; Egy karakter ki¡r s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
	loop ciklus				; Csin lom ciklusban
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

tajeko	db	'K‚rek betûket!', 13, 10, '$'
	db	5000 dup (0)
code	ends
	end	start

