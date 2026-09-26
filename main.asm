bits 64

global main
extern printf, scanf, rand, srand, time
; for rand, number stored in EAX
; for time, in RAX


section .text
    ; So basically, I want to do an addition question.
    ; If its wrong, it prints msg 3
    ; If its right, it prints msg 4
    ; At the start, it prints msg 1
    ; At the end, it prints msg 5
; Farhan babar the goat
    main:

        sub rsp, 40

        xor eax, eax ; clears eax register to 0 
        lea rcx, [rel msg1] ; rcx is index register
        call printf

        ; question section
        ; prepares randomisation of seed
        xor ecx, ecx
        call time
        mov ecx, eax
        call srand ; sets seed as time

        mov ebx, [rel maxQuestions]
        mov [rel rightAnswers], 0


        loop:

            ; 1st random
            call rand
            xor edx, edx ; clears up up half of register
            mov ecx, 100 ; divisor of 100
            div ecx 
            mov [rel rNum1], edx ; stores 1st random numb to memory

            ; 2nd random
            call rand
            xor edx, edx ; clears up up half of register
            mov ecx, 100 ; divisor of 100
            div ecx 
            mov [rel rNum2], edx ; stores 1st random numb to memory

            ; printing question

            lea rcx, [rel msg2]
            mov edx, [rel rNum1] ; 1st argument
            mov r8d, [rel rNum2] ; 2nd argument
            call printf ; prints the question out

            ; scanning for question

            lea rcx, [rel format] ; loads format string
            lea rdx, [rel numb] ; sets input
            call scanf

            ; getting actual answer and comparing to user answer
            mov eax, [rel rNum1] ; puts number 1 in eax register
            add eax, [rel rNum2] ; adds up number 1 and number 2 to put real answer in register eax
            xor eax, [rel numb] ; if answer is right, eax fould have all digits as 0. else, it should have 1s aswell

            cmp eax, 0 ; if r8d is 0
            je is_correct

            lea rcx, [rel msg3] ; sets to msg3 if it isn't right
            call printf

            jmp done

            is_correct:
                lea rcx, [rel msg4] ; sets print to msg 4
                inc [rel rightAnswers]
                call printf

            done:

            dec ebx

            cmp ebx, 0
            jne loop


        ; computes final score
        lea rcx, [rel msg5]
        mov edx, [rel rightAnswers]
        mov r8d, [rel maxQuestions]
        call printf

        lea rcx, [rel msg6] ; final msg before closing program
        call printf

        add rsp, 40

        ret 

        
section .data
    msg1: db "Boy, you better get these questions right >:(", 10, 0
    msg2: db "What is %d plus %d?: ", 10, 0
    msg3: db "nahhhhh!!!", 10, 0
    msg4: db "hmm, too easy.", 10, 0
    msg5: db "You got %d/%d", 10, 0
    msg6: db "Come back tmr, or else...", 10, 0

    maxQuestions: dd 5

    format: db "%d", 0

section .bss
    rNum1: resd 1
    rNum2: resd 1
    numb: resd 1
    rightAnswers: resd 1

