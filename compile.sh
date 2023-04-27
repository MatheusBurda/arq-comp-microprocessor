#!/bin/bash

ghdl -a mux4x1.vhd
ghdl -a mux2x1.vhd
ghdl -a ula.vhd
ghdl -a reg.vhd
ghdl -a reg_bank.vhd
ghdl -a pc.vhd
ghdl -a processor.vhd
ghdl -a pc_tb.vhd

ghdl -r pc_tb --wave=compiled/pc_tb.ghw
gtkwave compiled/pc_tb.ghw 