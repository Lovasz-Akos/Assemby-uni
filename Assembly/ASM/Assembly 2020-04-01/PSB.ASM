code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Elk‚sz¡tem a parancs sor szerkezet‚t £gy	;
; hogy szimb¢lumokkal lehet r  hivatkozni-	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	org	80h
parcnt	db	?				; A sz ml l¢ helye
parhat	db	?				; A hat rol¢ helye
parkar	db	126 dup (?)			; A parancs karaktereinek helye
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; J”het most m r a val¢di k¢d helye		;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
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
	cmp [parcnt],4				; A hossza ‚ppen 4?
	jnz helpki				; Nem, mehet a help sz”veg
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Be ll¡tom a c¡met, ‚s vizsg lom a		;
; karaktereket.					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov si,offset parkar			; Ez a karakterek c¡me
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
; Az ”sszead sn l figyelni kell r , hogy	;
; nem sz mok vannak BL ‚s BH-ban, hanem		;
; karakterek!					;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov cl,bl				; Az els‹ karakter m solata
	add cl,bh				; A k‚t karakter!!!! ”sszege
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A sz m karakterek 'el‹tagja' 00110000b ami	;
; a '0' karakter (is). ™sszead sn l ¡gy k‚t	;
; 'el‹tag' lett, mit egy kivon ssal korrig lni	;
; lehet! Ut na megn‚zem, hogy j¢-e az eredm‚ny.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	sub cl,'0'				; Hogy karakter maradjon az ”sszeg
	cmp cl,'9'				; Nagyobb az eredm‚ny mint 9?
	ja helpki				; Igen, nem j¢ a parancs, help megy ki
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
	mov dl,cl				; Az ”sszeg
helpki:
	int 21h					; DOS h¡v sa ki¡rat sra
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

helpsz	db	'Hazn lata: PSB A+B, ahol A ‚s B egy sz mjegy. Egytt legfeljebb 9 lehet!!$'
	db	5000 dup (0)
code	ends
	end	start

