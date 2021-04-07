code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h
	
start:
	mov si,80h				; A parancssor sz ml l¢ja
	lodsb					; Beolvasom
	cmp al,2				; J¢ a mennyis‚g?
	jnz helpre				; Nem j¢
	inc si					; µtlpem a hat rol¢t
	lodsb					; Beolvasom a sz‚less‚get
	cmp al,'1'				; Enn‚l kisebb?
	jb helpre				; Igen, akkor ez nem j¢
	cmp al,'9'				; Enn‚l nagyobb?
	jbe paramo				; Nem, akkor ez j¢
helpre:
	mov dx,offset helpsz			; Sz”vegc¡m
	mov ah,9				; String ki¡rat s k¢dja
	int 21h					; DOS h¡v s ki¡rat sra
	jmp kilep				; Befejezem
paramo:
	and ax,0000000000001111b		; AX <- darabsz m
	mov bp,ax				; µtm soltam
	mov ax,13h				; MCGA grafikus m¢d k¢dja
	int 10h					; Video BIOS h¡v s a be ll¡t shoz
	mov ax,0a000h				; Az MCGA szegmens ‚rt‚ke
	mov es,ax				; ES <- MCGA szegmens
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; El‹sz”r kit”lt”m a vonal pontjait.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,320 * 100			; A fele k‚perny‹ poz¡ci¢ja
tobbvo:
	mov al,1				; Sz¡nsz m
kulcik:
	mov cx,5				; Mert 5 x 64 = 320
	rep stosb				; Kiteszem a sz¡nt
	inc al					; A k”vetkez‹ sz¡n
	cmp al,65				; El‚rte a v‚g‚t?
	jnz kulcik				; Nem, m‚g tart a vonal
	dec bp					; A vonalsz m cs”kkent‚s
	jnz tobbvo				; M‚g van mit kitenni
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most kialak¡tom a sz¡neket.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,3c8h				; A sz¡nsz m I/O regiszter c¡me
	mov bx,63				; BL <- 63 (piros), BH <- 0 (k‚k)
	mov cl,1				; Sz¡nsz m kezdet
;
; Indul a sz¡nek kialak¡t sa
;
koszik:
	mov al,cl				; A sz¡n sz ma
	out dx,al				; Elkldtem a sz¡n sz m t
	inc dx					; A sz¡n”sszetev‹k regiszter‚nek c¡m‚re
;
; A sz¡n kialak¡t sa
;
	mov al,bl				; A piros sz¡nintenzit s ‚rt‚ke
	out dx,al				; Piros (R) ”sszetev‹ elkldve
	mov al,0				; A z”ld sz¡nintenzit s ‚rt‚ke
	out dx,al				; Z”ld (G) ”sszetev‹ elkldve
	mov al,bh				; A k‚k sz¡nintenzit s ‚rt‚ke
	out dx,al				; K‚k (B) ”sszetev‹ elkldve
	dec dx					; Vissza a sz¡nsz m regiszterre
	dec bl					; Kev‚sb‚ piros
	inc bh					; Egy kicsit k‚kebb
	inc cl					; A k”vetkez‹ sz¡nre
	cmp cl,65				; A sz¡nsz m m‚g tart?
	jnz koszik				; Igen, m‚g teszegetemm ki	
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
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

helpsz	db 'Haszn lata: 68 sz‚less‚g. (Sz‚less‚g 1..9 lehet!)', 13, 10, '$'

code	ends
	end	start

