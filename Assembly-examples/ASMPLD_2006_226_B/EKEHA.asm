code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

	org	100h


start:
        mov     ax,3                    ; K�perny�m�d be�ll�t�s k�dja
        int     10h                     ; �gy let�rli (alaphelyztbe hozza)
        mov     cx,10                   ; Maximum ennyi le�t�sre v�rok
        mov     dx,offset csaksz        ; Sz�vegc�m
        mov     ah,9                    ; Ki�rat�s k�dja
        int     21h                     ; DOS h�v�sa ki�rat�sra
ujkerd:
        mov     ah,8                    ; Visszhng n�lk�li!!! bek�r�s k�dja
        int     21h                     ; DOS h�v�sa le�t�sv�r�sra
        cmp     al,1bh                  ; A le�t�s ESC volt?
        jz      vegcim                  ; Igen, v�ge a dalnak
        cmp     al,'Q'                  ; A le�t�s 'Q' volt?
        jz      vegcim                  ; Igen, v�ge a dalnak
        cmp     al,'q'                  ; A le�t�s 'q' volt?
        jz      vegcim                  ; Igen, v�ge a dalnak
        mov     ah,9                    ; Ki�rat�s k�dja
        mov     dx,offset egyszo        ; Sz�vegc�m
        cmp     al,'1'                  ; �ppen '1'?
        jz      vakevi                  ; Igen, akkor sz�veget �rok
        mov     dx,offset ketszo        ; Sz�vegc�m
        cmp     al,'2'                  ; �ppen '2'?
        jz      vakevi                  ; Igen, akkor sz�veget �rok
        mov     dx,offset harszo        ; Sz�vegc�m
        cmp     al,'3'                  ; �ppen '2'?
        jz      vakevi                  ; Igen, akkor sz�veget �rok
        mov     dl,al                   ; DL-b�l ki�ratom majd
        mov     ah,2                    ; Egy karakter ki�r�s�nak k�dja
vakevi:
        int     21h                     ; Megh�vom a DOS-t ki�r�sra
        loop    ujkerd                  ; Nem, �j k�rd�s j�n
vegcim:
	mov	ah,4ch
	int	21h

csaksz  db      '�ss�n le bet�ket �s sz�mokat, ESC, Q vagy q v�ge!', 10, 13,'$'
egyszo  db      'egy$'
ketszo  db      'kett�$'
harszo  db      'h�rom$'

code	ends
	end	start

