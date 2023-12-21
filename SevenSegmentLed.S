; Trent Tucker
; Fall 2020
; Assembly code for seven-segment LED

  .macro pushall
push r16
push r17
push r18
push r19
push r20
push r21
push r22
push r23
push r24
push r25
push r26
push r27
push r28
push r29
push r30
push r31
.endm ; pushall

.macro popall
pop r31
pop r30
pop r29
pop r28
pop r27
pop r26
pop r25
pop r24
pop r23
pop r22
pop r21
pop r20
pop r19
pop r18
pop r17
pop r16
.endm ; popall

.data
.size digit_table, 4
.size portb_table, 10
.size portd_table, 10
  
digit_table:  ; binary for setting input on PORTB for digit select
    .byte 0b00011100, 0b00011010, 0b00010110, 0b00001110
    
    ; 9 10 11 12
portb_table:  ; list of binary numbers for setting PORT B
    .byte 0, 0, 1, 1, 1, 1, 1, 0, 1, 1
    
    ; 0 1 2 3 4 5 6 7 8 9
portd_table: ; list of binary numbers for setting PORT D
    .byte 0b11111100, 0b00011000, 0b01101100, 0b00111100, 0b10011000, 0b10110100, 0b11110000, 0b00011100, 0b11111100, 0b10011100 ; bit pattern determines digit light up

    ; 0 1 2 3 4 5 6 7 8 9

.comm digit, 1 ; common name for digit
.comm number, 1 ; common name for number
.global number, digit

# --------
.text
.global setup_ports
.global show_number
.global select_digit

setup_ports:  ; logic to set ports into output mode
  ldi r18, 0b11111100 ; 1 = output mode, set PORT D
  out 0x0A, r18
  ldi r19, 0b00011111 ; set PORT B
  out 0x04, r19      
  ret ; setup_ports

select_digit: ; logic to select correct digit across the four segments
  pushall
  lds r20, digit  ; use "digit" to find values to be sent
  inc r20
  ldi r26, lo8(digit_table) ; x register
  ldi r27, hi8(digit_table)
l1:
  ld r21, x+
  dec r20
  breq found
  jmp l1
found:
  out 0x05, r21 ; PORTB.
  popall
  ret ; select_digit

show_number:  ; set segment in the 4x7
  call select_digit
  pushall
  lds r23, number ; use "number" to find values to be sent
  inc r23
  ldi r28, lo8(portb_table) ; y register
  ldi r29, hi8(portb_table)
  ldi r30, lo8(portd_table) ; z register
  ldi r31, hi8(portd_table)

; iterate over portD table, {number} many times
l2:
  ld r22, y+
  ld r24, z+
  dec r23
  breq here
  jmp l2
here:
  out 0x0b, r24 ; PORTD
  cpi r22, 0
BRNE one
zero:
  ; if register.val == 0
  cbi 0x05, 0 ; clear
  jmp done
one:  
  ; if register.val == 1
  sbi 0x05, 0 ; set
done:       
  popall
  ret ; show_number
