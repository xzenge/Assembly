assume cs:code

code segment

start:      mov ax,0ffffh
            mov bl,1
            div bl

            mov ax,4c00h
            int 21h

code ends

end start