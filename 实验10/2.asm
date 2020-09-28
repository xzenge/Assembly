assume cs:code

code segment
start:      mov ax,4240h
            mov dx,000fh
            mov cx,0ah
            call divdw
            mov ax,4c00h
            int 21h
divdw:      push ax
            mov ax,dx
            mov dx,0
            div cx  ;ax=int(H/N)  dx=rem(H/N)
            mov bx,ax ;bx=(H/N)
            pop ax ;ax=L
            push dx
            div cx ; [rem(H/N)*65536+L]/N
            mov cx,dx
            pop bx
            add ax,bx
            ret

code ends

end start