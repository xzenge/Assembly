assume cs:code

data segment
    db 'Welcome to masm!',0
data ends
code segment
start:  mov dh,8
        mov dl,3
        mov cl,2
        mov ax,data
        mov ds,ax
        mov si,0
        call show_str

        mov ax,4c00h
        int 21h

show_str:   push ax
            push bx
            push cx
            push dx


            mov bx,0
            mov al,cl
            mov cx,0
            mov cl,dl
row:        add bx,2
            loop row

            mov cl,dh
col:        add bx,0a0h
            loop col

            mov dl,al ; 颜色
            mov ax,0b800h
            mov es,ax
            mov di,bx

cap:        mov cl,[si]
            mov ch,0
            jcxz ok
            mov al,[si]
            mov ah,dl
            ;mov ah,01110001b
            mov es:[di],ax
            inc si
            add di,2
            jmp short cap 

ok:         pop dx
            pop cx
            pop bx
            pop ax
            ret

code ends
end start