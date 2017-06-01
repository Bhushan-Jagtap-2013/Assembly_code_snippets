      convert proc near
        cmp al,'9'
        jbe l1
        cmp al,'a'
        jb l2
        sub al,57h
        jmp l3
        l1 : sub al,30h
           jmp l3
        l2 : sub al,37h
        l3 : ret
      endp    
