# Project 3 – Seven Segment Decoder (OpenLane Ready)

This project implements a 7-segment display decoder for digits 0 to 5, written in Verilog and structured for ASIC synthesis using OpenLane.

## 📁 Structure

```
project3/
├── config.json
├── pin_order.cfg
├── README.md
├── .gitignore
└── src/
    └── seven_segment_decoder.v
```

## 🔧 Module: SevenSegmentDecoder

### Inputs
- `digit [3:0]`: 4-bit input digit

### Outputs
- `seg [6:0]`: Output to 7-segment display (active-low)

## 🛠 Tools
- OpenLane
- Sky130 PDK

## 📝 Notes
- Use `flow.tcl -design project3` inside OpenLane terminal
