[bits 16]   ; 16-bit mode for the BIOS
[org 0x7c00]    ; Bootloader will be loaded at 0x7C00 by the BIOS

start:
    mov si, message ; Load the address of the string into the SI register

print_loop:
    call print_message
    call newline
    call delay
    jmp print_loop

print_message:
    lodsb           ; Load next byte from [SI] into AL, increment SI
    cmp al, 0       ; Check if we've reached the end of the string (null terminator)
    je done_printing         ; If AL == 0, restart
    mov ah, 0x0E    ; Teletype output function
    int 0x10        ; BIOS Interrupt
    jmp print_message  ; Repeat the loop

done_printing:
    ret

newline:
    mov ah, 0x0E
    mov al, 0x0D
    int 0x10
    mov al, 0x0A
    int 0x10
    ret

delay:
    mov cx, 0xFFFF
outer_delay:
    mov dx, 0xFFFF
innter_delay:
    dec dx
    jnz innter_delay    ; if DX != 0, load
    dec cx              
    jnz outer_delay
    ret

message db 'Hiiii Pooookieee!!! Love youuuu!!', 0 ; String to print_loop



times 510 - ($ -  $$) db 0  ; Pad 512 bytes
dw 0xAA55               ; Boot signature