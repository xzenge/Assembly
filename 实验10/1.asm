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
            push si

            mov ah,0 ;开始计算row
            mov al,dl
            push cx;cx压栈，后续需要借用cx寄存器做mul
            mov cx,2
            push dx ;dx压栈，防止mul结果覆盖dx
            mul cx    ;ax=dl * 2

            mov bx,ax ;开始计算col
            mov ah,0
            pop dx ;重新取dx
            mov al,dh
            mov cx,0a0h
            mul cx ;ax = dh * a0
            add bx,ax ;bx最终存放显示偏移量

            pop cx ;重新取会cl中的值
            mov dl,cl ; 颜色
            mov ax,0b800h
            mov es,ax
            mov di,bx

cap:        mov cl,[si]
            mov ch,0
            jcxz ok
            mov al,[si]
            mov ah,dl
            mov es:[di],ax
            inc si
            add di,2
            jmp short cap 

ok:         pop si
            pop dx
            pop cx
            pop bx
            pop ax
            ret

code ends
end start