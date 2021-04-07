code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h

start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
	mov dx,offset tajeko	; A ki¡ratand¢ sz”veg c¡me
	mov ah,9				; A string ki¡rat s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
ciklus:
	mov ah,8				; N‚ma beolvas s k¢dja
	int 21h					; A DOS h¡v sa beolvas sra
	cmp al,1bh				; ppen ESC volt a let‚s?
	jz kilep				; Igen, akkor kil‚pek
	cmp al,' '				; A sz¢k”z volt ‚ppen?
	jz nemiro				; Igen, akkor nem ¡rok ki j”n
	mov dl,al				; Ez a ki¡ratand¢ karakter
	mov ah,2				; Egy karakter ki¡rat s k¢dja
	int 21h					; A DOS h¡v sa ki¡r sra
	jmp ciklus				; Vissza a let‚sv r sra
nemiro:
	mov ah,8				; N‚ma beolvas s k¢dja
	int 21h					; A DOS h¡v sa beolvas sra
	cmp al,' '				; A sz¢k”z volt ‚ppen?
	jz ciklus				; Igen, akkor a ki¡r s j”n
	cmp al,1bh				; ppen ESC volt a let‚s?
	jnz nemiro				; Nem, akkor v rok sz¢k”zt
kilep:
	mov	ah,4ch				; A kil‚p‚s k¢dja
	int	21h					; A DOS h¡v sa kil‚p‚sre

tajeko db 'Sz¢k”zre a ki¡r s felfggeszt‚sre kerl! Kil‚p‚s: ESC-re.', 13, 10, '$'


code	ends
	end	start

