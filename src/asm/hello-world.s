PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000
RW = %01000000
RS = %00100000

  .org $8000

reset:
  lda #%11111111 ; set all pins on port B to output
  sta DDRB
  lda #%11100000 ; set top 3 pins on port A to output
  sta DDRA
  lda #%00111000 ; set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; display on; cursor on ; blink off
  jsr lcd_instruction
  lda #%00000110 ; increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #%00000001 ; clear the display
  jsr lcd_instruction

  lda #"H"
  jsr print_char
  lda #"e"
  jsr print_char
  lda #"l"
  jsr print_char
  lda #"l"
  jsr print_char
  lda #"o"
  jsr print_char
  lda #","
  jsr print_char
  lda #" "
  jsr print_char
  lda #"w"
  jsr print_char
  lda #"o"
  jsr print_char
  lda #"r"
  jsr print_char
  lda #"l"
  jsr print_char
  lda #"d"
  jsr print_char
  lda #"!"
  jsr print_char

lcd_instruction:
  sta PORTB
  lda #0         ; clear RS/RW/E bits
  sta PORTA
  lda #E         ; set E (enable) bit ot send instruction
  sta PORTA
  lda #0         ; clear RS/RW/E bits
  sta PORTA
  rts

print_char:
  sta PORTB
  lda #RS       ; set RS; clear RW/E bits
  sta PORTA
  lda #(RS | E) ; set E bit to send instruction
  sta PORTA
  lda #RS       ; clear E bit
  sta PORTA
  rts

  .org $fffc
  .word reset
  .word $0000
