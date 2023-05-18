#!/bin/bash

# Entities
ghdl -a mux4x1.vhd
ghdl -a mux2x1.vhd
ghdl -a ula.vhd
ghdl -a reg.vhd
ghdl -a reg_14.vhd
ghdl -a reg_bank.vhd
ghdl -a pc.vhd
ghdl -a rom.vhd
ghdl -a state_machine.vhd
ghdl -a control_unit.vhd
ghdl -a processor.vhd

# Testbanch
ghdl -a test/processor_tb.vhd

# Run and view waveform on gtkwave
ghdl -r processor_tb --wave=compiled/processor_tb.ghw
gtkwave compiled/processor_tb.ghw 