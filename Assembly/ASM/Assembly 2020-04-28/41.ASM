code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov dx,offset gondol			; Sz”vegc¡m
	mov ah,9				; String ki¡r s k¢dja
	int 21h					; DOS h¡v sa ki¡rat sra
	mov cl,'0'				; A legkisebb
	mov ch,'9'				; A legnagyobb
;
; A fels‹ ‚s als¢ ‚rt‚khat rb¢l a "k”zep‚t" kiasz molom
;
ujkerd:
	mov bl,ch				; M solat a nagyobbr¢l
	add bl,cl				; Hozz adom a kisebbet
	shr bl,1				; Most megfelezem, ¡gy a kett‹ k”z”tti ‚rt‚k lesz
;
; Felteszem a k‚rd‚st BL szerint
;
	call kerdes				; K‚rd‚sfelt‚tel BL szerint
	jz avalig				; Igaz v lasz j”tt
;
; Hamis volt a v lasz
;
	mov cl,bl				; Az als¢ ‚rtekhat r a k‚rdezett lesz
;
; Ha egy lenne a kl”nbs‚g a nagyobbra kell r k‚rdeznem
;
	inc bl					; A nagyobbra k‚rdezek r , azaz megn”velem
	jmp egyviz				; Kl”nbs‚g vizsg lat egyre j”het
;
; Igaz volt a v lasz
;
avalig:
	dec bl					; A nagyobb hat r a mostanin l kisebb
	mov ch,bl				; µtm solom a nagyobb hely‚re
;
; Ha als¢ ‚s fels‹ egyforma, k‚sz vagyok
;
	cmp ch,cl				; Egyforma lett?
	jz gondok				; Igen, akkor megvan
;
; Egy a kl”nbs‚g?
;
egyviz:
	mov al,ch				; M solat a magas ‚rt‚kr‹l
	sub al,cl				; Levonom az alacsonyat
	cmp al,1				; M r csak 1 lenne a kl”nbs‚g?
	jnz ujkerd
;
; A kl”nbs‚g most egy, utols¢ k‚rd‚s j”n, a nagyobbra (BL) k‚rdezek
;
	call kerdes				; K‚rd‚sfelt‚tel BL szerint
	jnz gondok				; Hamis a v lasz, azaz a nagyobb az
	dec bl					; Igaz, akkor az als¢ hat r az
;
; Ki¡rom a v laszt
;
gondok:
	mov [gonder],bl				; Kiteszem a v laszt
	mov dx,offset gondst			; Sz”vegc¡m
	mov ah,9				; String ki¡r s k¢dja
	int 21h					; DOS h¡v sa ki¡rat sra
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A k‚rd‚s felt‚tele.				;
;						;
; Input: BL <- a k‚rd‚ses sz m			;
; Output: Z flag <- 1, ha igaz v lasz j”tt,	;
; 		    0, ha hamis v lasz j”tt	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kerdes:
	mov [kissza],bl				; Kiteszem a k‚rd‚s karakter‚t
rosval:
	mov dx,offset kisker			; Sz”vegc¡m
	mov ah,9				; String ki¡r s k¢dja
	int 21h					; DOS h¡v sa ki¡rat sra
	mov ah,1				; Visszhangos beolvas s k¢dja
	int 21h					; DOS h¡v sa beolvas sra
	cmp al,'I'				; Igaz?
	jz avaljo				; Igen, ez megfelel‹ v lasz
	cmp al,'i'				; Igaz?
	jz avaljo				; Igen, ez megfelel‹ v lasz
	cmp al,'H'				; Hamis?
	jz avalha				; A v lasz hamis, ez megfelel‹ v lasz
	cmp al,'h'				; Hamis?
	jnz rosval				; Nem, akkor k‚rd‚s ism‚tl‚s
avalha:
	inc al					; Hamis v laszn l nem nulla be ll¡t s
avaljo:
	ret					; Visszat‚rek

gondol	db 'Gondolj egy sz mra 0 ‚s 9 k”z”tt! ', 13, 10, '$'
;
; A k‚rd‚s kialak¡t sa
;
kisker	db 13, 10, 'Kisebb mint '
kissza	db 1 dup(?)				; A k‚rd‚s hely‚t resen hagyom
	db '? (Igaz vagy Hamis) $'
;
; A v lasz kialak¡t sa
;
gondst	db 13, 10, 'A gondolt sz m a(z) '
gonder	db 1 dup(?)				; A v lasz hely‚t resen hagyom
	db ' volt.$'

code	ends
	end	start

