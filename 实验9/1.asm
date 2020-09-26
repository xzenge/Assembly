assume cs:codesg

data segment
    db 'welocome to masm!'
data ends

color segment
    db 01110001b,00100100b,00000010b
color ends

stack segment
    dw 0,0,0,0,0,0,0,0
stack ends

codesg segment

start:  mov ax,0b878h
        mov ds,ax

        mov di,0
        mov cx,3
        mov si,0
        
s:      push cx

        mov bx,color
        mov es,bx
        mov ah,es:[di]
        mov bx,data
        mov es,bx
        mov bx,0
        mov cx,17

s0:     mov al,es:[bx]
        mov [si],ax
        add si,2
        inc bx
        loop s0

        inc di
        pop cx
        add si,7eh
        loop s

        mov ax,4c00h
        int 21h
codesg ends

end start