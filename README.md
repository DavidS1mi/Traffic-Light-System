# SystemVerilog Traffic Light Controller

## NOTE! THE PROJECT IS NOT YET FINISHED AND IS BEING HELD ON DUE UNTIL THE END OF THIS DAY TO BE SUCCESFULLY TESTED ON AN FPGA BOARD!!

## Overview
This project contains a complete structural RTL implementation of a traffic light controller designed in SystemVerilog. The project combines a Finite State Machine (FSM) with a datapath consisting of a ROM, a countdown timer, a change detector, and a multiplexer. It also includes a clock divider module (`clk_delay`) for real-time hardware implementation and a comprehensive testbench for simulation.

At the core of this project is a central controller that knows the exact sequence of the lights: Green, Yellow, Red, and then Flashing. To figure out how long each light should stay on, it checks a built-in rulebook (a memory table) and sends that specific duration to a countdown timer. Whenever the light sequence moves to the next color, a built-in sensor detects the change and tells the timer to restart with the new time. Finally, because the computer's internal clock ticks millions of times per second, there is a special "speed bump" module that slows the entire system down so we can actually see the lights change at a normal human pace.

## Module Hierarchy
- `top` - Top-level wrapper connecting the clock divider and the DUT.
  - `clk_delay` - 32-bit clock divider.
  - `traffic_light` - The core Device Under Test (DUT).
    - `traffic_light_fsm` - Control logic for light states.
    - `ROM` - Read-Only Memory mapping states to timer values.
    - `change_detector` - Detects state changes to trigger timer loads.
    - `mux` - Multiplexer for alternating the flash state.
    - `countdown_timer` - Tracks duration of each light state.

## Simulation and Testing
A complete testbench (`traffic_tb`) is included to verify the core logic. 
* The testbench directly instantiates the `traffic_light` DUT, bypassing the `clk_delay` module. This allows for rapid simulation without needing to simulate millions of unnecessary clock cycles.
* It simulates the `walk` button inputs and asserts reset sequences to verify correct state transitions and timer underflows.

## Hardware Implementation Notes
When synthesizing for an FPGA, the `top` module should be used as the top-level entity. It utilizes the `clk_delay` module to step down a standard high-frequency board clock (e.g., 100MHz) to a visible, human-scale frequency using the 27th bit of the counter.
