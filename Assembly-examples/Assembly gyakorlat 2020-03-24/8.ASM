code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov dx,offset tajeko	; A ki¡ratand¢ sz”veg c¡me
	mov ah,9				; A string ki¡rat s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
	mov cx,10				; Legfeljebb ennyi let‚s lehet
ciklus:
	mov ah,8				; N‚ma beolvas s k¢dja
	int 21h					; A DOS h¡v sa beolvas sra
	cmp al,1bh				; ppen ESC volt a let‚s?
	jz kilep				; Igen, akkor kil‚pek
	cmp al,'q'				; ppen a 'q' volt a let‚s?
	jz kilep				; Igen, akkor kil‚pek
	cmp al,'Q'				; ppen a 'Q' volt a let‚s?
	jz kilep				; Igen, akkor kil‚pek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
; Mivel csak betûk ‚s sz mok a let‚sek			;
; ‚s a betûk a sz mokat k”vetik a(z ASCII)		;
; sorban, el‚g megvizsg lni, hogy a '9'-n‚l 	;
; (el‹jel n‚lkl!!!) nagyobb-e. Ha igen, 		;
; akkor nem sz m.								;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp al,'9'				; ™sszehasonl¡tom a '9' karakterrel
	ja nemsza				; Nagyobb, azaz nem lehet sz m
;
; Most sz m, lehet ki¡rni
;	
	mov dl,al				; Ez a ki¡ratand¢ karakter
	mov ah,2				; Egy karakter ki¡rat s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
nemsza:
	loop ciklus				; Annyiszor, amit a CX-be tettem vissza
kilep:
	mov	ah,4ch				; A kil‚p‚s k¢dja
	int	21h					; A DOS h¡v sa kil‚p‚sre

tajeko	db 'šss”n be betûket ‚s sz mokat, Esc, q, Q - v‚ge!', 13, 10, '$'

code	ends
	end	start

