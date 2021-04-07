code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov	cx,txtlen			; Ennyit l‚p lefele
	mov dx,offset lelepo	; A ki¡ratand¢ sz”veg c¡me
	mov ah,9				; A string ki¡rat s k¢dja
lecikl:
	int 21h					; A DOS h¡v sa ki¡r sra
	loop lecikl				; Lel‚pek
	mov	ax,0b800h			; A k‚perny‹ karakteres szegmense
	mov	es,ax				; ES kit”lt‚se vele
	mov	cx,txtlen			; Ennyit l‚p lefele
	mov si,offset szoveg	; Ezt teszem kil‚p‚s
	mov	di,20				; A legfels‹ sor 10. karakteres
	mov	ah,10101001b		; Z”ld h tt‚r, intenz¡v k‚k villogva
cikami:
	lodsb					; AL <-  karakter beolvas s
	stosw					; Kiteszem a karktert ‚s sz¡ninform ci¢t
	add	di,80 * 2			; A k”vetkez‹m sorba
	loop cikami				; Kipakol¢ ciklus
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

lelepo db 13, 10, '$' 
szoveg db 'Assembly'
txtlen equ $ - szoveg


code	ends
	end	start

