assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset show_str
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset show_str_end-offset show_str
        cld
        rep movsb ;将0号中断程序复制到0:200处，程序大小为offset do0end-offset do0

        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200
        mov word ptr es:[7ch*4+2],0 ;将0号中断程序的指令起始地址设置到中断向量表中的0号位置，前4位IP，后4位CS

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
            iret


show_str_end:     nop

code ends

end start