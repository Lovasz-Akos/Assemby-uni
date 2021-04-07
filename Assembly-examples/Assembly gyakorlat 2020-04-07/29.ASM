code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing


;
	org	100h
;
start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov cx,txtlen				; Ennyiszer kell ki¡rni
	mov dx,offset amitki			; A ki¡ratand¢ sz”veg c¡me
	mov ah,9				; A string ki¡rat s k¢dja
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Mivel a ki¡ratand¢ stringet akarom 		;
; m¢dos¡tani, haszn lom a c¡m‚t			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,dx				; A string c¡me
ciklus:
	int 21h					; A DOS h¡v sa ki¡r sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Ki lett ¡rva, most t”rl”m a soron k”vetkez‹	;
; karaktert. Mivel "nem tudja", hogy b jtos	;
; vagy szavas az ‚rt‚k, jelezni kell!		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov byte ptr [di],' '			; Sz¢k”zzel helyettes¡tem
	inc di					; L‚pek a k”vekez‹ karakter hely‚re
	loop ciklus				; Csin lom ciklusban
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

amitki	db	'Assembly'
txtlen	EQU	$ - amitki			; Meghat rozom a sz”veg hossz t
	db	13, 10, '$'			; A v‚g‚re CR ‚s LF j”n
code	ends
	end	start

