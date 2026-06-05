[org 0x2000]
[BITS 16]
section .text
_start:
	xor ax, ax
	mov ss, ax
	mov es, ax
	mov ds, ax
	; wtf? in 16bits? mov fs, ax
	mov sp, 0x8000

	mov si, msgone
	call _printer

	call _delay
	; call _clear
	
	; call _bc

	; mov si, title
	; call _prtitle
	; mov si, diing
	; call _npr	
	; mov si, ti
	; call _npr
	; mov si, line
	; call _npr
	; mov si, op1
	; call _npr
	; mov si, op2
	; call _npr
	
	; toolbar
	; mov dh, 24
	; mov dl, 0
	; mov bh, 0
	; mov ah, 0x02
	; int 10h
	
	mov si, tya
	call _npr
	
	call _waitforkey

	cli
	hlt
	jmp $


_npr:
	push si
	push ax
	mov ah, 0x0E
	; mov bl, 0x1F
_pp:
	lodsb
	test al, al
	jz _paa
	int 0x10
	jmp _pp
_paa:
	pop si
	pop ax
	ret

_waitforkey:
	mov ah, 0x00
	int 16h
	cmp al, 'b'
	je _rundemomode
	jmp _waitforkey

_rundemomode:
	call _clear
	mov si, ta
	call _prtitle
	mov si, ka
	call _prtitle

	sti

	call _readskey
	mov si, ax
	mov di, trinfo
	call strcmp
	je _trinforun
	mov di, cla
	call strcmp
	je _whapoff
	mov di, gah
	call strcmp
	je _offsys
	call kassa

coke:
	call _readskey
	mov si, ax
        mov di, trinfo
        call strcmp
        je _trinforun
	mov di, cla
        call strcmp
        je _whapoff
	mov di, gah
        call strcmp
        je _offsys
        call kassa

kassa:
	mov si, ka
	call _prtitle
	call _readskey
	mov si, ax
	mov di, trinfo
	call strcmp
	je _trinforun
	mov di, cla
        call strcmp
        je _whapoff
	mov di, gah
        call strcmp
        je _offsys
	jmp kassa

; commends define here!

_offsys:
	mov ax, 0x5300
	mov bx, 0x0000
	int 15h
	jc .na
	mov ax, 0x5301
	mov bx, 0x0000
	int 15h
	jc .na
	mov ax, 0x5307
	mov bx, 0x0001
	mov cx, 0x0003
	int 15h
	jc .na
	
	cli
	hlt
	jmp $


.na:
	;mov si, ja
	; call _prtitle
	call coke

_trinforun:
	mov si, infot
	call _prtitle
	jmp kassa


_whapoff:
	call _clear
	mov si, ka
	call _prtitle
	call coke
_readskey:
	push bp
	mov bp, sp
	sub sp, 128
	mov di, sp
	xor cx, cx
_laa:
	mov ah, 0x00
	int 16h
	cmp al, 0x0D
	je _fd
	; backspace not for now
	stosb
	inc cx
	mov ah, 0x0E
	int 10h
	jmp _laa
_fd:
	mov al, 0x00
	stosb
	mov ax, sp
	mov sp, bp
	pop bp
	ret


; a simple strcmp

strcmp:
.loop:
	mov al, [si]
	mov bl, [di]
	cmp al, bl
	jne _ne
	test al, al
	jz _rcc
	inc si
	inc di
	jmp .loop

_ne:
	xor ax, ax
	cmp ax, 1
	ret

_rcc:
	xor ax, ax
	cmp ax, ax
	ret


_prtitle:
	push si
	mov ah, 0x0E
	mov bl, 0x70
_la:
	lodsb
	test al, al
	jz _donje
	int 10h
	jmp _la

_donje:
	pop si
	ret

_printer:
	mov ah, 0x0E
	mov bl, 0x1F
_loop:
	lodsb
	test al, al
	jz _done
	int 10h
	jmp _loop

_done:
	ret

_clear:
	mov ax, 0x0003
	int 10h
	ret


_delay:
	mov cx, 0x0000
	mov dx, 0xF4240
	mov ah, 0x86
	int 0x15
	ret

_bc:
	mov ax, 0x0003
	int 0x10
	
	mov ax, 0x0600
	mov bh, 0x1F
	mov cx, 0x0000
	mov dx, 0x184F
	int 10h

	mov dh, 0
	mov dl, 0
	mov bh, 0
	mov ah, 0x02
	int 0x10
	ret


;	mov ax, 0x0003
;	int 10h
;	
;	mov ax, 0x1120
;	int 10h
;	ret
	


section .data
	tya db 'Press B to Boot into LFM-Shell', 0
	;  ja db 'APM NOT SUPPORT AT ALL.', 0x0D, 0x0A, 0
	; bada db '  Press Enter To Continue. | Press A to change disk number.', 0
	; diing db 'FeOS v0.1 SetupWizard', 0x0D, 0x0A,'       Welcome to the FeOS Setup Wizard.', 0x0D, 0x0A, '       To install on your hard disk, follow the instructions below:', 0x0D, 0x0A, '       1. Press Enter to install on hard disk number 1.', 0
	; menub db 'Press: ', 0
	infot db 0x0D, 0x0A, 'LFM -V0.1, FeOS V0.1', 0
	trinfo db 'trinfo', 0
	cla db 'flush', 0
	gah db 'offsystem', 0
	ta db 'DM Enabled. (feos.ct.ws/dm)', 0x0D, 0x0A, 'Booting FeOS...', 0x0D, 0x0A, 0x0D, 0x0A, 0
	ka db 0x0D, 0x0A, '..(lfm-feosbeta)$ ', 0
	ti db 'FeOS V0.1 BOOTMENU', 0x0D, 0x0A, 0
	; line     db 0xC3, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4
             db 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4
             db 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4
             db 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4
             db 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xC4, 0xB4, 0x0D, 0x0A, 0
	; line db '──────────────────────────', 0x0D, 0x0A, 0
	op1 db 0x0D, 0x0A, 0x0D, 0x0A, '     Press B to run in DM.', 0x0D, 0x0A, 0
	op2 db '     Press A to run installer', 0x0D, 0x0A, 0
	; menub db 'Press: ', 0x0D, 0x0A, 0
	msgone db '(C)2026 - FeOS. (feos.ct.ws)', 0x0D, 0x0A, 0
	; title db 0x0D, 0x0A, ' FeOS v0.1 SetupWizard', 0x0D, 0x0A, 0
	; line db ' =======================================', 0x0D, 0x0A, 0
	; menub db '  Press a Button to continue.', 0
	;poa db 'Demo Mode (Running by press B for inforamtion: feos.ct.ws/dm)...', 0x0D, 0x0A, 'Booting FeOS...', 0
	diskfire db 'DISK IS ON FIRE!!!', 0
	logo db 0x0D, 0x0A, 'Welcome to FeOS! v0.1 (feos.ct.ws/v0_1)', 0x0D, 0x0A, 0
        stack db '..(LFM-V0.1)$', 0
	poka db 'Demo Mode (feos.ct.ws/dm)...', 0
