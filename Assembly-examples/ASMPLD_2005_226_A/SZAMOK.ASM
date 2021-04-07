code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     80h

darabs  db      ?

	org	100h


start:
        mov     si,offset darabs                ; Itt van a darabsz m
        mov     cl,[si]                         ; CL <- darabsz m
        mov     ch,0                            ; CX <- darabsz m
        mov     dx,offset nupaso                ; Nulla sz”vegc¡me
        jcxz    bajnul                          ; Nem j¢ a arancssor
        dec     cx                              ; Kihagyom a hat rol¢t
        jcxz    bajnul                          ; Nem j¢ a arancssor
        add     si,2                            ; Az els‹ parancselemre
        mov     di,10                           ; Szorz¢/oszt¢
        xor     ax,ax                           ; Itt gyûjt”m majd
beolci:
        mov     dx,offset karros                ; Hib s karakter sz”vege
        mov     bl,[si]                         ; Parancsor karaktere
        cmp     bl,'0'                          ; Kissebb mint a nulla?
        jb      bajnul                          ; Igen, kissebb, mehet ki¡rni
        cmp     bl,'9'                          ; Nagyobb mint a kilenc?
        ja      bajnul                          ; Igen, nagyobb, mehet ki¡rni
        and     bx,000fh                        ; Karakterb¢l numerikus ‚rt‚k
        mul     di                              ; AX <- AX * 10
        mov     dx,offset tulnas                ; T£l nagy sz”vege
        jc      bajnul                          ; Igen, t£l nagy
        add     ax,bx                           ; Sz m hoz ad s
        jc      bajnul                          ; Igen, t£l nagy
        inc     si                              ; N”velem a pointert
        loop    beolci                          ; Minden elemet beolvasok
;
; AX-ben a ki¡ratand¢
;
        push    ax                              ; Kell k‚s‹bb is
        call    axdeco                          ; Kiteszem decim lisan
        mov     dx,offset spdars                ; Space c¡me
        mov     ah,9                            ; Ki¡rat s k¢dja
        int     21h                             ; DOS h¡v sa ki¡rat sra
        pop     ax                              ; Visszaveszem
        push    ax                              ; Kell k‚s‹bb is
        call    axdeko                          ; Kiteszem hexadecim lisan
        pop     ax                              ; Visszaveszem
        push    ax                              ; Kell k‚s‹bb is
        or      ax,ax                           ; Parit s flag be ll¡t s
        mov     dx,offset parite                ; EVEN parit s sz”vegc¡me
        jpe     evenma                          ; Most EVEN a parait sa
        mov     dx,offset parito                ; ODD parit s sz”vegc¡me
evenma:
        mov     ah,9                            ; Ki¡rat s k¢dja
        int     21h                             ; DOS h¡v sa ki¡rat sra
        pop     ax                              ; V‚gleges visszav‚tel
        shr     ax,1                            ; CY-be a legals¢ bit
        mov     dx,offset paratl                ; P ratlan sz”veg sz”vegc¡me
        jc      bajnul                          ; Most EVEN a parait sa
        mov     dx,offset paross                ; P ros sz”veg sz”vegc¡me
bajnul:
        mov     ah,9                            ; Ki¡rat s k¢dja
        int     21h                             ; DOS h¡v sa ki¡rat sra
	mov	ah,4ch
	int	21h
;
; AX decim lis ki¡rt sa
;
axdeco:
        xor     cx,cx                           ; Ez a sz ml l¢
divcik:
        xor     dx,dx                           ; A H r‚sz null z sa
        div     di                              ; Elosztottam
        push    dx                              ; Karakter ment‚s
        inc     cx                              ; Sz ml ltam
        or      ax,ax                           ; Nulla lett?
        jnz     divcik                          ; M‚g nem, osztok tov bb
        mov     ah,2                            ; Karakterki¡rat s k¢dja
kakici:
        pop     dx                              ; DL-be ‚rt‚k
        or      dl,'0'                          ; Karakterr‚ alak¡tom
        int     21h                             ; Karakter kivitel
        loop    kakici                          ; Annyit amennyit eltettem
        ret                                     ; K‚sz, visszat‚rek
;
; AX hexadecim lis ki¡rt sa
;
axdeko:
        push    ax                              ; Kell k‚s‹bb
        mov     al,ah                           ; Els‹nek AH-t ¡ratom ki
        call    aldeko                          ; AL k¡rat sa
        pop     ax                              ; Vissza az eredeti
        call    aldeko                          ; AL k¡rat sa
        ret                                     ; AX ki¡r sa k‚sz
;
; AL hexadecim lis ki¡rt s
;
aldeko:
        push    ax                              ; Kell k‚s‹bb
        shr     al,1                            ; Lel‚ptet‚s 1.
        shr     al,1                            ; Lel‚ptet‚s 2.
        shr     al,1                            ; Lel‚ptet‚s 3.
        shr     al,1                            ; Lel‚ptet‚s 4.
        call    nebiki                          ; N‚gy bit kit‚tele
        pop     ax                              ; Vissza az eredeti
        call    nebiki                          ; N‚gy bit kit‚tele
        ret                                     ; AL ki¡r sa k‚sz
;
; AL als¢ n‚gy bitj‚nak hexa ki¡rt sa
;
nebiki:
        and     al,00001111b                    ; Csak az als¢ r‚sz maradjon
        add     al,'0'                          ; Karakterr‚ alak¡tom
        cmp     al,'9'                          ; Enn‚l nagyobb?
        jbe     marsza                          ; Nem, m‚g sz mjegy
        add     al,'A' - ('9' + 1)              ; Korrekci¢ betûre
marsza:
        mov     ah,2                            ; Karakterkit‚tel k¢dja
        mov     dl,al                           ; Ezt kell ki¡ratni
        int     21h                             ; DOS h¡v sa karakterki¡r sra
        ret                                     ; Ki¡r s k‚sz


nupaso  db      'Nincs parancssor megadva!$'
karros  db      'Hib s parancskarakter! (Csak sz mjegyek lehetnek!)$'
tulnas  db      'Legfeljebb 65535 lehet, ez t£l nagy!$'
spdars  db      '   $'
parite  db      '    P ros parit s   $'
parito  db      '   P ratlan parit s $'
paratl  db      '   P ratlan  $'
paross  db      '   P ros$'



code	ends
	end	start

