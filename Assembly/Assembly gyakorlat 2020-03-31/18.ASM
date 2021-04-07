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
	mov ax,0b800h				; A k‚perny‹-mem¢ria szegmensc¡me
	mov es,ax				; Ez lesz a k‚perny‹ mem‹ria szegmesregisztere
	mov al,'O'				; Ezt tegye ki (keret elem)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Mivel 80 oszlopos a k‚perny‹, a kezd‹	sor	;
; poz¡ci¢ja kezsor * (80 * 2) Kett‹ b jt egy	;
; karakterhely! Az oszlop pedig kezosz * 2	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov di,(kezsor * (2 * 80)) + (kezosz * 2); DI a kezd‹ poz¡ci¢ra
	call kipaci				; Kiteszem
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A 80 oszlopos a k‚perny‹b‹l m‚g		;
; 80 - kezosz - oszele van h tra. Ezt ‚s a	;
; klezd‹ poz¡ci¢t  tl‚pem.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	add di,((80 - kezosz - oszele + kezosz) * 2); A k”vetkez‹ sor elej‚re
;
; Elind¡tom a k”ztes sorokat ciklusban
;
	mov cx,kermag - 2			; Az els‹ ‚s utols¢ miatt a -2!
kozcik:
	stosb					; AL (azaz 'O' betû) kit‚tele
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A k‚perny‹t”rl‚s miatt s z¢k”z”ket nem kell	;
; kitenni, csak  tl‚pem. (+1 az 'O' betû m sik	;
; b jtja miatt!)				;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	add	di,((oszele - 2) * 2) + 1	; Ide j”n a k”vetkez‹ 'O' betû
	stosb					; AL (azaz 'O' betû) kit‚tele
	add di,((80 - kezosz - oszele + kezosz) * 2) + 1; A k”vetkez‹ sor elej‚re
	loop kozcik				; Kiteszegetem ciklusban a k”ztes sorokat
	call kipaci				; A z r¢ sor kit‚tele
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Ciklusban kiteszem AL-t.			;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kipaci:
	mov cx,oszele				; Ennyi 'O' betû sz‚les legyen
cikbep:
	stosb					; Kiteszem AL ‚rt‚k‚t
	inc di					; µtl‚pem a sz¡ninform ci¢kat
	loop cikbep				; Kiteszem ciklusban
	ret					; K‚sz vagyok

code	ends
	end	start

