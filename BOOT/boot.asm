[org 0x7c00]
[BITS 16]

start:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	mov sp, 0x7c00

	mov si, hellomsg
	call _printer

	; for now just a simple test
	; cli
	; hlt
	; jmp $
	
	; lets read sectors one of disk one (floppy) and put it in ram
	; and jmp to there.

	mov ax, 0x0000
	mov es, ax
	mov bx, 0x2000

	mov ah, 0x02
	mov al, 10
	mov ch, 0
	mov cl, 2
	mov dl, 0
	mov dl, 0x00
	int 13h

	jc _error

	jmp 0x0000:0x2000

_printer:
	mov ah, 0x0E

_mrloop:
	lodsb
	test al, al
	jz .done
	int 10h
	jmp _mrloop

.done:
	ret

_error:
	mov si, ftr
	call _printer
	cli
	hlt
	jmp $



	hellomsg db 'FeOS version 0.0.1 Starting FeOS...', 0x0D, 0x0A, 0
	ftr db '[!]: Floppy is on fire!', 0
	times 510 - ($-$$) db 0
	dw 0xAA55
