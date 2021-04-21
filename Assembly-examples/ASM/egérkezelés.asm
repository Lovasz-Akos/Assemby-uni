code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; Képernyőtörléshez módbeállítás kódja
	int 10h					; Video BIOS hívás a törléshez
	mov ax,1				; Egérkorzor bekapcsolás kódja
	int 33h					; Egérdriver hívása
	mov bp,0ffffh				; Ilyen gombállapot biztosan nincs
	mov ax,0b800h				; A képernyő-memória szegmenscíme
	mov es,ax				; Ez lesz a képernyő memőria szegmesregisztere
ciklus:
	mov ax,3				; Egérállapot lekérdezés kódja
	int 33h					; Egérdriver hívása
	or cx,dx				; Az X és Y koordináta egybe mosása
	and cx,1111111111111000b		; Csak a 8-al osztható értékek bitjei maradjanak
	jz kilep				; A "HOME" pozícióba került az egérkurzor, kilépek
;
;
	cmp bx,bp				; Egérgombok állapota változott?
	jz ciklus				; Nem, olyan mint eddig, nincs a kiírásban változás
	mov bp,bx				; Az új állapot átmásolása
	mov si,offset egysem			; Feltételezem, hogy a egyik sincs lenyomva
	or bl,bl				; Nulla a két gomb bitje?
	jz kiir					; Igen, a DX szerint kiírok
	mov si,offset balgom			; A bal gom a feltételezés
	dec bl					; Ha a bal gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint kiírok
	mov si,offset jobgom			; A jobb gomb a feltételezés
	dec bl					; Ha a jobb gomb, nulla lesz BL
	jz kiir					; Igen, nulla lett, a DX szerint kiírok
	mov si,offset mindke			; Most már csak mindkettő lehet

kiir:
	mov ax,2				; Egérkorzor kikapcsolás kódja
	int 33h					; Egérdriver hívása
	xor di,di				; A bal felső sarok memóriacím offszet része
	mov cx,9				; A string hossza
kipast:
	movsb					; Egy karakter átpakolása
	inc di					; A színinformáció átlépése
	loop kipast				; Kiteszegetem
	mov ax,1				; Egérkorzor bekapcsolás kódja
	int 33h					; Egérdriver hívása
	jmp ciklus				; Újra lekérdezem az egér pozícióját
kilep:
	mov ax,2				; Egérkorzor kikapcsolás kódja
	int 33h					; Egérdriver hívása
	mov ah,4ch				; A kilépés kódja
	int 21h					; A DOS hívása kilépésre


egysem db 'Egyik sem'
balgom db 'Bal gomb '
jobgom db 'Jobb gomb'
mindke db 'Mindkettő'


code	ends
	end	start

