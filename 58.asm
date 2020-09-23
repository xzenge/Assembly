assume cs:code

code segment

    mov cx,12
    mov bx,0
s:  mov ax,0ffffH
    mov ds,ax
    mov dl,[bx]
    mov ax,0020H
    mov ds,ax
    mov [bx],dl
    inc bx
    loop s

    mov ax,4x00H
    int 21H
code ends

end