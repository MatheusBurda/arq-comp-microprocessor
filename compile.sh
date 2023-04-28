#!/bin/bash

ghdl -a mux4x1.vhd
ghdl -a mux2x1.vhd
ghdl -a ula.vhd
ghdl -a reg.vhd
ghdl -a reg_bank.vhd
ghdl -a pc.vhd
ghdl -a rom.vhd
ghdl -a processor.vhd
ghdl -a state_machine.vhd
ghdl -a control_unit.vhd
ghdl -a control_unit_tb.vhd

ghdl -r control_unit_tb --wave=compiled/control_unit_tb.ghw
gtkwave compiled/control_unit_tb.ghw 