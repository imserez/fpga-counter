# FPGA Counter

16-bit counter with enable control for Nexys A7.

## Features

- 32-bit counter with enable control and parameters
- Clock divider wiht parameters 100MHz -> 1 Hz for visual purposes in FPGA
- 7-segment decoder BCD to segments. Displays the hex number in the 7-segment
- 7-segment selector to activate an with active-low. Based on clock at 1Khz chooses which 7-seg activate, only one at a time.
- Choose the bits of 32-bit counter that are for each 7-segment display. Display 0=[3:0], Display 1=[7:4]
- Asynchronous reset
- Speed up and down the clock for counting numbers with buttons
- Implemented button debouncing
- Hardware verified on Nexys A7

## Hardware Demo

- Displays shows 4 LSB as digit 0-9
- Counts every second
- SW0: enable/pause counting
- BTNC N17 sets reset to 1
- BTNC: M17 speeds_up the clock and P17 slows down the clock for counting
- LED_15 is mapped to enable signal of the button J15
- BTNC: M18 sets the count upwards and P18 sets the count downwards
- 7-segment displays shows '-' on two's complement negative numbers

## Simulation results

- Verified that reset is async and works at any time
- Enable signal successfully pauses counting
- Counter maintains value when enable is 0
- Verified 7-segments display
- Verified clock divider 100Mhz -> 1Hz
- Verified segmentor select based on clock, iterating at 1Khz from 0-7.
- Verified parameters work correctly on modules and they are reusable
- Verified multiple clk working at diferent speeds
- Verified button debouncing
- Verified speed_up and down
- Verified count_up and down
- Verified 7-seg display for negative numbers

## What I learned

- Clock domain
- 7-segment display multiplexing basics
- Constraints file, mapping physical pins to simulation
- Complete FPGA workflow
- Reusable modules with parameters
- Button debouncing
- Dynamic singals for parameters in runtime
- Working with 2's complements negative numbers

## Next Steps

