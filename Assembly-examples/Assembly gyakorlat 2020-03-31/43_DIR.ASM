code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov ax,1				; Eg‚rkorzor bekapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	mov bp,0ffffh				; Ilyen gomb llapot biztosan nincs
	mov ax,0b800h				; A k‚perny‹-mem¢ria szegmensc¡me
	mov es,ax				; Ez lesz a k‚perny‹ mem‹ria szegmesregisztere
ciklus:
	mov ax,3				; Eg‚r llapot lek‚rdez‚s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	or cx,dx				; Az X ‚s Y koordin ta egybe mos sa
	and cx,1111111111111000b		; Csak a 8-al oszthat¢ ‚rt‚kek bitjei maradjanak
	jz kilep				; A "HOME" poz¡ci¢ba kerlt az eg‚rkurzor, kil‚pek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; Az el‹z‹  llapottal ”sszehasonl¡tom az	;
; eg‚rgombok  llapot t, ‚s csak elt‚r‚s		;
; eset‚n ¡rok ki.				;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp bx,bp				; Eg‚rgombok  llapota v ltozott?
	jz ciklus				; Nem, olyan mint eddig, nincs a ki¡r sban v ltoz s
	mov bp,bx				; Az £j  llapot  tm sol sa
	mov si,offset egysem			; Felt‚telezem, hogy a egyik sincs lenyomva
	or bl,bl				; Nulla a k‚t gomb bitje?
	jz kiir					; Igen, a DX szerint ki¡rok
	mov si,offset balgom			; A bal gom a felt‚telez‚s
	dec bl					; Ha a bal gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint ki¡rok
	mov si,offset jobgom			; A jobb gomb a felt‚telez‚s
	dec bl					; Ha a jobb gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint ki¡rok
	mov si,offset mindke			; Most m r csak mindkett‹ lehet
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A ki¡r sn l direkt k‚perny‹-mem¢ria kezel‚s.	;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiir:
	mov ax,2				; Eg‚rkorzor kikapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	xor di,di				; A bal fels‹ sarok mem¢riac¡m offszet r‚sze
	mov cx,9				; A string hossza
kipast:
	movsb					; Egy karakter  tpakol sa
	inc di					; A sz¡ninform ci¢  tl‚p‚se
	loop kipast				; Kiteszegetem
	mov ax,1				; Eg‚rkorzor bekapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	jmp ciklus				; éjra lek‚rdezem az eg‚r poz¡ci¢j t
kilep:
	mov ax,2				; Eg‚rkorzor kikapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre


egysem db 'Egyik sem'
balgom db 'Bal gomb '
jobgom db 'Jobb gomb'
mindke db 'Mindkett‹'


code	ends
	end	start

