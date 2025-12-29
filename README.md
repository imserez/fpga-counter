# FPGA Counter

16-bit counter with enable control for Nexys A7.

## Features

- 16-bit counter (0-65535)
- Incremenets by 1 on each clock cycle
- Asynchronous reset
- Enable signal to pause/resume counting

## Simulation results

- Verified that reset is async and works at any time
- Enable signal successfully pauses counting
- Counter maintains value when enable is 0

## What I learned (Day 1)

- SystemVerilog syntax
- How to write testbenches
- Vivado simuation workflow

## Next Steps

- Clock divider for visible counting
- 7-segment display decoder
- Hardware implementation on Nexys A7
