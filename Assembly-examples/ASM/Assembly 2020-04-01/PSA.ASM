code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Most nem kell k‚perny‹t”rl‚s. :-)		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start:
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Be ll¡tom a c¡met, ‚s vizsg lom a		;
; darabsz mot.					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov dx,offset helpsz			; A sz”veg c¡me
	mov ah,9				; A string ki¡rat s k¢dja
	mov si,80h				; Ez a darabsz m c¡me
	lodsb					; AL <- parancsssor hossza (si <- si + 1!!)
	cmp al,4				; A hossza ‚ppen 4?
	jnz  helpki				; Nem, akkor a helsp sz”veg megy kil‚p‚s
	inc si					; µtl‚pem a hat rol¢t
	lodsb					; Els‹ parancs karakter beolvas s (si <- si + 1!!)
	cmp al,'0'				; Enn‚l kisebb?
	jb helpki				; Igen, nem sz mjegy volt
	cmp al,'9'				; Enn‚l nagyobb?
	ja helpki				; Igen, nem sz mjegy volt
	mov bl,al				; K‚s‹bbre elteszem (karakter! nem sz m!!!)
	lodsb					; Elvben a '+' karakter beolvas sa (si <- si + 1!!)
	cmp al,'+'				; T‚nleg az?
	jnz helpki				; Nem, akkor megy a help
	lodsb					; M sodik parancs karakter beolvas s (si <- si + 1!!)
	cmp al,'0'				; Enn‚l kisebb?
	jb helpki				; Igen, nem sz mjegy volt
	cmp al,'9'				; Enn‚l nagyobb?
	ja helpki				; Igen, nem sz mjegy volt
	mov bh,al				; K‚s‹bbre elteszem (karakter! nem sz m!!!)
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; J¢ a parancssor, elind¡tom a ki¡rogat st.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov ah,2				; Egy karakter ki¡rat s k¢dja
	mov dl,bl				; Az els‹ karakter
	int 21h					; DOS h¡v sa ki¡rat sra
	mov dl,'+'				; A mûveleti jel karakter
	int 21h					; DOS h¡v sa ki¡rat sra
	mov dl,bh				; A m sodik karakter
	int 21h					; DOS h¡v sa ki¡rat sra
	mov dl,'='				; Az egyenl‹s‚g jel karakter
	int 21h					; DOS h¡v sa ki¡rat sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Az ”sszead sn l figyelni kell r , hogy	;
; nem sz mok vannak BL ‚s BH-ban, hanem		;
; karakterek!					;
; Elvben mindk‚t ‚rt‚ket meg kell fosztani az	;
; az ASCII jellegt‹l (csak az al¢ n‚gy bit	;
; maradjon meg) ”sszeadni, majd £jra karkterr‚	;
; alak¡tani.
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	and bx,0000111100001111b		; Ögy csak a k‚t sz m maradjon
	add bl,bh				; Ez az ”sszegk
	mov dl,bl				; µtteszem, de m‚g nem karakter
	or dl,'0'				; karakterr‚ alak¡tom
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Lehetne azt is tenni, hogy			;
;	and bl,00001111b ; Csak a BL lesz sz m	;
;	add bl,bh        ; BL-ben az ”sszeg	;
;                        ; de m r karakter	;
;	mov dl,bl        ; A ki¡r s hely‚re	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
helpki:
	int 21h					; DOS h¡v sa ki¡rat sra
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

helpsz	db	'Hazn lata: PSA A+B, ahol A ‚s B egy sz mjegy. Egytt legfeljebb 9 lehet!!$'
	db	5000 dup (0)
code	ends
	end	start

