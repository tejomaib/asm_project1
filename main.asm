    AREA Lab4, CODE, READONLY
    EXPORT __main

__main PROC
    ; Enable GPIOC clock
    LDR R0, =0x40023830  
    MOV R1, #0x00000004   
    STR R1, [R0]

    ; Configure GPIOC
    LDR R0, =0x40020800  

    ; Configure PC0 as input with pull-up resistor
    LDR R1, =0x00000000  
    STR R1, [R0, #0x00]  
    LDR R1, =0x00000001 
    STR R1, [R0, #0x0C]  

    ; Configure PC1, PC2, and PC3 as output
    LDR R1, =0x00000054  
    STR R1, [R0, #0x00] 

repeat
    ; Main loop
    LDR R2, [R0, #0x10]  
    AND R2, R2, #0x0001  

    ; Check input state of PC0
    CMP R2, #0x00
    BEQ LED1         
    B LED2           

LED1
    ; Turn on LED1 (PC1) and turn off LED2 (PC2) and LED3 (PC3)
    LDR R1, =0x00000002  
    STR R1, [R0, #0x14]  
    B repeat

LED2
    ; Turn on LED2 (PC2) and turn off LED1 (PC1) and LED3 (PC3)
    LDR R1, =0x00000004 
    STR R1, [R0, #0x14]  
    B repeat

LED3
    ; Turn on LED3 (PC3) and turn off LED1 (PC1) and LED2 (PC2)
    LDR R1, =0x00000008 
    STR R1, [R0, #0x14]  
    B repeat

    ENDP
    END
