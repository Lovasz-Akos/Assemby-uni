code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov dx,offset tajeko			; Sz”vegc¡m
	mov ah,9				; String ki¡r s k¢dja
	int 21h					; DOS h¡v sa ki¡rat sra
	mov cl,'a'				; A kezd‹ ‚rt‚k
betuci:
	mov ah,8				; N‚ma beolvas sk‚r‚s k¢dja
	int 21h					; DOS h¡v sa beolvas sra
	cmp al,1bh				; Az ESC az?
	jz kilep				; Igen, kil‚pek
	cmp al,'Q'				; A 'Q' az?
	jz kilep				; Igen, kil‚pek
	cmp al,'q'				; A 'q' az?
	jz kilep				; Igen, kil‚pek
	cmp al,' '				; A sz¢k”z az?
	jnz nemelo				; Nem el‹re l‚p‚s
	add cl,4				; Ugrok el‹re (+1 m r volt el‹z‹leg)
	jmp nemvis				; Ki¡ratom
nemelo:
	cmp al,8				; A BCKSP az?
	jnz nemvis				; Nem vissza l‚p‚s
	add cl,-6				; Ugrok visszafele (a +1 miatt 5 lesz)
nemvis:
	mov dl,cl				; Ezt ¡rja ki
	inc cl					; Egyet l‚epk
	mov ah,2				; Egy karakter ki¡r s k¢dja
	int 21h					; DOS h¡v sa ki¡rat sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A feladat nem ¡rja el‹, hogy az 'a'-n l	;
; kisebb ‚s a 'z'-n‚l nagyobb esetben mi	;
; t”rt‚njen, ez‚rt azzal nem kell foglalkozni.	;
; A LOOP nem j¢ ide, mert CX-t‹l fggene, hogy	;
; h ny ciklus futhatna le.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	jmp betuci				; Vissza a ciklusba
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

tajeko	db 'Betûk ki¡r sa. Sz¢k”zre el‹re, BCKSP-re h tra ugrik. Kil‚pes ESC, Q vagy q.', 13, 10, '$'

code	ends
	end	start

