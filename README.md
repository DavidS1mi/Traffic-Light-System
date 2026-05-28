# SystemVerilog Traffic Light Controller

## Overview
This project contains a complete structural RTL implementation of a traffic light controller designed in SystemVerilog.It combines a Finite State Machine (FSM) with a datapath consisting of a ROM, a countdown timer, a change detector, and a multiplexer. It also includes a clock divider module (`clk_delay`) for real-time hardware implementation and a comprehensive testbench for simulation.

At the core of this project is a central controller that knows the exact sequence of the lights: Green, Yellow, Red, and then Flashing. To figure out how long each light should stay on, it checks a built-in memory table and sends that specific duration to a countdown timer. Whenever the light sequence moves to the next color, a built-in sensor detects the change and tells the timer to restart with the new time. Finally, because the computer's internal clock ticks millions of times per second, there is a special module that slows the entire system down so we can actually see the lights change at a normal human pace.

# Schematic

# traffic_light module:
<img width="1674" height="569" alt="image" src="https://github.com/user-attachments/assets/d9d9c206-820b-46a8-8d93-65aa7757a050" />

# clk_delay module:
<img width="937" height="340" alt="image" src="https://github.com/user-attachments/assets/71bdfad6-f61d-4c16-a785-4423ea0d7084" />

# Top module:
<img width="1144" height="497" alt="image" src="https://github.com/user-attachments/assets/d422a4e6-d951-45d7-8fac-3a9f65658f42" />

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
<img width="1679" height="218" alt="image" src="https://github.com/user-attachments/assets/4b3d65bd-4719-493f-a9d7-994f3b7a62ed" />

A complete testbench (`traffic_tb`) is included to verify the core logic. 
* The testbench directly instantiates the `traffic_light` DUT, bypassing the `clk_delay` module. This allows for rapid simulation without needing to simulate millions of unnecessary clock cycles.
* It simulates the `walk` button inputs and asserts reset sequences to verify correct state transitions and timer underflows.

## Hardware Implementation Notes
When synthesizing for an FPGA, the `top` module should be used as the top-level entity. It utilizes the `clk_delay` module to step down a standard high-frequency board clock (e.g., 100MHz) to a visible, human-scale frequency using the 27th bit of the counter.

# Implementation on the FPGA board:


https://github.com/user-attachments/assets/3f061761-5554-40a6-8204-701b1d48a3d8




