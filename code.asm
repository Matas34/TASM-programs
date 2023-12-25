.MODEL small

.STACK 100h

.DATA
	message db 'Iveskite simboli: $'
	tarpas db ' $'

.CODE
start:
	mov ax, @data
	mov ds, ax
	
	mov ah, 9
	mov dx, offset message
	int 21h
	
input:
	mov ah, 01h
	int 21h

	mov ah, 0
	
	mov ah, 9
	mov dx, offset tarpas
	int 21h
	
	mov ah, 0
	mov dl, 0
	
input_end:
	mov cx, 16
	mov bx, 0 ;bl - kiek sk. ideta i stacka, bh - kiek sk. isvesta
	
conversion:
	div cx ;AX - sveikoji dalis ir DX - liekana
	push dx
	mov dx, 0
	inc bl
	cmp al, 0
	jne conversion
	
output_start:
	pop ax
	cmp al, 9
	jg output_hex
	
output_dec:
	add al, 48

	mov ah, 2
	mov dl, al
	int 21h

	inc bh
	cmp bh, bl
	jne output_start
	jmp output_end
	
output_hex:
	add al, 55

	mov ah, 2
	mov dl, al
	int 21h

	inc bh
	cmp bh, bl
	jne output_start
	
output_end:
	mov ax, 4C00h
	int 21h

end start
