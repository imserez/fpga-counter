# FPGA Counter

16-bit counter with enable control for Nexys A7.

## Features

- 16-bit counter with enable control
- Clock divider 100MHz -> 1 Hz
- 7-segment decoder BCD to segments
- Asynchronous reset
- Hardware verified on Nexys A7

## Hardware Demo

- Displays shows 4 LSB as digit 0-9
- Counts every second
- SW0: enable/pause counting
- BTNC N17 sets reset to 1

## Simulation results

- Verified that reset is async and works at any time
- Enable signal successfully pauses counting
- Counter maintains value when enable is 0
- Verified 7-segments display
- Verified clock divider 100Mhz -> 1Hz

## What I learned

- Clock domain
- 7-segment display multiplexing basics
- Constraints file, mapping physical pins to simulation
- Complete FPGA workflow

## Next Steps

- Increment/decrement speed of clock divider with M18 & P18 of Nexys A7
- Multiplex 4 digits
- Add button debouncing
- Show full 16-bit value across displays in hex
- Use of all 8 seven-segment displays, controlled bi V10, V11, V12... T8.
- Toggle leds LD15..0 if SW15..0 is on/off
- Use P17 to count downwards
- Use M17 to count upwards
