code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; Képernyõtörléshez módbeállítás kódja
	int 10h					; Video BIOS hívás a törléshez
	mov ax,1				; Egérkorzor bekapcsolás kódja
	int 33h					; Egérdriver hívása
	mov	si,0ffffh			; Ilyen gombállapot biztosan nincs
ciklus:
	mov ax,3				; Egérállapot lekérdezés kódja
	int 33h					; Egérdriver hívása
	or cx,dx				; Az X és Y koordináta egybe mosása
	and cx,1111111111111000b; Csak a 8-al osztható értékek bitjei maradjanak
	jz kilep				; A "HOME" pozícióba került az egérkurzor, kilépek
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
; Az elõzõ állapottal összehasonlítom az		;
; egérgombok állapotát, és csak eltérés			;
; esetén írok ki.								;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp bx,si				; Egérgombok állapota változott?
	jz ciklus				; Nem, olyan mint eddig, nincs a kiírásban változás
	mov si,bx				; Az új állapot átmásolása
	mov dx,offset egysem	; Feltételezem, hogy a egyik sincs lenyomva
	or bl,bl				; Nulla a két gomb bitje?
	jz kiir					; Igen, a DX szerint kiírok
	mov dx,offset balgom	; A bal gom a feltételezés
	dec bl					; Ha a bal gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint kiírok
	mov dx,offset jobgom	; A jobb gomb a feltételezés
	dec bl					; Ha a jobb gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint kiírok
	mov dx,offset mindke	; Most már csak mindkettõ lehet
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
; A kiírásnál a kurzor rögtön vissza is lép.	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
kiir:
	mov ax,2				; Egérkorzor kikapcsolás kódja
	int 33h					; Egérdriver hívása
	mov ah,9				; A string kiíratás kódja
	int 21h					; A DOS hívása kiírásra
	mov ax,1				; Egérkorzor bekapcsolás kódja
	int 33h					; Egérdriver hívása
	jmp ciklus				; Újra lekérdezem az egér pozícióját
kilep:
	mov ax,2				; Egérkorzor kikapcsolás kódja
	int 33h					; Egérdriver hívása
	mov ah,4ch				; A kilépés kódja
	int 21h					; A DOS hívása kilépésre


egysem db 'Egyik sem', 9 dup (8), '$'
balgom db 'Bal gomb ', 9 dup (8), '$'
jobgom db 'Jobb gomb', 9 dup (8), '$'
mindke db 'Mindkettõ', 9 dup (8), '$'


code	ends
	end	start

