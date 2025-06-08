# Lab5 - Semi CPU OpenLane Project

This repository contains Verilog modules for a simplified CPU designed as part of Lab 5.

## Modules
- `alu.v`: 7-operation ALU including ADD, SUB, SHIFT, ADDI, SUBI
- `regfile.v`: 32x32-bit register file
- `instruction_decoder.v`: Loads 6 default instructions (ADDI, ADD, SUBI, SHIFTL)
- `seven_segment_display.v`: Displays ALU result on a 7-segment display
- `top.v`: Connects all modules together

## How to use with OpenLane
1. Copy the `semi_cpu_project` folder to `OpenLane/designs/semi_cpu/`
2. Open OpenLane terminal:
    ```bash
    make mount
    ./flow.tcl -design semi_cpu -init_design_config -src "src/*.v"
    ./flow.tcl -design semi_cpu
    ```
3. View GDS in KLayout:
    ```bash
    klayout ./designs/semi_cpu/runs/<run-id>/final/gds/semi_cpu.gds
    ```

## Notes
⚠️ OpenLane setup was not completed due to WSL/Ubuntu issues, so GDS and layout generation steps were not run.

However, all modules and directory structure are fully ready for OpenLane synthesis and flow.