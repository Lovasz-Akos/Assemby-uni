code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

szeles	equ	180			; Ennyi a z szl¢ sz‚less‚ge (pont)
vastag	equ	40			; Ennyi egy sz¡n vastags ga (sor)

kezdos	equ	(200 - (3 * vastag)) / 2; Ebben a sorban kezd
kezosz	equ	(320 - szeles) / 2	; Ebben az oszlopban kezd

start:
;
; K‚perny‹ zemm¢d be ll¡t s
;
	mov	ax,13h			; MCGA zemm¢d k¢dja
	int	10h			; Az  tkapcsol s megt‚tele
;
; String mûveletek ir nya
;
	cld				; String mûveletek el‹refele menjenek
;
; A k‚perny‹mem¢ria felt”lt‚se a z szl¢val
;
	mov	ax,0a000h		; A grafikus terlet szegmense
	mov	es,ax			; ES <- MCGA terlet szegmensc¡me
	mov	di,(kezdos * 320) + kezosz; Itt az els‹ pont helye
;
; AL-ben nulla van ‚ppen!!!, kihaszn lom sz¡nsz mnak
;
megszt:
	mov	bx,vastag		; Ennyi egy sz¡n hossza
	inc	ax			; A k”vetkez‹ sz¡n
szinst:
	mov	cx,szeles		; Egy cs¡k hossza
	rep	stosb			; Kitettem egy sor
	add	di,320 - szeles 	; R t‚rek a k”vetkez‹re
	dec	bx			; Vissza a sz¡nsz‚less‚g sz ml l¢
	jnz	szinst			; Ciklusban a sz¡n
	cmp	al,3			; M r a h rmassal rajzoltam?
	jnz	megszt			; M‚g nem, kiteszem tov bb
;
; A h rom sz¡n kialak¡t sa ‚s v rakoz s
;
	mov	si,1011100100111101b	; A t”m”r¡tett paletta ‚rt‚kek
szinbe:
        mov     cl,3                    ; 3 palettasz¡n lesz
	push	cx			; M¢d k¢d ment‚s
szinde:
	mov	dx,3c8h 		; Palettasz¡n t rol¢ c¡me
        mov     al,cl                   ; Sz¡nsz m m solat
	out	dx,al			; Sz¡nsz m elkld‚s
	inc	dx			; L‚pek a sz¡nt rol¢kra
        mov     bl,3                    ; 3 palettasz¡n lesz
rgbval:
        mov     ax,0840h                ; Ez val¢j ban 0 intenzit s + AH k¢d
	sbb	al,0			; Vagy marad AL, vagy 63 lesz (SI)
	shr	si,1			; K”vetkez‹ elem
	out	dx,al			; ™sszetev‹ elkld‚s
        dec     bx                      ; ™sszetev‹sz m cs”kkent‚s
        jnz     rgbval                  ; RGB, azaz mindh rom sz¡n
        loop    szinde                  ; AH nem nulla, JNZ nem j¢!!!
	int	21h			; DOS h¡v s let‚sv r sra
	pop	ax			; AX <- 3 azaz m¢d k¢d
	jc	szinbe			; SHR ut n ez a CY marad
	int	10h			; Az  tkapcsol s megt‚tele
	int	20h			; Kil‚p‚s

code	ends
	end	start
