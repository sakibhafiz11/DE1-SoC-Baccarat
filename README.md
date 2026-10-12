# DE1-SoC Baccarat Card Game

A hardware implementation of the Baccarat (Punto Banco) 
card game built on the DE1-SoC FPGA development board 
using SystemVerilog.

<img width="3024" height="4032" alt="IMG_7281" src="https://github.com/user-attachments/assets/40df2f38-d279-4f12-9a36-5a9de667e1a5" />

## Hardware
- DE1-SoC Development Board (Cyclone V - 5CSEMA5F31C6)
- Quartus Prime Lite 25.1
- Questa FSE (simulation)

## How It Works
- Press KEY3 to reset and start a new game
- Press KEY0 to deal each card one at a time
- HEX0-2 display Player cards
- HEX3-5 display Dealer cards
- LEDR3-0 shows Player score in binary
- LEDR7-4 shows Dealer score in binary
- LEDR8 lights up when Player wins
- LEDR9 lights up when Dealer wins

## Example Game
Cards Dealt:
- Player: Jack(0) + 6 = 6 → Player stands
- Dealer: Ace(1) + 2 = 3 → Dealer draws 3rd card = 5
- Final: Player=6, Dealer=8 → Dealer wins! LEDR9 ON

## Modules
- card7seg.sv     → 7-segment display decoder
- dealcard.sv     → Random card generator (1-13)
- reg4.sv         → 4-bit register with enable
- scorehand.sv    → Hand score calculator
- datapath.sv     → Connects all data modules
- statemachine.sv → Game flow controller (Moore FSM)
- task5.sv        → Top level module

## Skill
- SystemVerilog HDL
- Moore FSM design
- FPGA synthesis and implementation
- Hardware simulation (Questa)
- DE1-SoC board programming via JTAG
