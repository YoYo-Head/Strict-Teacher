bits 64

global main
extern printf, scanf, rand
; for rand, number stored in EAX

section .text
    ; So basically, I want to do 5 different addition questions.
    ; If its wrong, it prints msg 3
    ; If its right, it prints msg 4
    ; At the start, it prints msg 1
    ; At the end, it prints msg 5
    ; store values at register edx if needing to print

    main:
        

        ; body code

        sub rsp, 40

        xor eax, eax ; clears eax register to 0 
        lea rcx, [rel msg1] ; rcx is index register
        call printf

        ; question section

        call rand
        mov r9d, eax ; stores 1st random numb to r9d

        call rand

        mov edx, eax ; stores 2nd random numb to edx, which will then also setup for printing
        mov r8d, r9d ; sets up the 1st random numb as 2nd %d
        lea rcx, [rel msg2]
        call printf

        ; answer and checking

        mov eax, 0
        lea rcx, [rel format] ; loads format string
        lea rdx, [rel numb] ; sets input
        call scanf

        add r8d, edx

        

        ; break point

        add rsp, 40

        ret 

        
section .data
    msg1: db "Boy, you better get these questions right >:(", 10, 0
    msg2: db "What is %d plus %d?: ", 10, 0
    msg3: db "nahhhhh!!!", 10, 0
    msg4: db "hmm, too easy.", 10, 0
    msg5: db "Come back tmr, or else...", 10, 0

    format: db "%d", 0

section .bss
    numb resb 4

