assume cs:code
code segment
start:  mov ax,cs
        mov ds,ax
        mov si,offset loop_c
        mov ax,0
        mov es,ax
        mov di,200h
        mov cx,offset loop_c_end-offset loop_c
        cld
        rep movsb ;将0号中断程序复制到0:200处，程序大小为offset do0end-offset do0

        mov ax,0
        mov es,ax
        mov word ptr es:[7ch*4],200
        mov word ptr es:[7ch*4+2],0 ;将0号中断程序的指令起始地址设置到中断向量表中的0号位置，前4位IP，后4位CS

        mov ax,4c00h
        int 21h

loop_c  :   push bp
            mov bp,sp
            jcxz loop_ok
            dec cx
            add ss:[bp+2],bx
loop_ok:    pop bp
            iret


loop_c_end:     nop

        mov ax,4c00h
        int 21h

code ends

end start