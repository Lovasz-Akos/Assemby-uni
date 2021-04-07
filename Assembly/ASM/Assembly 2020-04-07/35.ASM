code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing


;
	org	100h
;
start:
	mov ax,3				; K‚perny‹t”rl‚shez m¢dbe ll¡t s k¢dja
	int 10h					; Video BIOS h¡v s a t”rl‚shez
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A karaktereket bitenk‚nt jelzem.		;
; Ez az alap‚rt‚k.				;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	mov bl,0				; M‚g egyik sincs meg
ciklus:
	mov ah,1				; Visszhangos beolvas s k¢dja
	int 21h					; A DOS h¡v sa bolvas sra
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;						;
; A bit be ll¡t s ut n nem szks‚ges a		;
; vizsg latra ugrani, mert tov bb haladva	;
; is oda fog jutni.				;
;						;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
	cmp al,'a'				; ppen az 'a' betû?
	jnz nemaza				; Nem, akkor tov bb vizsg lom
	or bl,00000001b				; Az 'a' betû bitj‚t be ll¡tom
nemaza:
	cmp al,'b'				; ppen a 'B' betû?
	jnz nemabe				; Nem, akkor tov bb vizsg lom
	or bl,00000010b				; A 'b' betû bitj‚t be ll¡tom
nemabe:
	cmp al,'c'				; ppen a 'B' betû?
	jnz nemace				; Nem, akkor tov bb vizsg lom
	or bl,00000100b				; A 'c' betû bitj‚t be ll¡tom
nemace:
	cmp bl,00000111b			; Megvan m r mindegyik?
	jnz ciklus				; M‚g nincs meg, tov bb olvasokl
kilep:
	mov ah,4ch				; A kil‚p‚s k¢dja
	int 21h					; A DOS h¡v sa kil‚p‚sre

amitki	db	'Assembly'
txtlen	EQU	$ - amitki			; Meghat rozom a sz”veg hossz t
	db	13, 10, '$'			; A v‚g‚re CR ‚s LF j”n
code	ends
	end	start

