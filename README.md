# Bidirectional FPGA Counter with Dynamic Speed Control

A 32-bit signed counter implementation for the Nexys A7, featuring real-time speed adjustment and two's complement visualization.

## Features

- **32-bit Signed Counter:** Parameterized design supporting both upwards and downwards counting with enable signal.
- **Dynamic Clock Divider:** Real-time frequency adjustment (100MHz base) via hardware buttons with safety bounds.
- **Smart 7-Segment Control:** - 1kHz multiplexing frequency for flicker-free display across 8 digits.
    - Automatic magnitude calculation for negative numbers.
    - Intelligent sign detection (shows '-' on the leftmost display only when needed).
- **Hardware Robustness:** - Full debouncing on all mechanical button inputs.
    - Synchronous edge detection for state changes (Mode/Speed).
    - Asynchronous reset logic.
- **Hardware Verified:** Fully tested on Digilent Nexys A7 (Artix-7).

## Simulation Results

- **Async Reset:** Verified to clear all registers immediately regardless of clock state.
- **Enable Logic:** Successfully pauses counting while maintaining the current value in memory.
- **Multiplexing:** Verified 1kHz iteration from Display 0 to 7.
- **Signed Arithmetic:** Verified transition from `0` to `-1` and correct magnitude conversion.
- **Debouncing:** Verified pulse generation only after signal stabilization.
- **Dynamic Speed:** Verified real-time `LIMIT` updates without glitches.
- Verified **7-segments display**, displaying '-' symbol for negative numbers
- Verified **clock divider** 100Mhz -> 1Hz
- Verified **parameters** work correctly on modules and they are reusable
- Verified **multiple clk** working at diferent speeds
- Verified **speed_up and down**, **count_up and down**

## Module Hierarchy

- `counter_top.sv`: Top-level module coordinating data flow and peripheral mapping.
  - `debouncer.sv`: Filters mechanical noise from buttons.
  - `clock_divider.sv`: Generates counting pulses with dynamic limit comparison (`>=`).
  - `counter.sv`: Core arithmetic unit handling `signed` addition and subtraction.
  - `seven_seg_selector.sv`: Handles the high-speed scanning of anodes (8 displays).
  - `seven_seg_decoder.sv`: BCD to 7-segment converter with a dedicated "Negative Mode".

## Hardware Interface (Pin Mapping)

| Component | Pin (Nexys A7) | Function |
| :--- | :--- | :--- |
| **BTNC** | `N17` | Asynchronous System Reset |
| **SW0** | `J15` | Global Enable (Pause/Run) |
| **BTNU** | `M18` | Set direction to **UP** |
| **BTND** | `P18` | Set direction to **DOWN** |
| **BTNR** | `M17` | **Speed Up** (Decrease clock limit) |
| **BTNL** | `P17` | **Speed Down** (Increase clock limit) |
| **LED 0**| `H17` | **Enable Status** Monitor **Led** |


## Technical Implementation Details

### Two's Complement Visualization
To ensure human-readable display of negative numbers:
1. The system detects the sign bit (`count[31]`).
2. It calculates the absolute magnitude using `twos_comp_count = -count`.
3. When `select == 3'b111` (leftmost display) and the number is negative, it sends a special code (`4'hF`) to the decoder to trigger the **G-segment** only (the minus sign).

### General Implementation Details
- 32-bit counter with enable control and parameters
- Clock divider wiht parameters 100MHz -> 1 Hz for visual purposes in FPGA
- 7-segment decoder BCD to segments. Displays the hex number in the 7-segment
- 7-segment selector to activate an with active-low. Based on clock at 1Khz chooses which 7-seg activate, only one at a time.
- Choose the bits of 32-bit counter that are for each 7-segment display. Display 0=[3:0], Display 1=[7:4]
- Asynchronous reset
- Speed up and down the clock for counting numbers with buttons
- Implemented button debouncing
- Hardware verified on Nexys A7

## What I Learned

- **Clock Domain Management:** Handling multiple frequencies (100MHz, 1kHz, variable Hz).
- **7-Segment Multiplexing:** Controlling 8 displays using a single decoder through rapid switching.
- **Two's Complement Logic:** Converting raw signed bits into human-readable magnitude + sign.
- **Physical Constraints:** Mapping SystemVerilog ports to physical FPGA pins via `.xdc` files.
- **Dynamic Parameters:** Modifying hardware behavior (speed) at runtime without re-synthesis.
- **Complete FPGA workflow**
- **Button debouncing:** Generate the pulse only after signal stabilization

## Ideas for expansion
- Using the buttons SW15..0 of the Nexys A7 to count by +- 1, 2, 3, 4... 
- Monitor the status of all buttons SW15..0 with LEDS
- If !enable, display in 7-seg = [-][E][N][A] [B][L][E][D]. 
