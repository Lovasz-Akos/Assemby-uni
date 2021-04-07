code	segment para	public	'code'

assume cs:code, ds:code, es:nothing, ss:nothing

        org     100h

buflen  EQU     78                      ; A puffer hosza

start:
        mov     si,80h                  ; A darabsz m c¡me
        lodsb                           ; Darabsz m beolvas s (SI egyel n‹tt)
        cmp     al,4                    ; Ennyi van?
        jb      helpsz                  ; Nincs, helpet ¡ratok ki
        mov     ah,0                    ; AX <- darabsz m
        mov     bx,ax                   ; µtm solom
        inc     si                      ; µtl‚pem a hat rol¢t

        mov     cx,bx                   ; Ennyi karakterb‹l  ll
ciklus:
        lodsb                           ; Beolvasom a karaktert
        cmp     al,' '                  ; ppen a sz¢k”z?
        jz      rendbe                  ; Igen, ez a hat rol¢
        loop    ciklus                  ; Vissza a k”vetkez‹ let‚sv r sra
        jmp     helpsz                  ; Ha nincs benne sz¢k”z, akkor a help
rendbe:
        lodsb                           ; Ez fogom keresni
        cmp     al,13                   ; V‚ge a parancssornak?
        jz      helpsz                  ; Igen, help menjen ki
        mov     dh,al                   ; A keresend‹r‹l m solat
        lodsb                           ; Ez fogom keresni
        cmp     al,13                   ; V‚ge a parancssornak?
        jnz     helpsz                  ; Nem, help menjen ki
        mov     si,82h                  ; A t rol¢ c¡me
        mov     dl,'0'                  ; Kezd‹‚rt‚k
kiirat:
        lodsb                           ; Ez volt az
        cmp     al,dh                   ; V‚ge a parancssornak?
        jnz     masvol                  ; Nem az volt
        inc     dl                      ; Egyel t”bbet sz molok
masvol:
        cmp     byte ptr [si],' '       ; ppen az sz¢k”z?
        jnz     kiirat                  ; Vissza a k”vetkez‹ keres‚sre

        mov     bx,offset taldrb        ; Ide j”n a darabsz m
        mov     [bx],dl                 ; darabsz m kit‚tel
        mov     dx,offset befejd        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡r s k¢dja
        int     21h                     ; DOS h¡v s ki¡rat sra
kilep:
        mov     ah,4ch               
        int     21h
helpsz:
        mov     dx,offset hibasz        ; Sz”vegc¡m
        mov     ah,9                    ; Stringki¡r s k¢dja
        int     21h                     ; DOS h¡v s ki¡rat sra
        jmp     kilep                   ; Itt be is fejezem

hibasz  db      'Haszn lata: keres4 string X, ahol X a keresend‹ karakter',13,10,'$'

befejd  db      13,10,'A tal latok sz ma '
taldrb  db      ?, ' darab.',13,10,'$'

code	ends
	end	start

