code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

kezosz	EQU	20				; A kezd‹ oszlop ‚rt‚ke
oszele	EQU	40				; Ennyi sz‚les legyen a keret
kezsor	EQU	5				; Ebben a sorban kezdjen
kermag	EQU	8				; Ennyi magas legyen a keret


start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov bx,'99'				; Ez a kezd‹ ‚rt‚k (k‚t karakter BH ‚s BL-be)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; El‹sz”r kiteszem az ‚rt‚ket, majd CRLF.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kikici:
	mov ah,2				; Egy karakter ki¡r s k¢dja
	mov dl,bh				; A ki¡ratand¢ karakter (H r‚sz)
	int 21h					; DOS h¡v sa ki¡rat sra
	mov dl,bl				; A ki¡ratand¢ karakter (L r‚sz)
	int 21h					; DOS h¡v sa ki¡rat sra
	mov dl,13				; A ki¡ratand¢ karakter (CR)
	int 21h					; DOS h¡v sa ki¡rat sra
	mov dl,10				; A ki¡ratand¢ karakter (LF)
	int 21h					; DOS h¡v sa ki¡rat sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Megn‚zem, hogy ha a '01' volt kil‚pek		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp bx,'01'				; El‚rte az 1-et?
	jz kilep				; Igen, akkor kil‚pek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Kisz m¡tom a k”vetkez‹ ‚rt‚ket.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	dec bl					; Egyel legyen kisebb az L r‚sz
	cmp bl,'0'				; A '0' karaktern‚l kisebb lett?
	jae marazl				; Nem, akkor maradhat az L r‚sz
	mov bl,'9'				; L r‚szbe £jra a '9' j”n
	dec bh					; H r‚szt cs”kkentem
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A ki¡r s ut n j”het a let‚s v r s.		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
marazl:
	mov ah,8				; N‚ma beolvas sk‚r‚s k¢dja
	int 21h					; DOS h¡v sa beolvas sra
	cmp al,1bh				; Az ESC volt ‚ppen?
	jnz kikici				; Nem, akkor £j ki¡r s j”n
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

code	ends
	end	start

