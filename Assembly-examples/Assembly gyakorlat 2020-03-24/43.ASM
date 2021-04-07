code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov ax,1				; Eg‚rkorzor bekapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	mov	si,0ffffh			; Ilyen gomb llapot biztosan nincs
ciklus:
	mov ax,3				; Eg‚r llapot lek‚rdez‚s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	or cx,dx				; Az X ‚s Y koordin ta egybe mos sa
	and cx,1111111111111000b; Csak a 8-al oszthat¢ ‚rt‚kek bitjei maradjanak
	jz kilep				; A "HOME" poz¡ci¢ba kerlt az eg‚rkurzor, kil‚pek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
; Az el‹z‹  llapottal ”sszehasonl¡tom az		;
; eg‚rgombok  llapot t, ‚s csak elt‚r‚s			;
; eset‚n ¡rok ki.								;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp bx,si				; Eg‚rgombok  llapota v ltozott?
	jz ciklus				; Nem, olyan mint eddig, nincs a ki¡r sban v ltoz s
	mov si,bx				; Az £j  llapot  tm sol sa
	mov dx,offset egysem	; Felt‚telezem, hogy a egyik sincs lenyomva
	or bl,bl				; Nulla a k‚t gomb bitje?
	jz kiir					; Igen, a DX szerint ki¡rok
	mov dx,offset balgom	; A bal gom a felt‚telez‚s
	dec bl					; Ha a bal gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint ki¡rok
	mov dx,offset jobgom	; A jobb gomb a felt‚telez‚s
	dec bl					; Ha a jobb gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint ki¡rok
	mov dx,offset mindke	; Most m r csak mindkett‹ lehet
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
; A ki¡r sn l a kurzor r”gt”n vissza is l‚p.	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiir:
	mov ax,2				; Eg‚rkorzor kikapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	mov ah,9				; A string ki¡rat s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
	mov ax,1				; Eg‚rkorzor bekapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	jmp ciklus				; éjra lek‚rdezem az eg‚r poz¡ci¢j t
kilep:
	mov ax,2				; Eg‚rkorzor kikapcsol s k¢dja
	int 33h					; Eg‚rdriver h¡v sa
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre


egysem db 'Egyik sem', 9 dup (8), '$'
balgom db 'Bal gomb ', 9 dup (8), '$'
jobgom db 'Jobb gomb', 9 dup (8), '$'
mindke db 'Mindkett‹', 9 dup (8), '$'


code	ends
	end	start

