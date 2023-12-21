# Seven-Segment LED Display

## Overview

This project involves a C++ implementation for displaying numbers 0 to 9 sequentially on a Common Anode 7-segment LED display. It provides a scalable solution for various applications requiring numeric displays.

## Hardware Requirements

- Common Anode 7-segment LED display
- Microcontroller board (e.g., Arduino)
- Jumper wires

## Pin Configuration

- `pinA`: 2
- `pinB`: 3
- `pinC`: 4
- `pinD`: 5
- `pinE`: 6
- `pinF`: 7
- `pinG`: 8
- `D1`: 9
- `D2`: 10
- `D3`: 11
- `D4`: 12

## How to Use

1. Connect the 7-segment LED display to the microcontroller board according to the pin configuration.

2. Upload the provided C++ code to your microcontroller board.

3. Run the code, and the display will sequentially show numbers 0 to 9.

## Functions

- `setup_ports`: Initializes the digital pins as outputs.

- `show_number`: Displays a specific number on the 7-segment LED display.

- `select_digit`: Selects the digit on the display.

## Code Structure

The code consists of setup routines, loop functions, and specific functions for the C++ and AVR versions. It includes macros for setup, digit and port tables, and functions for displaying numbers and selecting digits.

## Author

- Trent Tucker
