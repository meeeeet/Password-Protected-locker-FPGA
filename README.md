# Password Protected Locker

A 10-bit password protected locker with buzzer alarm feature.

### Pin Description:
Input Pins:
- Clk - Clock signal
- Digit(10 bit) - To input hex number
- Reset - To reset the password
- Start - To start locker

Output Pins:
- Out - Indicate the password is correct or not
- Buzzer - To drive the buzzer
- Disp0 to Disp3 - To control 7 Segment Display

### Features:
- Total possibilites of unique password is 1024, each digit have 2 possibilites (i.e. 0 or 1)
- Password can be change at any time
- After 4 continuous wrong attemps the buzzer will automatically ON. To OFF the buzzer user have to enter the right password

### Device and Tool
- Device: Altera DE1 Board (Cyclone II EP2C20F484C7)
- Tool: Quartus ii 13.0sp1
