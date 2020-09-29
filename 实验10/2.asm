assume cs:code

code segment
start:      mov ax,4240h
            mov dx,000fh
            mov cx,0ah
            call divdw

            mov ax,4c00h
            int 21h

divdw:      mov bx,ax
            mov ax,dx
            mov dx,0
            div cx   ;ax=商  dx余数

            push ax ;压栈商=int(H/N) 

            mov ax,bx
            div cx  ;[rem(H/N) * 65536 + L]/N 

            mov cx,dx
            pop dx ;出栈结果高16位

            ret

code ends

end start