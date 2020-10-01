assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset do0
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset do0end-offset do0
        cld
        rep movsb ;将0号中断程序复制到0:200处，程序大小为offset do0end-offset do0

        mov ax,0
        mov es,ax
        mov word ptr es:[0],200
        mov word ptr es:[2],0 ;将0号中断程序的指令起始地址设置到中断向量表中的0号位置，前4位IP，后4位CS

        mov ax,4c00h
        int 21h

do0:    jmp short do0start ;0号中断程序起始指令直接跳转至真正的处理逻辑处
        db 'divide error!' ;将0号中断程序需要展示的错误信息作为0号处理程序占用内存的一部分定义在程序内

do0start:   mov ax,cs
            mov ds,ax
            mov si,202h

            mov ax,0b800h
            mov es,ax
            mov di,12*160+36*2

            mov cx,13
s:          mov al,[si]  ;将字符串复制到显示区域
            mov es:[di],al
            inc si
            add di,2
            loop s

            mov ax,4c00h
            int 21h

do0end:     nop

code ends

end start