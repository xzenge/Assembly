assume cs:code

code segment

    mov ax,0020H
    mov ds,ax
    mov bl,0
    mov cx,63
s:  mov [bl],bl
    inc bl
    loop s

    mov ax,4c00H
    int 21H

code ends

end