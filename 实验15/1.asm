assume cs:code
stack segment
    db 128 dup (0)
stack ends

code segment
start:  mov ax,stack
        mov ss,ax
        mov sp,128

        push cs
        pop ds

        mov ax,0
        mov es,ax
        ;安装int9
        mov si,offset int9
        mov di,204h
        mov cx,offset int9end-offset int9
        cld
        rep movsb
        ;保存中断前CS:IP至200-202
        push es:[9*4]
        pop es:[200h]
        push es:[9*4+2]
        pop es:[202h]
        ;设置新的int9入口方法至中断向量表
        cli
        mov word ptr es:[9*4],204h
        mov word ptr es:[9*4+2],0
        sti

        mov ax,4c00h
        int 21h

int9:   push ax
        push es
        push bx
        push cx

        in al,60h ;读取键盘端口60h中的数据至al中

        pushf
        call dword ptr cs:[200h];首先执行原int9中断例程

        cmp al,1eh+80h;A的断码
        jne int9ret

        mov ax,0b800h
        mov es,ax
        mov bx,0
        mov cx,2000

        mov ah,0cah
s:      mov al,41h
        mov es:[bx],ax
        add bx,2
        loop s

int9ret:    pop cx    
            pop bx
            pop es
            pop ax
            iret
int9end:    nop

code ends
end start